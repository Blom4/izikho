import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/player.dart';

final krusaidPlayerProvider =
    NotifierProvider<KrusaidPlayerNotifier, Player>(KrusaidPlayerNotifier.new);

class KrusaidPlayerNotifier extends Notifier<Player> {
  @override
  build() {
    return Player(
      id: "",
      username: "",
      index: -1,
    );
  }

  Player createPlayer({
    required String username,
    required int index,
  }) {
    return state.copyWith(
      username: username,
      index: index,
      isTurn: true,
    );
  }

  set player(Player player) {
    state = player;
  }

  Player joinRoom({
    required String username,
  }) {
    return state.copyWith(
      username: username,
    );
  }
}
