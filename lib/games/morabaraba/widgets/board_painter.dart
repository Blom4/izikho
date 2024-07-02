import 'package:flutter/material.dart';

import '../constants/game_constants.dart';

class BoardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var gridWidth = size.width / 30;
    var gridHeight = size.height / 30;
    var width = size.width - gridWidth;
    var height = size.height - gridHeight;

    Paint paint = Paint()
      ..color = boardColor
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    //outer rectangle
    canvas.drawLine(
      Offset(gridWidth, gridHeight),
      Offset(width, gridHeight),
      paint,
    );
    canvas.drawLine(
      Offset(width, gridHeight),
      Offset(width, height),
      paint,
    );
    canvas.drawLine(
      Offset(width, height),
      Offset(gridWidth, height),
      paint,
    );
    canvas.drawLine(
      Offset(gridWidth, height),
      Offset(gridWidth, gridHeight),
      paint,
    );

    //inner rectangle
    canvas.drawLine(
      Offset(gridWidth * 5, gridHeight * 5),
      Offset(gridWidth * 25, gridHeight * 5),
      paint,
    );
    canvas.drawLine(
      Offset(gridWidth * 25, gridHeight * 5),
      Offset(gridWidth * 25, gridHeight * 25),
      paint,
    );
    canvas.drawLine(
      Offset(gridWidth * 25, gridHeight * 25),
      Offset(gridWidth * 5, gridHeight * 25),
      paint,
    );
    canvas.drawLine(
      Offset(gridWidth * 5, gridHeight * 25),
      Offset(gridWidth * 5, gridHeight * 5),
      paint,
    );

    //inner most rectangle
    canvas.drawLine(
      Offset(gridWidth * 9, gridHeight * 9),
      Offset(gridWidth * 21, gridHeight * 9),
      paint,
    );
    canvas.drawLine(
      Offset(gridWidth * 21, gridHeight * 9),
      Offset(gridWidth * 21, gridHeight * 21),
      paint,
    );
    canvas.drawLine(
      Offset(gridWidth * 21, gridHeight * 21),
      Offset(gridWidth * 9, gridHeight * 21),
      paint,
    );
    canvas.drawLine(
      Offset(gridWidth * 9, gridHeight * 21),
      Offset(gridWidth * 9, gridHeight * 9),
      paint,
    );

    //horizontal line
    canvas.drawLine(
      Offset(gridWidth, gridHeight * 15),
      Offset(width, gridHeight * 15),
      paint,
    );

    //virtical line
    canvas.drawLine(
      Offset(gridWidth * 15, gridHeight),
      Offset(gridWidth * 15, height),
      paint,
    );

    //diagonal lines
    canvas.drawLine(
      Offset(gridWidth, gridHeight),
      Offset(gridWidth * 5, gridHeight * 5),
      paint,
    );
    canvas.drawLine(
      Offset(width, gridHeight),
      Offset(gridWidth * 25, gridHeight * 5),
      paint,
    );
    canvas.drawLine(
      Offset(width, height),
      Offset(gridWidth * 25, gridHeight * 25),
      paint,
    );
    canvas.drawLine(
      Offset(gridWidth, height),
      Offset(gridWidth * 5, gridHeight * 25),
      paint,
    );
  }

  @override
  bool shouldRepaint(BoardPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BoardPainter oldDelegate) => false;
}
