import 'package:go_router/go_router.dart';

import 'common/screens/game_screen.dart';
import 'krusaid/krusaid_router.dart';

class GameRouter {
  static final GoRoute route = GoRoute(
    path: 'games',
    name: GameScreen.routename,
    builder: (context, state) => const GameScreen(),
    routes: [
      KrusaidRouter.route,
    ],
  );
}
