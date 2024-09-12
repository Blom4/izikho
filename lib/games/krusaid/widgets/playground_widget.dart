import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/constants.dart';
import '../models/play_card.dart';
import 'card_widget.dart';

class PlayedCardsWidget extends HookConsumerWidget {
  const PlayedCardsWidget({
    super.key,
    required this.playedCards,
    required this.onPlayCard,
  });
  final List<PlayCard> playedCards;
  final void Function(PlayCard) onPlayCard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FittedBox(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 120),
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          children: [
            DragTarget<({bool isDeckCard, PlayCard card})>(
                onAcceptWithDetails: (details) async =>
                    onPlayCard(details.data.card),
                onWillAcceptWithDetails: (details) => !details.data.isDeckCard,
                builder: (context, candidateData, rejectedData) {
                  return Stack(
                    fit: StackFit.passthrough,
                    alignment: Alignment.center,
                    children: [
                      if (playedCards.isEmpty)
                        AspectRatio(
                          aspectRatio: playingCardAspectRatio,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            //padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              border: Border.all(style: BorderStyle.solid),
                            ),
                            child: const Center(
                              child: Icon(Icons.drag_indicator),
                            ),
                          ),
                        ),
                      for (PlayCard card in playedCards) CardWidget(card: card)
                    ],
                  );
                }),
            Text('( ${playedCards.length} )')
          ],
        ),
      ),
    );
  }
}

class DeckWidget extends HookConsumerWidget {
  const DeckWidget({super.key, required this.deck});
  final List<PlayCard> deck;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FittedBox(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 120),
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          children: [
            Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.center,
              children: [
                if (deck.isEmpty)
                  AspectRatio(
                    aspectRatio: playingCardAspectRatio,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      //padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(style: BorderStyle.solid),
                      ),
                      child: const Center(
                        child: Text("DECK "),
                      ),
                    ),
                  ),
                for (PlayCard card in deck)
                  Draggable<({bool isDeckCard, PlayCard card})>(
                    data: (isDeckCard: true, card: card),
                    feedback: CardWidget(
                      card: card,
                      showBack: true,
                    ),
                    child: CardWidget(
                      card: card,
                      showBack: true,
                    ),
                  ),
              ],
            ),
            Text('( ${deck.length} )'),
          ],
        ),
      ),
    );
  }
}
