import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/responsive/responsive.dart';
import '../components/play_card.dart';
import '../providers/krusaid_room_provider.dart';
import '../providers/socket_methods_provider.dart';
import 'card_widget.dart';

class PlayGroundWidget extends ConsumerWidget {
  const PlayGroundWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomProvider = ref.watch(krusaidRoomProvider);

    return Container(
      constraints: const BoxConstraints(maxWidth: 250),
      child: Column(
        children: [
          if (Responsive.isDesktop(context)) const SizedBox(height: 30),
          InfoWidget(
            numOfDeckCards: roomProvider.deck.length,
            turnPlayerName:
                roomProvider.players[roomProvider.turnIndex].username,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: DeckWidget(deckCards: roomProvider.deck),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: PlayedCardsWidget(
                      playedCards: roomProvider.playedCards,
                    ),
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
  });
  final List<PlayCard> playedCards;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DragTarget<PlayCard>(
        // onAcceptWithDetails: (details) =>
        //     ref.read(socketMethodsProvider(context)).play(details.data),
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

class DeckWidget extends StatelessWidget {
  const DeckWidget({
    super.key,
    required this.deckCards,
  });
  final List<PlayCard> deckCards;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.center,
      children: [
        for (PlayCard card in deckCards)
          Draggable<PlayCard>(
            data: card,
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
  });

  final int numOfDeckCards;
  final String turnPlayerName;
  //final nextAllowedCards;

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
                "(♥)",
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
