import 'package:go_router/go_router.dart';
import 'package:izikho/games/morabaraba/models/morabaraba_game_model.dart';

import 'screens/morabaraba_game_screen.dart';

// final Map<String, Widget Function(BuildContext)> morabarabaRoutes = {
//   HomeScreen.routename: (context) => const HomeScreen(),
//   MorabarabaScreen.routename: (context) => const MorabarabaScreen(),
// };

class MorabarabaRouter {
  static final GoRoute route = GoRoute(
    path: "/morabaraba/game",
    name: MorabarabaGameScreen.routename,
    builder: (context, state) => MorabarabaGameScreen(
      gameOptions: state.extra! as MorabarabaGameOptions,
    ),
  );
}
