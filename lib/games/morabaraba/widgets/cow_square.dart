import 'package:flutter/material.dart';

import '../components/cell.dart';
import '../constants/game_constants.dart';
import 'cow_widget.dart';

class CowSquare extends StatelessWidget {
  const CowSquare({
    super.key,
    required this.cell,
    required this.onTap,
    required this.isSelected,
  });

  final Cell cell;
  final void Function()? onTap;
  final cowColor = Colors.red;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: const Color(0xCF0E0E0D),
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      onTap: onTap,
      child: Stack(
        children: [
          if (cell.cow != null)
            CowWidget(
              cow: cell.cow!,
              size: 40,
              isSelected: isSelected,
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
