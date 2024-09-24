import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/providers/supabase_provider.dart';
import '../../common/providers/game_online_provider.dart';
import '../../common/models/game_playing_card.dart';
import '../models/fivecards_game_model.dart';
import '../models/fivecards_player_model.dart';

part 'fivecards_game_provider.g.dart';

@riverpod
class FivecardsGame extends _$FivecardsGame {
  @override
  FivecardsGameState build(FivecardsGameModel game) {
    final asyncGame = ref.watch(gameOnlineProvider(game.id));
    return asyncGame.when(
      data: (data) => FivecardsGameState(data: data as FivecardsGameModel),
      error: (error, stackTrace) =>
          FivecardsGameState.error(data: game, error: error.toString()),
      loading: () => FivecardsGameState.loading(data: game),
    );
  }

  Future<void> serveCards(int numOfCards) async {
    try {
      if (!state.data.served && state.data.allJoined) {
        state = FivecardsGameState.loading(data: game);
        final res = await _supabase.from('games').upsert({
          'id': game.id,
          ...state.data.serveCards().copyWith(started: true).toMap(),
        }).select();
        state = FivecardsGameState(data: FivecardsGameModel.fromMap(res.first));
      }
    } catch (e) {
      state = FivecardsGameState.error(error: e.toString(), data: game);
    }
  }

  Future<void> play(GamePlayingCard card, Playable playable) async {
    try {
      if (state.data.currentPlayer.isTurn) {
        state = FivecardsGameState.loading(data: state.data);
        final res = await _supabase.from('games').upsert({
          'id': game.id,
          ...state.data.nextPlayState(card, playable).toMap(),
        }).select();
        state = FivecardsGameState(data: FivecardsGameModel.fromMap(res.first));
      }
    } catch (e) {
      state = FivecardsGameState.error(data: state.data, error: e.toString());
    }
  }

  void popDeck() {
    if (state.data.currentPlayer.isTurn) {
      state = FivecardsGameState(data: state.data.nextDeckState());
    }
  }

  Future<void> acceptShot(FivecardsPlayerModel shotPlayer) async {
    try {
      if (state.data.currentPlayer.isTurn) {
        state = FivecardsGameState.loading(data: state.data);
        final res = await _supabase.from('games').upsert({
          'id': game.id,
          ...state.data.nextShotState(shotPlayer).toMap(),
        }).select();
        state = FivecardsGameState(data: FivecardsGameModel.fromMap(res.first));
      }
    } catch (e) {
      state = FivecardsGameState.error(data: state.data, error: e.toString());
    }
  }

  Future<void> playDeck() async {
    try {
      if (state.data.currentPlayer.isTurn) {
        state = FivecardsGameState.loading(data: state.data);
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
        state = FivecardsGameState(data: FivecardsGameModel.fromMap(res.first));
      }
    } catch (e) {
      state = FivecardsGameState.error(data: state.data, error: e.toString());
    }
  }

  SupabaseClient get _supabase => ref.read(supabaseProvider);
}
