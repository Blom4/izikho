import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/providers/supabase_provider.dart';
import '../../common/providers/game_online_provider.dart';
import '../../common/models/game_playing_card.dart';
import '../models/fivecards_game_model.dart';

part 'fivecards_game_provider.g.dart';

@riverpod
class FivecardsGame extends _$FivecardsGame {
  @override
  FivecardsGameState build(FivecardsGameModel game) {
    final asyncGame = ref.watch(gameOnlineProvider(game.id));
    return asyncGame.when(
      data: (data) => FivecardsGameState(data: data as FivecardsGameModel),
      error: (error, stackTrace) => FivecardsGameState.error(
        data: game,
        error: error.toString(),
      ),
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

  Future<void> play(GamePlayingCard card) async {
    if (!state.data.currentPlayer.isTurn) {
      throw Exception('Sorry, is not your turn');
    }
    if (state.data.currentPlayer.cards.length < 6) {
      throw Exception('Please pop a deck or played card to player');
    }

    try {
      state = FivecardsGameState.loading(data: state.data);
      final res = await _supabase.from('games').upsert({
        'id': game.id,
        ...state.data.nextPlayState(card).toMap(),
      }).select();
      state = FivecardsGameState(data: FivecardsGameModel.fromMap(res.first));
    } catch (e) {
      state = FivecardsGameState.error(data: state.data, error: e.toString());
    }
  }

  void popDeck() {
    if (!state.data.currentPlayer.isTurn) {
      throw Exception('Sorry, is not your turn');
    }
    if (state.data.currentPlayer.cards.length >= 6) {
      throw Exception('Card already popped so please play');
    }
    state = FivecardsGameState(data: state.data.nextDeckState());
  }

  void popPlayedCard() {
    if (!state.data.currentPlayer.isTurn) {
      throw Exception('Sorry, is not your turn');
    }
    if (state.data.currentPlayer.cards.length >= 6) {
      throw Exception('Card already popped so please play');
    }

    state = FivecardsGameState(data: state.data.nextPlayedCardsState());
  }

  void sortPlayerCards() {
    print('sorting');
    state = FivecardsGameState(data: state.data.meWithSortedCards());
  }

  SupabaseClient get _supabase => ref.read(supabaseProvider);
}
