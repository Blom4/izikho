import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/game.dart';

class GameTileWidget extends StatelessWidget {
  const GameTileWidget({
    super.key,
    required this.gameModel,
  });

  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: GridTileBar(
        title: Text(
          gameModel.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      footer: Container(
        decoration: const BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {
            context.goNamed(gameModel.routeName);
          },
          child: Text(
            "Play",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.asset(
                gameModel.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Container(
              color: Colors.deepPurple.withOpacity(0.5),
            ),
          )
        ],
      ),
    );
  }
}
