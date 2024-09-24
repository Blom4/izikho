import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/providers/supabase_provider.dart';
import '../../common/providers/game_online_provider.dart';
import '../../common/models/game_playing_card.dart';
import '../models/ak47_game_model.dart';
import '../models/ak47_player_model.dart';

part 'ak47_game_provider.g.dart';

@riverpod
class Ak47Game extends _$Ak47Game {
  @override
  Ak47GameState build(Ak47GameModel game) {
    final asyncGame = ref.watch(gameOnlineProvider(game.id));
    return asyncGame.when(
      data: (data) => Ak47GameState(data: data as Ak47GameModel),
      error: (error, stackTrace) =>
          Ak47GameState.error(data: game, error: error.toString()),
      loading: () => Ak47GameState.loading(data: game),
    );
  }

  Future<void> serveCards(int numOfCards) async {
    try {
      if (!state.data.served && state.data.allJoined) {
        state = Ak47GameState.loading(data: game);
        final res = await _supabase.from('games').upsert({
          'id': game.id,
          ...state.data.serveCards().copyWith(started: true).toMap(),
        }).select();
        state = Ak47GameState(data: Ak47GameModel.fromMap(res.first));
      }
    } catch (e) {
      state = Ak47GameState.error(error: e.toString(), data: game);
    }
  }

  Future<void> play(GamePlayingCard card, Playable playable) async {
    try {
      if (state.data.currentPlayer.isTurn) {
        state = Ak47GameState.loading(data: state.data);
        final res = await _supabase.from('games').upsert({
          'id': game.id,
          ...state.data.nextPlayState(card, playable).toMap(),
        }).select();
        state = Ak47GameState(data: Ak47GameModel.fromMap(res.first));
      }
    } catch (e) {
      state = Ak47GameState.error(data: state.data, error: e.toString());
    }
  }

  void popDeck() {
    if (state.data.currentPlayer.isTurn) {
      state = Ak47GameState(data: state.data.nextDeckState());
    }
  }

  Future<void> acceptShot(Ak47PlayerModel shotPlayer) async {
    try {
      if (state.data.currentPlayer.isTurn) {
        state = Ak47GameState.loading(data: state.data);
        final res = await _supabase.from('games').upsert({
          'id': game.id,
          ...state.data.nextShotState(shotPlayer).toMap(),
        }).select();
        state = Ak47GameState(data: Ak47GameModel.fromMap(res.first));
      }
    } catch (e) {
      state = Ak47GameState.error(data: state.data, error: e.toString());
    }
  }

  Future<void> playDeck() async {
    try {
      if (state.data.currentPlayer.isTurn) {
        state = Ak47GameState.loading(data: state.data);
        final nextPlayer = state.data.getNextPlayer();
        final res = await _supabase.from('games').upsert({
          'id': game.id,
          ...state.data.copyWith(
            turnIndex: nextPlayer.index,
            players: [
              for (var player in state.data.players)
                if (player.index == nextPlayer.index)
                  nextPlayer
                else if (player.isTurn)
                  player.copyWith(isTurn: false)
                else
                  player
            ],
          ).toMap(),
        }).select();
        state = Ak47GameState(data: Ak47GameModel.fromMap(res.first));
      }
    } catch (e) {
      state = Ak47GameState.error(data: state.data, error: e.toString());
    }
  }

  SupabaseClient get _supabase => ref.read(supabaseProvider);
}
