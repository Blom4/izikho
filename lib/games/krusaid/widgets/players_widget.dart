import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/krusaid_player_model.dart';
import 'player_widget.dart';

class PlayersWidget extends HookConsumerWidget {
  const PlayersWidget({
    super.key,
    required this.players,
  });
  final List<KrusaidPlayerModel> players;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final player in players)
            PlayerWidget(
              player: player,
            ),
        ],
      ),
    );
  }
}
