import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

import '../models/game_playing_card.dart';

extension DeckDialog on BuildContext {
  Future<GamePlayingCard?> showDeckDialog(
          List<GamePlayingCard> playableCards) =>
      showDialog<GamePlayingCard>(
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
                  child: FlatCardFan(
                    children: [
                      for (var card in playableCards)
                        InkWell(
                          onTap: () => Navigator.pop(context, card),
                          child: PlayingCardView(
                            card: PlayingCard(
                              card.suit,
                              card.value,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
}
