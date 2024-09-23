import 'package:flutter/material.dart';

import '../models/game_model.dart';

class GameUtils {
  static const backgroundColor = Color(0xAC3A343D);
  static const secondaryColor = Color(0xFF10091D);
  static const accentColor = Color(0xBC38373B);
  static const errorColor = Color(0xFFF53838);
  static const successColor = Color(0xFF3AF143);
  static const shadowColor = Color(0xDD332E3A);

  static GameType getGameType(Map<String, dynamic> response) {
    return GameType.values.firstWhere(
      (e) => e.name == response['game_type'],
    );
  }
}
