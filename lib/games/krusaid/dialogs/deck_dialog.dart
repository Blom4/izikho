import 'package:flutter/material.dart';

void showDeckDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          //title: const Text("Deck Card"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 80,
                //width: 80,
                // child: PlayingCardView(
                //   card: PlayingCard(
                //     card.suit,
                //     card.value,
                //   ),
                // ),
              )
            ],
          ),
        );
      },
    );
