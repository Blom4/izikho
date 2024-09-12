import 'package:flutter/material.dart';
import 'package:izikho/games/morabaraba/models/morabaraba_cell_models.dart';

import '../constants/morabaraba_constants.dart';

class MorabarabaCowCellWidget extends StatelessWidget {
  const MorabarabaCowCellWidget({
    super.key,
    required this.cell,
    required this.onTap,
  });

  final MorabarabaCowCell cell;
  final void Function()? onTap;
  final cowColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: const Color(0xCF0E0E0D),
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      onTap: onTap,
      child: Stack(
        children: [
          if (!cell.hasNoCow)
            MorabarabaCow(
              cow: cell,
              size: 40,
            )
          else
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      blurStyle: BlurStyle.inner,
                      color: Colors.black12,
                    )
                  ],
                  color: boardColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class MorabarabaCow extends StatelessWidget {
  const MorabarabaCow({
    super.key,
    required this.cow,
    required this.size,
  });

  final MorabarabaCowCell cow;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: cow.cowType == MorabarabaCowType.white
            ? whiteCowColor
            : blackCowColor,
        border: cow.isCaptureCell
            ? Border.all(
                color: Colors.green.shade700,
                width: 2,
              )
            : cow.isSelected
                ? Border.all(
                    color: Colors.red.shade900,
                    width: 2,
                  )
                : cow.isLastCowPlayed
                    ? Border.all(
                        color: Colors.blue.shade900,
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
