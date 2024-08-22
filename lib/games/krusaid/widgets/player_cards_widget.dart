import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playing_cards/playing_cards.dart';

import '../../../common/responsive/responsive.dart';
import '../models/play_card.dart';
import '../models/krusaid_player_model.dart';
import 'card_widget.dart';

class PlayerCardsWidget extends HookConsumerWidget {
  const PlayerCardsWidget({
    super.key,
    required this.player,
    required this.onDeckCard,
  });

  final KrusaidPlayerModel player;
  final void Function(PlayCard) onDeckCard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FittedBox(
      child: DragTarget<({bool isDeckCard, PlayCard card})>(
        onAcceptWithDetails: (details) => onDeckCard(details.data.card),
        onWillAcceptWithDetails: (details) => details.data.isDeckCard,
        builder: (context, candidateData, rejectedData) {
          return FlatCardFan(
            children: [
              const SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: Text("Player Cards"),
                ),
              ),
              ...List.generate(
                player.cards.length,
                (index) => Draggable<({bool isDeckCard, PlayCard card})>(
                  data: (isDeckCard: false, card: player.cards[index]),
                  childWhenDragging: Container(),
                  feedback: CardWidget(
                    margin: Responsive.isMobile(context)
                        ? (100 * index.toDouble()) / 6
                        : 100 * index.toDouble() * 0.25,
                    size: Responsive.isMobile(context) ? 95 : 100,
                    card: player.cards[index],
                  ),
                  child: CardWidget(
                    margin: Responsive.isMobile(context)
                        ? (100 * index.toDouble()) / 6
                        : 100 * index.toDouble() * 0.25,
                    size: Responsive.isMobile(context) ? 95 : 100,
                    card: player.cards[index],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
