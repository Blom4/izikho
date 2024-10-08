import '../../ak47/screens/ak47_game_screen.dart';
import '../../casino/casino_screen.dart';
import '../../chess/chess_screen.dart';
import '../../fivecards/screens/fivecards_game_screen.dart';
import '../../krusaid/screens/krusaid_game_screen.dart';
import '../../ludo/ludo_screen.dart';
import '../../morabaraba/screens/morabaraba_game_screen.dart';
import 'player_model.dart';

abstract class GameOptions<T extends PlayerModel> {
  final GameType gameType;
  final GameMode gameMode;
  final GamePlayerType gamePlayerType;
  final List<T> players;

  GameOptions({
    required this.gameType,
    required this.players,
    required this.gameMode,
    required this.gamePlayerType,
  });
}

enum GameMode {
  offline,
  online,
  both,
}

enum GameType {
  ak47(
    route: Ak47GameScreen.routename,
    imageUri: "assets/images/eagle.jpg",
    maxPlayers: 4,
  ),
  casino(
    route: CasinoScreen.routeName,
    imageUri: "assets/images/eagle.jpg",
    maxPlayers: 4,
  ),
  chess(
    route: ChessScreen.routeName,
    imageUri: "assets/images/eagle.jpg",
    maxPlayers: 2,
  ),
  fivecards(
    route: FivecardsGameScreen.routename,
    imageUri: "assets/images/eagle.jpg",
    maxPlayers: 4,
  ),
  krusaid(
    route: KrusaidGameScreen.routename,
    imageUri: "assets/images/eagle.jpg",
    maxPlayers: 4,
  ),
  ludo(
    route: LudoScreen.routeName,
    imageUri: "assets/images/eagle.jpg",
    maxPlayers: 4,
  ),
  morabaraba(
    route: MorabarabaGameScreen.routename,
    imageUri: "assets/images/eagle.jpg",
    maxPlayers: 2,
  );

  final String route;
  final String imageUri;
  final int maxPlayers;

  const GameType({
    required this.route,
    required this.imageUri,
    required this.maxPlayers,
  });
}

abstract class GameModel<T extends PlayerModel> {
  final String? id;
  final String? profileId;
  final GameType gameType;
  final GameMode gameMode;
  final List<T> players;
  final bool started;
  bool gameOver;

  GameModel({
    this.id,
    this.profileId,
    this.started = false,
    this.gameOver = false,
    required this.players,
    required this.gameType,
    required this.gameMode,
  });

  GameModel<T> copyWith();

  Map<String, dynamic> toMap();

  T get currentPlayer;

  T get winner;

  List<T> get otherPlayers;

  bool get allJoined => players.every((e) => e.joined);

  @override
  String toString() {
    return 'GameModel(id: $id, gameType: $gameType, players: $players, gameOver: $gameOver)';
  }
}
