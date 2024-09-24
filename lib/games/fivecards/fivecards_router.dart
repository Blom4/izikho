import 'package:go_router/go_router.dart';
import 'models/fivecards_game_model.dart';
import 'screens/fivecards_game_screen.dart';

class FivecardsRouter {
  static final GoRoute route = GoRoute(
    path: "/fivecards/game",
    name: FivecardsGameScreen.routename,
    builder: (context, state) => FivecardsGameScreen(
      game: state.extra! as FivecardsGameModel,
    ),
  );
}
