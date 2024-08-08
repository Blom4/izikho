import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_utils_provider.g.dart';

@riverpod
GameUtils gameUtils (GameUtilsRef ref) {
  return GameUtils(ref) ;
}

class GameUtils{
  final Ref ref;
  GameUtils(this.ref);
}
