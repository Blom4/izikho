import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../auth/screens/login_screen.dart';
import '../providers/supabase_provider.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulHookConsumerWidget {
  static const String routename = 'splash_screen';
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late final StreamSubscription<AuthState> subscription;
  @override
  void initState() {
    subscription =
        ref.read(supabaseProvider).auth.onAuthStateChange.listen((event) {
      if (event.session == null) {
        context.goNamed(LoginScreen.routename);
      }
      context.goNamed(HomeScreen.routename);
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("S P L A S H"),
      ),
    );
  }
}
