import 'package:flutter/material.dart';

class GameScreenHeaderWidget extends StatelessWidget {
  const GameScreenHeaderWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
          letterSpacing: 5.0,
          shadows: [
            const Shadow(
              color: Colors.deepPurple,
              blurRadius: 2.5,
              offset: Offset(0, 2),
            )
          ],
        ),
      ),
    );
  }
}
