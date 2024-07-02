import 'package:flutter/material.dart';
import 'board_painter.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({
    super.key,
    required this.aspectRatio,
  });
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: CustomPaint(
        painter: BoardPainter(),
      ),
    );
  }
}
