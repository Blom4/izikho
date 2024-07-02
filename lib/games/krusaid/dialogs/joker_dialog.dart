import 'package:flutter/material.dart';

Future<bool?> showJokerDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text("Joker Played"),
        content: const Text("Joker can be played to shoot or as 8"),
        actions: [
          TextButton(
            child: const Text("SHOOT"),
            onPressed: () => Navigator.pop<bool>(context, true),
          ),
          TextButton(
              onPressed: () => Navigator.pop<bool>(context, false),
              child: const Text("PlAY AS 8")),
        ],
      );
    },
  );
}
