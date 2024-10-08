import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playing_cards/playing_cards.dart';

import '../../common/models/game_playing_card.dart';
import '../../common/widgets/game_playing_card_widget.dart';
import '../models/ak47_player_model.dart';
import '../utils/ak47_utils.dart';

class Ak47PlayerCardsWidget extends HookConsumerWidget {
  const Ak47PlayerCardsWidget({
    super.key,
    required this.player,
    required this.onDeckCard,
  });

  final Ak47PlayerModel player;
  final void Function(GamePlayingCard) onDeckCard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FittedBox(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.all(5),
        child: DragTarget<({bool isDeckCard, GamePlayingCard card})>(
          onAcceptWithDetails: (details) => onDeckCard(details.data.card),
          onWillAcceptWithDetails: (details) => details.data.isDeckCard,
          builder: (context, candidateData, rejectedData) {
            return FlatCardFan(
              children: [
                if (player.cards.isEmpty)
                  const SizedBox(
                    width: 100,
                    child: AspectRatio(
                      aspectRatio: Ak47Utils.playingCardAspectRatio,
                      child: Center(
                        child: Text("Player Cards"),
                      ),
                    ),
                  ),
                for (final card in player.cards)
                  Draggable<({bool isDeckCard, GamePlayingCard card})>(
                    data: (isDeckCard: false, card: card),
                    childWhenDragging: Container(),
                    feedback: SizedBox(
                      width: player.cards.length < 15 ? 100 : 90,
                      child: GamePlayingCardWidget(
                        card: card,
                      ),
                    ),
                    child: SizedBox(
                      width: player.cards.length < 15 ? 100 : 90,
                      child: GamePlayingCardWidget(
                        card: card,
                      ),
                    ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
