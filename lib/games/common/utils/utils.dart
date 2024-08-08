import '../models/game_model.dart';

GameType getGameType(Map<String, dynamic> response) {
  return GameType.values.firstWhere(
    (e) => e.name == response['game_type'],
  );
}
