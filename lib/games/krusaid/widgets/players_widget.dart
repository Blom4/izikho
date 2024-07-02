import 'package:flutter/material.dart';

import '../components/player.dart';
import 'player_widget.dart';

class PlayersWidget extends StatelessWidget {
  const PlayersWidget({
    super.key,
    required this.players,
  });
  final List<Player> players;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (Player player in players)
            PlayerWidget(
              player: player,
            ),
        ],
      ),
    );
  }
}
