import 'package:go_router/go_router.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

class AuthRouter {
  static final List<GoRoute> routes = [
    GoRoute(
      path: '/auth/login',
      name: LoginScreen.routename,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/auth/register',
      name: RegisterScreen.routename,
      builder: (context, state) => const RegisterScreen(),
    ),
  ];
}
