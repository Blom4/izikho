// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'game_model.dart';
import 'player_model.dart';

enum GameLevel{
  easy,
  normal,
  hard,
}

class GameOptions {
  final GameModel game;
  final bool isSinglePlayer;
  final List<PlayerModel> players;
  final GameLevel? level;
  final String channel;
  GameOptions({
    required this.game,
    required this.isSinglePlayer,
    required this.players,
    this.level,
    required this.channel,
  });

}
