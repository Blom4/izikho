import 'package:flutter/material.dart';

import '../models/fivecards_player_model.dart';

class FivecardsPlayersInfoWidget extends StatelessWidget {
  const FivecardsPlayersInfoWidget({
    super.key,
    required this.otherPlayers,
  });

  final List<FivecardsPlayerModel> otherPlayers;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (index, player) in otherPlayers.indexed)
            Container(
              margin: otherPlayers.length == 1
                  ? null
                  : index != 0 && index != otherPlayers.length - 1
                      ? const EdgeInsets.symmetric(horizontal: 20)
                      : index == 0
                          ? const EdgeInsets.only(right: 20)
                          : index == otherPlayers.length - 1
                              ? const EdgeInsets.only(left: 20)
                              : null,
              decoration: BoxDecoration(
                border: player.isTurn
                    ? Border(
                        bottom: BorderSide(
                          color: player.isShot ? Colors.red : Colors.deepPurple,
                          width: 3,
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
                      child: Icon(Icons.person),
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
      ),
    );
  }
}
