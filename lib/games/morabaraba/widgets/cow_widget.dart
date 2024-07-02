import 'package:flutter/material.dart';

import '../components/cow.dart';
import '../constants/game_constants.dart';

class CowWidget extends StatelessWidget {
  const CowWidget({
    super.key,
    required this.cow,
    required this.size,
    this.isSelected = false,
  });

  final Cow cow;
  final double size;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: cow.isWhite ? whiteCowColor : blackCowColor,
        border: cow.isCapture
            ? Border.all(
                color: Colors.green.shade700,
                width: 2,
              )
            : isSelected
                ? Border.all(
                    color: Colors.red.shade900,
                    width: 2,
                  )
                : null,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 0.5,
            spreadRadius: 0.5,
          )
        ],
        shape: BoxShape.circle,
      ),
    );
  }
}
