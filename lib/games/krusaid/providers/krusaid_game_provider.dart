import 'package:izikho/games/common/providers/game_provider.dart';
import 'package:izikho/games/krusaid/models/krusaid_game_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/providers/supabase_provider.dart';
import '../components/play_card.dart';

part 'krusaid_game_provider.g.dart';

@riverpod
class KrusaidGame extends _$KrusaidGame {
  @override
  Stream<KrusaidGameModel> build([String? channel]) async* {
    if (channel == null) {
      throw Exception('Please provide a channel');
    }
    var game =
        await ref.watch(gameProvider(channel).future) as KrusaidGameModel;

    if (!game.served) {
      final gameMap = await _supabase.from('games').upsert({
        'id': game.id,
        ...game.serveCards(4).copyWith(started: true).toMap(),
      }).select();
      game = KrusaidGameModel.fromMap(gameMap.first);
    }
    yield game;
  }


  

  Future<void> play({required PlayCard card, PlayCard? playable}) async {
    final game = await future;
    await _supabase.from('games').upsert({
      'id': game.id,
      ...game.nextState(card: card, playable: playable).toMap(),
    }).select();
  }

  SupabaseClient get _supabase => ref.read(supabaseProvider);
}
