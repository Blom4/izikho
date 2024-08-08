import 'package:flutter/material.dart';
import 'package:izikho/games/krusaid/models/krusaid_player_model.dart';

import '../components/player.dart';
import 'player_widget.dart';

class PlayersWidget extends StatelessWidget {
  const PlayersWidget({
    super.key,
    required this.players,
  });
  final List<KrusaidPlayerModel> players;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (KrusaidPlayerModel player in players)
            PlayerWidget(
              player: player,
            ),
        ],
      ),
    );
  }
}
