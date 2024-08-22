import 'package:flutter/material.dart';
import 'package:izikho/games/krusaid/models/play_card.dart';
import 'package:playing_cards/playing_cards.dart';

extension JokerDialog on BuildContext {
  Future<PlayCard?> showShotDialog(List<PlayCard> gunCards) {
    return showDialog<PlayCard>(
      context: this,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("You Are being Shot"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Please Select A Gun'),
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: gunCards.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    final gunCard = gunCards[index];

                    return InkWell(
                      onTap: () => Navigator.pop(context, gunCard),
                      child: PlayingCardView(
                        card: PlayingCard(
                          gunCard.suit,
                          gunCard.value,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Accept Shot"),
            ),
          ],
        );
      },
    );
  }
}
