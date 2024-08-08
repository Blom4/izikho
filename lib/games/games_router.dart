import 'package:go_router/go_router.dart';
import 'package:izikho/games/common/screens/waiting_screen.dart';

import 'common/screens/notifications_screen.dart';
import 'common/screens/game_invite_screen.dart';
import 'krusaid/krusaid_router.dart';

class GameRouter {
  static final  List<GoRoute> routes =  [
      GoRoute(
        path: '/invite',
        name: GameInviteScreen.routename,
        builder: (context, state) => const GameInviteScreen(),
      ),
      GoRoute(
        path: '/waiting',
        name: WaitingScreen.routename,
        builder: (context, state) => WaitingScreen(
          channel: state.extra as String,
        ),
      ),
      GoRoute(
        path: '/notifications',
        name: NotificationsScreen.routename,
        builder: (context, state) => const NotificationsScreen(),
      ),
      KrusaidRouter.route,
    ]
  ;
}
