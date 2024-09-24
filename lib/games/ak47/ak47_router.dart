import 'package:go_router/go_router.dart';

import 'models/ak47_game_model.dart';
import 'screens/ak47_game_screen.dart';

class Ak47Router {
  static final GoRoute route = GoRoute(
    path: "/ak47/game",
    name: Ak47GameScreen.routename,
    builder: (context, state) => Ak47GameScreen(
      game: state.extra! as Ak47GameModel,
    ),
  );
}
