import 'package:go_router/go_router.dart';
import 'package:izikho/games/krusaid/models/krusaid_game_model.dart';
import 'screens/krusaid_game_screen.dart';

class KrusaidRouter {
  static final GoRoute route = GoRoute(
    path: "/Krusaid/game",
    name: KrusaidGameScreen.routename,
    builder: (context, state) => KrusaidGameScreen(
      game: state.extra! as KrusaidGameModel,
    ),
  );
}
