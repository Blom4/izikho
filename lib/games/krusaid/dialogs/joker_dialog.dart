import 'package:flutter/material.dart';

extension JokerDialog on BuildContext {
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
}
