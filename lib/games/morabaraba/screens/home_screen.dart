import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'morabaraba_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routename = "morabaraba_home_screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "MORABARABA",
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
              title: "Two Player",
              onTap: () =>
                  Navigator.of(context).pushNamed(MorabarabaScreen.routename),
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
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 10),
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
    );
  }
}
