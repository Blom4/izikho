import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/providers/supabase_provider.dart';
import '../../common/providers/online_game_provider.dart';
import '../models/play_card.dart';
import '../models/krusaid_game_model.dart';
import '../models/krusaid_player_model.dart';

part 'krusaid_game_provider.g.dart';

@riverpod
class KrusaidGame extends _$KrusaidGame {
  @override
  KrusaidGameState build(KrusaidGameModel game) {
    final asyncGame = ref.watch(onlineGameProvider(game.id));
    return asyncGame.when(
      data: (data) => KrusaidGameState(data: data as KrusaidGameModel),
      error: (error, stackTrace) =>
          KrusaidGameState.error(data: game, error: error.toString()),
      loading: () => KrusaidGameState.loading(data: game),
    );
  }

  Future<void> serveCards(int numOfCards) async {
    try {
      if (!state.data.served && state.data.allJoined) {
        state = KrusaidGameState.loading(data: game);
        final res = await _supabase.from('games').upsert({
          'id': game.id,
          ...state.data.serveCards().copyWith(started: true).toMap(),
        }).select();
        state = KrusaidGameState(data: KrusaidGameModel.fromMap(res.first));
      }
    } catch (e) {
      state = KrusaidGameState.error(error: e.toString(), data: game);
    }
  }

  Future<void> play(PlayCard card, Playable playable) async {
    try {
      if (state.data.currentPlayer.isTurn) {
        state = KrusaidGameState.loading(data: state.data);
        final res = await _supabase.from('games').upsert({
          'id': game.id,
          ...state.data.nextPlayState(card, playable).toMap(),
        }).select();
        state = KrusaidGameState(data: KrusaidGameModel.fromMap(res.first));
      }
    } catch (e) {
      state = KrusaidGameState.error(data: state.data, error: e.toString());
    }
  }

  void popDeck() {
    if (state.data.currentPlayer.isTurn) {
      state = KrusaidGameState(data: state.data.nextDeckState());
    }
  }

  Future<void> acceptShot(KrusaidPlayerModel shotPlayer) async {
    try {
      if (state.data.currentPlayer.isTurn) {
        state = KrusaidGameState.loading(data: state.data);
        final res = await _supabase.from('games').upsert({
          'id': game.id,
          ...state.data.nextShotState(shotPlayer).toMap(),
        }).select();
        state = KrusaidGameState(data: KrusaidGameModel.fromMap(res.first));
      }
    } catch (e) {
      state = KrusaidGameState.error(data: state.data, error: e.toString());
    }
  }

  Future<void> playDeck() async {
    try {
      if (state.data.currentPlayer.isTurn) {
        state = KrusaidGameState.loading(data: state.data);
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
        state = KrusaidGameState(data: KrusaidGameModel.fromMap(res.first));
      }
    } catch (e) {
      state = KrusaidGameState.error(data: state.data, error: e.toString());
    }
  }

  SupabaseClient get _supabase => ref.read(supabaseProvider);
}
