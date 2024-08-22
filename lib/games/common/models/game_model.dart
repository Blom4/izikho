
import '../../ak47/ak47_screen.dart';
import '../../casino/casino_screen.dart';
import '../../chess/chess_screen.dart';
import '../../fivecards/fivecards_sceen.dart';
import '../../krusaid/screens/krusaid_game_screen.dart';
import '../../ludo/ludo_screen.dart';
import '../../morabaraba/screens/morabaraba_screen.dart';
import 'player_model.dart';

enum GameType {
  ak47(
    route: Ak47Screen.routeName,
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
    route: FivecardsScreen.routeName,
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
    route: MorabarabaScreen.routename,
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
  final List<T> players;
  final bool started;
  final PlayerModel? turn;
  bool gameOver;

  GameModel({
    this.id,
    this.profileId,
    this.turn,
    this.started = false,
    this.gameOver = false,
    required this.players,
    required this.gameType,
  });

  GameModel<T> copyWith();

  Map<String, dynamic> toMap();

  T get currentPlayer;

  T get winner; 

  List<T> get otherPlayers;

  bool get allJoined => players.every((e) => e.joined);

  @override
  String toString() {
    return 'GameModel(id: $id, gameType: $gameType, players: $players, gameOver: $gameOver, turn: $turn)';
  }
}
