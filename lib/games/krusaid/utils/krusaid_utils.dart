import 'dart:math' as math;

class KrusaidUtils {
  static double playerCardAngle({
    required int index,
    required int length,
  }) =>
      (math.pi / 200) * (index - (length / 2));
}
