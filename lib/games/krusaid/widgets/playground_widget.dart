import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/responsive/responsive.dart';
import '../models/play_card.dart';
import 'card_widget.dart';

class PlayGroundWidget extends HookConsumerWidget {
  const PlayGroundWidget({
    super.key,
    required this.deckWidget,
    required this.playedCardsWidget,
    required this.infoWidget,
  });

  final DeckWidget deckWidget;
  final PlayedCardsWidget playedCardsWidget;
  final InfoWidget infoWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 250),
      child: Column(
        children: [
          if (Responsive.isDesktop(context)) const SizedBox(height: 30),
          infoWidget,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: deckWidget,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: playedCardsWidget,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
    return DragTarget<({bool isDeckCard, PlayCard card})>(
        onAcceptWithDetails: (details) async => onPlayCard(details.data.card),
        onWillAcceptWithDetails: (details) => !details.data.isDeckCard,
        builder: (context, candidateData, rejectedData) {
          return Stack(
            fit: StackFit.passthrough,
            alignment: Alignment.center,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(style: BorderStyle.solid),
                  ),
                  child: const Text("PLAY HERE"),
                ),
              ),
              for (PlayCard card in playedCards)
                CardWidget(
                  card: card,
                )
            ],
          );
        });
  }
}

class DeckWidget extends HookConsumerWidget {
  const DeckWidget({super.key, required this.deck});
  final List<PlayCard> deck;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.center,
      children: [
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
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key,
    required this.numOfDeckCards,
    required this.turnPlayerName,
    required this.playable,
  });

  final int numOfDeckCards;
  final String turnPlayerName;
  final Playable playable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(2),
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).hoverColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // const suits = ['♠', '♣', '♥', '♦'];
          Column(
            children: [
              Text(
                "Deck",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                "($numOfDeckCards)",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Turn",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                "($turnPlayerName)",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Next",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                playable.symbol,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
