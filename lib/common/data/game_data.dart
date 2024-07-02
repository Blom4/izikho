import '../../games/ak47/ak47_screen.dart';
import '../../games/casino/casino_screen.dart';
import '../../games/chess/chess_screen.dart';
import '../../games/krusaid/screens/krusaid_home_screen.dart';
import '../../games/fivecards/fivecards_sceen.dart';
import '../../games/ludo/ludo_screen.dart';
import '../../games/morabaraba/screens/morabaraba_screen.dart';
import '../models/game.dart';

const List<GameModel> games = [
  GameModel(
    name: "Marabaraba",
    image: "assets/images/eagle.jpg",
    routeName: MorabarabaScreen.routename,
  ),
  GameModel(
    name: "Chess",
    image: "assets/images/eagle.jpg",
    routeName: ChessScreen.routeName,
  ),
  GameModel(
    name: "Krusaid",
    image: "assets/images/eagle.jpg",
    routeName: KrusaidHomeScreen.routename,
  ),
  GameModel(
    name: "Ludo",
    image: "assets/images/eagle.jpg",
    routeName: LudoScreen.routeName,
  ),
  GameModel(
    name: "Casino",
    image: "assets/images/eagle.jpg",
    routeName: CasinoScreen.routeName,
  ),
  GameModel(
    name: "5 Cards",
    image: "assets/images/eagle.jpg",
    routeName: FivecardsScreen.routeName,
  ),
  GameModel(
    name: "AK47",
    image: "assets/images/eagle.jpg",
    routeName: Ak47Screen.routeName,
  ),
];
