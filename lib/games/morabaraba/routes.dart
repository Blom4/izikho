import 'package:flutter/material.dart';

import 'screens/morabaraba_screen.dart';
import 'screens/home_screen.dart';

final Map<String, Widget Function(BuildContext)> morabarabaRoutes = {
  HomeScreen.routename: (context) => const HomeScreen(),
  MorabarabaScreen.routename: (context) => const MorabarabaScreen(),
};
