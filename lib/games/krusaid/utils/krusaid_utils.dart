import 'dart:math' as math;

class KrusaidUtils {
  static const playingCardAspectRatio = 64.0 / 89.0;
  static const suitSymbols = ['♠', '♣', '♥', '♦'];
  static double playerCardAngle({required int index, required int length}) {
    return (math.pi / 200) * (index - (length / 2));
  }
}
