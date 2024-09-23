import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'game_offline_provider.g.dart';

@riverpod
GameOfflineMethods gameOffline(GameOfflineRef ref) {
  return GameOfflineMethods(ref);
}

class GameOfflineMethods {
  final Ref ref;

  GameOfflineMethods(this.ref);
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
