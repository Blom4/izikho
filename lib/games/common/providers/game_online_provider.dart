import 'package:izikho/games/fivecards/models/fivecards_game_model.dart';
import 'package:izikho/games/fivecards/models/fivecards_player_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../auth/model/profile_model.dart';
import '../../../auth/providers/profile_provider.dart';
import '../../../common/providers/supabase_provider.dart';
import '../models/game_deck.dart';
import '../../krusaid/models/krusaid_game_model.dart';
import '../../krusaid/models/krusaid_player_model.dart';
import '../models/game_model.dart';
import '../models/player_model.dart';
import '../utils/game_utils.dart';
part 'game_online_provider.g.dart';

@riverpod
class GameOnline extends _$GameOnline {
  @override
  Stream<GameModel> build([String? channel]) async* {
    if (channel == null) {
      throw Exception('Please provide a channel');
    }
    await for (final games in _gameStream.eq('id', channel)) {
      switch (GameUtils.getGameType(games.first)) {
        case GameType.krusaid:
          final profile = await _getProfile();
          yield KrusaidGameModel.fromMap(games.first)
              .copyWith(profileId: profile.id);
        case GameType.fivecards:
          final profile = await _getProfile();
          yield FivecardsGameModel.fromMap(games.first)
              .copyWith(profileId: profile.id);
        default:
          throw UnimplementedError();
      }
    }
  }

  Future<String> createGame(GameOptions gameOptions) async {
    final currentPlayer = PlayerModel.fromProfile(
      await _getProfile(),
      playerType: gameOptions.gamePlayerType,
    );

    final newGameMap = switch (gameOptions.gameType) {
      GameType.krusaid => () {
          final krusaidGameOptions = gameOptions as KrusaidGameOptions;
          final krusaidPlayers =
              [currentPlayer, ...gameOptions.players].indexed.map(
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
            gameType: gameOptions.gameType,
            gameMode: gameOptions.gameMode,
            players: krusaidPlayers,
            deck: GameDeck.myStandardFiftyFourCardDeck(),
            servedCards: krusaidGameOptions.servedCards,
          ).toMap();
        }(),
      GameType.fivecards => () {
          final fivecardsGameOptions = gameOptions as FivecardsGameOptions;
          final fivecardsPlayers =
              [currentPlayer, ...gameOptions.players].indexed.map(
            (element) {
              var (i, e) = element;
              if (i == 0) {
                return FivecardsPlayerModel(
                  id: e.id,
                  username: e.username,
                  index: i,
                  joined: true,
                  isOwner: true,
                  isTurn: true,
                );
              }
              return FivecardsPlayerModel(
                id: e.id,
                username: e.username,
                index: i,
              );
            },
          ).toList();

          return FivecardsGameModel(
            gameType: gameOptions.gameType,
            gameMode: gameOptions.gameMode,
            players: fivecardsPlayers,
            deck: GameDeck.myStandardFiftyFourCardDeck(),
            servedCards: fivecardsGameOptions.servedCards,
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

    final gameMap = switch (GameUtils.getGameType(gameResponse)) {
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
      GameType.fivecards => () {
          final fivecardsGame = FivecardsGameModel.fromMap(gameResponse);

          return fivecardsGame.copyWith(
            players: [
              for (final player in fivecardsGame.players)
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
