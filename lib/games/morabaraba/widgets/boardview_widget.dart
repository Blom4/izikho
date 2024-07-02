import 'package:flutter/material.dart';

import '../components/board.dart';
import '../components/board_position.dart';
import '../constants/game_constants.dart';
import '../utils/utils.dart';
import 'board_widget.dart';
import 'cow_square.dart';

class BoardViewWidget extends StatelessWidget {
  const BoardViewWidget({
    super.key,
    required this.board,
    required this.updateBoard,
  });

  final Board board;
  final void Function(int, int) updateBoard;

  @override
  Widget build(BuildContext context) {
    var ratio = responsiveScreenRatio(context);
    return AspectRatio(
      aspectRatio: ratio,
      child: Stack(
        //alignment: Alignment.center,
        children: [
          BoardWidget(
            aspectRatio: ratio,
          ),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 15,
            childAspectRatio: ratio,
            children: List<Widget>.generate(
              225,
              (int index) {
                int row = index ~/ 15;
                int col = index % 15;

                if (BoardPosition(row, col).isInBounds) {
                  if (cowLocations.contains(index)) {
                    return CowSquare(
                      cell: board.boardGrid[row][col],
                      isSelected: board.isCellSelected(row, col),
                      onTap: () => updateBoard(row, col),
                    );
                  }
                  //return Center(child: Text("($row,$col)"));
                }
                return Container(
                  color: Colors.transparent,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
