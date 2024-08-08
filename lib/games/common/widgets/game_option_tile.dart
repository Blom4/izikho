import 'package:flutter/material.dart';

import '../../morabaraba/constants/colors.dart';

class GameOptionTile extends StatelessWidget {
  const GameOptionTile({
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
              //color: Theme.of(context).colorScheme.onPrimary,
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
