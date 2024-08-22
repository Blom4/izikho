import 'package:flutter/material.dart';

import '../models/play_card.dart';

extension EightDialog on BuildContext {
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
}
