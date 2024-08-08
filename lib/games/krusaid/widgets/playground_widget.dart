import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/common/utils/snackbar.dart';
import 'package:izikho/games/krusaid/dialogs/eigtht_dialog.dart';
import 'package:izikho/games/krusaid/dialogs/joker_dialog.dart';
import 'package:playing_cards/playing_cards.dart';

import '../../../common/responsive/responsive.dart';
import '../components/play_card.dart';
import '../models/krusaid_game_model.dart';
import '../providers/krusaid_game_provider.dart';
import 'card_widget.dart';

class PlayGroundWidget extends StatelessWidget {
  const PlayGroundWidget({
    super.key,
    required this.game,
  });
  final KrusaidGameModel game;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 250),
      child: Column(
        children: [
          if (Responsive.isDesktop(context)) const SizedBox(height: 30),
          InfoWidget(
            numOfDeckCards: game.deckCount,
            turnPlayerName: game.turnPlayer.username,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: DeckWidget(deckCards: game.deck),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: PlayedCardsWidget(
                      game: game,
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

class PlayedCardsWidget extends StatefulHookConsumerWidget {
  const PlayedCardsWidget({
    super.key,
    required this.game,
  });
  final KrusaidGameModel game;

  @override
  ConsumerState<PlayedCardsWidget> createState() => _PlayedCardsWidgetState();
}

class _PlayedCardsWidgetState extends ConsumerState<PlayedCardsWidget> {
  //bool _loading =false;
  Future<void> play(PlayCard card) async {
    if (widget.game.isPlayable(card)) {
      try {
        switch (card.value) {
          case CardValue.eight:
            final playable = await context.showEightDialog();
            if (playable != null) {
              await ref.read(krusaidGameProvider(widget.game.id).notifier).play(
                    card: card,
                    playable: PlayCard(playable.suit, card.value),
                  );
            }
            break;
          case CardValue.joker_1 || CardValue.joker_2:
            final isJoker = await context.showJokerDialog();
            if (isJoker != null) {
              if (isJoker) {
                await ref
                    .read(krusaidGameProvider(widget.game.id).notifier)
                    .play(
                      card: card,
                      playable: card,
                    );
              } else {
                if (mounted) {
                  final playable = await context.showEightDialog();
                  if (playable != null) {
                    await ref
                        .read(krusaidGameProvider(widget.game.id).notifier)
                        .play(
                          card: card,
                          playable: PlayCard(playable.suit, card.value),
                        );
                  }
                }
              }
            }
            break;
          default:
            await ref
                .read(krusaidGameProvider(widget.game.id).notifier)
                .play(card: card);
            break;
        }
      } catch (e) {
        if (mounted) {
          context.showSnackBar(e.toString());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<PlayCard>(
        onAcceptWithDetails: (details) async => await play(details.data),
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
              for (PlayCard card in widget.game.playedCards)
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
