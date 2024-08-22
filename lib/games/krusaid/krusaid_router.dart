import 'package:go_router/go_router.dart';
import 'package:izikho/games/krusaid/models/krusaid_game_model.dart';
import 'screens/krusaid_game_screen.dart';
import 'screens/krusaid_home_screen.dart';


class KrusaidRouter {
  static final GoRoute route = GoRoute(
    path: "/krusaid",
    name: KrusaidHomeScreen.routename,
    builder: (context, state) => const KrusaidHomeScreen(),
    routes: [
      
      GoRoute(
        path: "game",
        name: KrusaidGameScreen.routename,
        builder: (context, state) => KrusaidGameScreen(
          game: state.extra! as KrusaidGameModel,
        ),
      ),
    ],
  );
}
