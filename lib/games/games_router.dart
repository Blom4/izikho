import 'package:go_router/go_router.dart';
import 'package:izikho/games/common/screens/waiting_screen.dart';

import 'common/screens/notifications_screen.dart';
import 'common/screens/game_start_screen.dart';
import 'krusaid/krusaid_router.dart';
import 'morabaraba/morabaraba_routes.dart';

class GameRouter {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/game/start',
      name: GameStartScreen.routename,
      builder: (context, state) => const GameStartScreen(),
    ),
    GoRoute(
      path: '/game/waiting',
      name: WaitingScreen.routename,
      builder: (context, state) => WaitingScreen(
        channel: state.extra as String,
      ),
    ),
    GoRoute(
      path: '/game/notifications',
      name: NotificationsScreen.routename,
      builder: (context, state) => const NotificationsScreen(),
    ),
    KrusaidRouter.route,
    MorabarabaRouter.route,
  ];
}
