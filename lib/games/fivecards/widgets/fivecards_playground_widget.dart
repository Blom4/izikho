import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/games/common/widgets/game_playing_card_widget.dart';

import '../../common/models/game_playing_card.dart';
import '../utils/fivecards_utils.dart';

class FivecardsPlayedCardsWidget extends HookConsumerWidget {
  const FivecardsPlayedCardsWidget({
    super.key,
    required this.playedCards,
    required this.onPlayCard,
  });
  final List<GamePlayingCard> playedCards;
  final void Function(GamePlayingCard) onPlayCard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FittedBox(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 120),
        width: MediaQuery.of(context).size.width / 2,
        child: DragTarget<({bool isDeckCard, GamePlayingCard card})>(
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
                      aspectRatio: FivecardsUtils.playingCardAspectRatio,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
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
                    ),
                  for (GamePlayingCard card in playedCards)
                    AspectRatio(
                      aspectRatio: FivecardsUtils.playingCardAspectRatio,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Draggable<
                            ({bool isDeckCard, GamePlayingCard card})>(
                          data: (isDeckCard: false, card: card),
                          feedback: SizedBox(
                            width: 100,
                            child: GamePlayingCardWidget(card: card),
                          ),
                          child: SizedBox(
                            width: 100,
                            child: GamePlayingCardWidget(card: card),
                          ),
                        ),
                      ),
                    )
                ],
              );
            }),
      ),
    );
  }
}

class FivecardsDeckWidget extends HookConsumerWidget {
  const FivecardsDeckWidget({super.key, required this.deck});
  final List<GamePlayingCard> deck;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FittedBox(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 120),
        width: MediaQuery.of(context).size.width / 2,
        child: Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.center,
          children: [
            if (deck.isEmpty)
              AspectRatio(
                aspectRatio: FivecardsUtils.playingCardAspectRatio,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(style: BorderStyle.solid),
                    ),
                    child: const Center(
                      child: Text("DECK "),
                    ),
                  ),
                ),
              ),
            for (GamePlayingCard card in deck)
              AspectRatio(
                aspectRatio: FivecardsUtils.playingCardAspectRatio,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Draggable<({bool isDeckCard, GamePlayingCard card})>(
                    data: (isDeckCard: true, card: card),
                    feedback: SizedBox(
                      width: 100,
                      child: GamePlayingCardWidget(
                        card: card,
                        showBack: true,
                      ),
                    ),
                    child: SizedBox(
                      width: 100,
                      child: GamePlayingCardWidget(
                        card: card,
                        showBack: true,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
