import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../morabaraba/screens/home_screen.dart';
import '../dialogs/multi_player_dialog.dart';

class KrusaidHomeScreen extends HookConsumerWidget {
  static const routename = "krusaid-home-screen";
  const KrusaidHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Likarete",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    letterSpacing: 5,
                  ),
            ),
            const SizedBox(height: 30),
            OptionItem(
              icon: Icons.person_outline,
              title: "Single Player",
              onTap: () {},
            ),
            OptionItem(
              icon: Icons.people_outline_outlined,
              title: "Multi Player",
              onTap: () => showMultiPlayerDialog(context).then((value) {
                // if (value != null) {
                //   value
                //       ? ref.read(socketMethodsProvider(context)).createRoom()
                //       : ref.read(socketMethodsProvider(context)).joinRoom();
                //}
              }),
            ),
            OptionItem(
              icon: Icons.save_alt,
              title: "Load Saved Game",
              onTap: () {},
            ),
            OptionItem(
              icon: Icons.settings_outlined,
              title: "Options",
              onTap: () {},
            ),
            OptionItem(
              icon: Icons.help_outline,
              title: "How To Play",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}


