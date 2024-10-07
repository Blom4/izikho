import 'package:flutter/material.dart';

extension MorabarabaDialogs on BuildContext {
  Future<bool?> showGameQuitDialog() {
    return showDialog<bool>(
      context: this,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Quit Game"),
          content: const Text("If you quit you lost"),
          actions: [
            TextButton(
              child: const Text("QUIT"),
              onPressed: () => Navigator.pop<bool>(context, true),
            ),
            TextButton(
              onPressed: () => Navigator.pop<bool>(context, false),
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
    );
  }
}
