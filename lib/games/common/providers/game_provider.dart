import 'package:izikho/auth/model/profile_model.dart';
import 'package:izikho/auth/providers/profile_provider.dart';
import 'package:izikho/common/providers/supabase_provider.dart';
import 'package:izikho/games/common/models/player_model.dart';
import 'package:izikho/games/krusaid/models/krusaid_player_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../krusaid/models/deck.dart';
import '../../krusaid/models/krusaid_game_model.dart';
import '../models/game_model.dart';
import '../utils/utils.dart';
part 'game_provider.g.dart';

@riverpod
class Game extends _$Game {
  @override
  Stream<GameModel> build([String? channel]) async* {
    if (channel == null) {
      throw Exception('Please provide a channel');
    }
    await for (final games in _gameStream.eq('id', channel)) {
      switch (getGameType(games.first)) {
        case GameType.krusaid:
          final profile = await _getProfile();
          yield KrusaidGameModel.fromMap(games.first)
              .copyWith(profileId: profile.id);
        default:
          throw UnimplementedError();
      }
    }
  }

  Future<String> createGame(
    GameType gameType,
    List<PlayerModel> players,
    String message,
  ) async {
    final currentPlayer = PlayerModel.fromProfile(await _getProfile());

    final newGameMap = switch (gameType) {
      GameType.krusaid => () {
          final krusaidPlayers = [currentPlayer, ...players].indexed.map(
            (element) {
              var (i, e) = element;
              if (i == 0) {
                return KrusaidPlayerModel(
                  id: e.id,
                  username: e.username,
                  index: i,
                  joined: true,
                  isOwner: true,
                  isTurn: true,
                );
              }
              return KrusaidPlayerModel(
                id: e.id,
                username: e.username,
                index: i,
              );
            },
          ).toList();

          return KrusaidGameModel(
            gameType: gameType,
            players: krusaidPlayers,
            deck: myStandardFiftyFourCardDeck(),
          ).toMap();
        }(),
      _ => throw UnimplementedError(),
    };
    final response = await _supabase.from('games').insert(newGameMap).select();
    return response.first['id'] as String;
  }

  Future<void> joinGame(String channel) async {
    final [
      profile as ProfileModel,
      gameResponse as Map<String, dynamic>,
    ] = await Future.wait([_getProfile(), _getGameResponse(channel)]);

    final gameMap = switch (getGameType(gameResponse)) {
      GameType.krusaid => () {
          final krusaidGame = KrusaidGameModel.fromMap(gameResponse);

          return krusaidGame.copyWith(
            players: [
              for (final player in krusaidGame.players)
                if (player.id == profile.id)
                  player.copyWith(joined: true)
                else
                  player,
            ],
          ).toMap();
        }(),
      _ => throw UnimplementedError()
    };

    await _supabase.from('games').upsert({
      'id': gameResponse['id'],
      ...gameMap,
    });
  }

  SupabaseClient get _supabase => ref.read(supabaseProvider);

  SupabaseStreamFilterBuilder get _gameStream =>
      _supabase.from('games').stream(primaryKey: ['id']);

  Future<ProfileModel> _getProfile() async =>
      await ref.read(profileProvider.future);

  Future<Map<String, dynamic>> _getGameResponse(String channel) async =>
      await _supabase.from('games').select().eq('id', channel).single();
}
