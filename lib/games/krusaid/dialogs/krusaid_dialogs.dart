import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

import '../../common/models/game_playing_card.dart';

extension KrusaidDialogs on BuildContext {
  Future<Playable?> showEightDialog() => showDialog<Playable>(
        context: this,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            //alignment: Alignment.topCenter,
            title: const Text("You Played 8"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Please select a suit you want to be played"),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int i = 1; i < Playable.values.length; i++)
                      InkWell(
                        onTap: () => Navigator.pop<Playable>(
                            context, Playable.values[i]),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Center(
                            child: Text(
                              Playable.values[i].symbol,
                              style: TextStyle(
                                color: Playable.values[i].color,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
            ],
          );
        },
      );

  Future<bool?> showJokerDialog() {
    return showDialog<bool>(
      context: this,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Joker Played"),
          content: const Text("Joker can be played as Gun or 8"),
          actions: [
            TextButton(
              child: const Text("SHOOT"),
              onPressed: () => Navigator.pop<bool>(context, true),
            ),
            TextButton(
              onPressed: () => Navigator.pop<bool>(context, false),
              child: const Text("PlAY AS 8"),
            ),
          ],
        );
      },
    );
  }

  Future<GamePlayingCard?> showShotDialog(List<GamePlayingCard> gunCards) {
    return showDialog<GamePlayingCard>(
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
                child: FlatCardFan(
                  children: [
                    for (var card in gunCards)
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
