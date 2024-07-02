import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth/auth_router.dart';
import 'auth/providers/auth_change_provider.dart';
import 'auth/screens/login_screen.dart';
import 'auth/screens/profile_screen.dart';
import 'chat/chat_router.dart';
import 'common/screens/home_screen.dart';
import 'common/screens/splash_screen.dart';
import 'games/games_router.dart';

final appRouteProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: '/',
      refreshListenable: _AppRouter(ref),
      routes: _AppRouter(ref).routes,
      redirect: _AppRouter(ref).redirect);
});

class _AppRouter extends ChangeNotifier {
  _AppRouter(this.ref) {
    ref.listen(authChangeProvider, (previous, next) {
      notifyListeners();
    });
  }

  Ref ref;
  List<GoRoute> get routes => [
        GoRoute(
          path: "/",
          name: SplashScreen.routename,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/home',
          name: HomeScreen.routename,
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'profile',
              name: ProfileScreen.routename,
              builder: (context, state) => const ProfileScreen(),
            ),
            ChatRouter.route,
            GameRouter.route,
          ],
        ),
        ...AuthRouter.routes
      ];

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    final userProvider = ref.read(authChangeProvider);
    if (userProvider.hasValue) {
      final session = userProvider.value!.session;

      if (session == null) {
        return state.matchedLocation.startsWith("/auth")
            ? null
            : state.namedLocation(LoginScreen.routename);
      }
      return state.matchedLocation.startsWith("/auth")
          ? state.namedLocation(HomeScreen.routename)
          : null;
    }
    return state.namedLocation(SplashScreen.routename);
  }
}
