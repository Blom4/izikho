import 'package:flutter/material.dart';

import '../models/krusaid_player_model.dart';

class OtherPlayersInfoWidget extends StatelessWidget {
  const OtherPlayersInfoWidget({
    super.key,
    required this.otherPlayers,
  });

  final List<KrusaidPlayerModel> otherPlayers;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final player in otherPlayers)
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: player.isTurn
                  ? Border(
                      bottom: BorderSide(
                        color: player.isShot ? Colors.red : Colors.deepPurple,
                        width: 2,
                      ),
                    )
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Badge.count(
                  alignment: Alignment.bottomRight,
                  count: player.cards.length,
                  child: const CircleAvatar(
                    radius: 17,
                  ),
                ),
                //const SizedBox(height: 5),
                Text(
                  player.username,
                  overflow: TextOverflow.ellipsis,
                  //style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
