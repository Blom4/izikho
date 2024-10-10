import 'package:flutter/material.dart';
import 'package:izikho/games/morabaraba/widgets/morabaraba_cow_cell_widget.dart';

import '../constants/morabaraba_constants.dart';
import '../models/morabaraba_board_model.dart';
import '../models/morabaraba_cell_models.dart';
import '../utils/morabaraba_utils.dart';

class MorabarabaBoardWidget extends StatelessWidget {
  const MorabarabaBoardWidget({
    super.key,
    required this.board,
    required this.updateBoard,
  });

  final MorabarabaBoardModel board;
  final void Function(MorabarabaCowCell) updateBoard;

  @override
  Widget build(BuildContext context) {
    var ratio = responsiveScreenRatio(context);
    return AspectRatio(
      aspectRatio: ratio,
      child: Stack(
        children: [
          MorabarabaBoard(
            aspectRatio: ratio,
          ),
          //Text("helol")
          MorabarabaGrid(
            board: board,
            updateBoard: updateBoard,
            aspectRatio: ratio,
          )
        ],
      ),
    );
  }
}

class MorabarabaGrid extends StatelessWidget {
  const MorabarabaGrid({
    super.key,
    required this.board,
    required this.updateBoard,
    required this.aspectRatio,
  });
  final MorabarabaBoardModel board;
  final double aspectRatio;
  final void Function(MorabarabaCowCell) updateBoard;

  @override
  Widget build(BuildContext context) {
    // return GridView.count(
    //   reverse: true,
    //   physics: const NeverScrollableScrollPhysics(),
    //   crossAxisCount: 15,
    //   childAspectRatio: aspectRatio,
    //   children: [
    //     for (var boardCell in board.boardCells)
    //       if (boardCell.type != MorabarabaCellType.none)
    //         if (boardCell is MorabarabaCowCell)
    //           MorabarabaCowCellWidget(
    //             cell: boardCell,
    //             onTap: () => updateBoard(
    //               boardCell,
    //             ),
    //           )
    //         else
    //           Center(
    //             child: Text("${boardCell.cellIndex}"),
    //           )
    //       else
    //         Container(
    //           color: Colors.transparent,
    //         )
    //   ],
    // );
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 15,
        childAspectRatio: aspectRatio,
      ),
      reverse: true,
      itemCount: 15 * 15,
      itemBuilder: (context, index) {
        if (board.boardCells[index].type != MorabarabaCellType.none) {
          if (board.boardCells[index] is MorabarabaCowCell) {
            return MorabarabaCowCellWidget(
              cell: board.boardCells[index] as MorabarabaCowCell,
              onTap: () => updateBoard(
                board.boardCells[index] as MorabarabaCowCell,
              ),
            );
          }
          // return Center(
          //   child: Text("$index"),
          // );
        }
        return Container(
          //color: Colors.amber,
          color: Colors.transparent,
        );
      },
    );
  }
}

class MorabarabaBoard extends StatelessWidget {
  const MorabarabaBoard({
    super.key,
    required this.aspectRatio,
  });
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: CustomPaint(
        painter: MorabarabaBoardPainter(),
      ),
    );
  }
}

class MorabarabaBoardPainter extends CustomPainter {
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
  bool shouldRepaint(MorabarabaBoardPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(MorabarabaBoardPainter oldDelegate) => false;
}
