import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

import '../models/play_card.dart';

extension DeckDialog on BuildContext {
  Future<PlayCard?> showDeckDialog(List<PlayCard> playableCards) =>
      showDialog<PlayCard>(
        context: this,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Deck Card"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Do Not Play"),
              ),
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Please Select Card To Play'),
                const SizedBox(height: 10),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: playableCards.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      final playableCard = playableCards[index];

                      return InkWell(
                        onTap: () => Navigator.pop(context, playableCard),
                        child: PlayingCardView(
                          card: PlayingCard(
                            playableCard.suit,
                            playableCard.value,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
}
