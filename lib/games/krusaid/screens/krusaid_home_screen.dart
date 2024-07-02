import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../morabaraba/constants/colors.dart';
import '../dialogs/multi_player_dialog.dart';
import '../providers/socket_methods_provider.dart';

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

class OptionItem extends StatelessWidget {
  const OptionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(color: shadowColor, spreadRadius: 1.5, blurRadius: 2)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              Icon(icon),
            ],
          ),
        ),
      ),
    );
  }
}
