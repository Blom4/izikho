import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'offline_game_provider.g.dart';

@riverpod
OfflineGameMethods offlineGame(OfflineGameRef ref) {
  return OfflineGameMethods(ref);
}

class OfflineGameMethods {
  final Ref ref;

  OfflineGameMethods(this.ref);
  // void newGame(GameOptions options) {
  //   switch (options.gameType) {
  //     case GameType.morabaraba:
  //       ref.read(morabarabaGameProvider.notifier).startGame(
  //             options as MorabarabaGameOptions,
  //           );
  //       break;
  //     default:
  //       throw UnimplementedError();
  //   }
  //}
}
