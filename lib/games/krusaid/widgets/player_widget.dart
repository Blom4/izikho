import 'package:flutter/material.dart';
import 'package:izikho/games/krusaid/models/krusaid_player_model.dart';


class PlayerWidget extends StatelessWidget {
  const PlayerWidget({
    super.key,
    required this.player,
  });
  final KrusaidPlayerModel player;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: player.isTurn
                ? player.isShot
                    ? Colors.red
                    : Colors.green
                : Colors.white,
            child: const CircleAvatar(
              radius: 22,
            ),
          ),
          Text(
            player.username,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "( ${player.cards.length} )",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
