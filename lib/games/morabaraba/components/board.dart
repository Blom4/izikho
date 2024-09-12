// import '../constants/morabaraba_constants.dart';
// import '../utils/morabaraba_utils.dart';
// import 'board_position.dart';
// import 'cell.dart';
// import 'cow.dart';

// class Board {
//   Board() {
//     int index = -1;
//     List<List<Cell>> newBoardGrid = List.generate(
//       15,
//       (row) => List.generate(
//         15,
//         (col) {
//           index++;
//           if (BoardPosition(row, col).isInBounds) {
//             if (cowLocations.contains(index)) {
//               return Cell.cow(BoardPosition(row, col), cow: null);
//             }
//             return Cell.path(BoardPosition(row, col));
//           }
//           return Cell(BoardPosition(row, col));
//         },
//       ),
//     );
//     boardGrid = newBoardGrid;
//   }

//   List<BoardPosition> blackPositions = [];
//   late List<List<Cell>> boardGrid;
//   Cell? selectedCell;
//   int selectedCol = -1;
//   int selectedRow = -1;
//   late int currentCol;
//   late int currentRow;
//   late Cell currentCell;
//   List<BoardPosition> whitePositions = [];

//   bool isCellSelected(int row, int col) {
//     return selectedRow == row && selectedCol == col;
//   }

//   bool isNotCowPath(int row, int col) => boardGrid[row][col].isNotPath;

//   void selectCell(int row, int col) {
//     selectedCell = boardGrid[row][col];
//     selectedRow = row;
//     selectedCol = col;
//     currentCell = getCurrentCell(row, col);
//   }

//   Cell getCurrentCell(int row, int col) {
//     currentCell = boardGrid[row][col];
//     currentRow = row;
//     currentCol = col;
//     return currentCell;
//   }

//   bool get hasCow => currentCell.hasCow;
//   List<BoardPosition> calculatedMoves(int row, int col) {
//     List<BoardPosition> calculatedMoves = [];
//     for (var move in moves) {
//       int i = 1;
//       while (true) {
//         int newRow = row + i * move[0];
//         int newCol = col + i * move[1];
//         i++;
//         if (!inBounds(newRow, newCol)) {
//           break;
//         }
//         if (boardGrid[newRow][newCol].hasNoCow) {
//           calculatedMoves.add(BoardPosition(newRow, newCol));
//           break;
//         } else if (isNotCowPath(newRow, newCol)) {
//           break;
//         }
//       }
//     }
//     return calculatedMoves;
//   }

//   Set<BoardPosition> checkAllValidMoves(bool isWhiteTurn) {
//     Set<BoardPosition> allMoves = {};
//     if (isWhiteTurn) {
//       for (var pos in whitePositions) {
//         allMoves = {...allMoves, ...calculatedMoves(pos.row, pos.col)};
//       }
//     } else {
//       for (var pos in blackPositions) {
//         allMoves = {...allMoves, ...calculatedMoves(pos.row, pos.col)};
//       }
//     }
//     return allMoves;
//   }

//   Map<String, List<BoardPosition>> findCapturePositions(bool isWhiteTurn) {
//     var lastPosition = whitePositions.last;
//     if (!isWhiteTurn) {
//       lastPosition = blackPositions.last;
//     }
//     int steps = midPositions.any((pos) => pos == lastPosition) ? 1 : 2;

//     List<BoardPosition> verticalPos = [];
//     List<BoardPosition> horizontalPos = [];
//     for (var move in captureMoves) {
//       int i = 1;
//       int count = 0;
//       while (true) {
//         int newRow = lastPosition.row + i * move[0];
//         int newCol = lastPosition.col + i * move[1];
//         i++;
//         if (!inBounds(newRow, newCol)) {
//           break;
//         }
//         if (boardGrid[newRow][newCol].hasNoCow) {
//           break;
//         }
//         if (count == steps) {
//           break;
//         }

//         if (boardGrid[newRow][newCol].hasCow) {
//           if (!(boardGrid[newRow][newCol].cow ==
//               boardGrid[lastPosition.row][lastPosition.col].cow)) {
//             break;
//           }
//         }

//         if (move[0] == 0) {
//           if (boardGrid[newRow][newCol].hasCow) {
//             if (boardGrid[newRow][newCol].cow ==
//                 boardGrid[lastPosition.row][lastPosition.col].cow) {
//               horizontalPos.add(BoardPosition(newRow, newCol));
//               count++;
//             }
//           }
//         }
//         if (move[1] == 0) {
//           if (boardGrid[newRow][newCol].hasCow) {
//             if (boardGrid[newRow][newCol].cow ==
//                 boardGrid[lastPosition.row][lastPosition.col].cow) {
//               verticalPos.add(BoardPosition(newRow, newCol));
//               count++;
//             }
//           }
//         }
//       }
//     }
//     return {
//       "horizontal": horizontalPos,
//       "vertical": verticalPos,
//     };
//   }

//   bool isCowCapture(bool isWhiteTurn) {
//     bool cowCapture = false;
//     var captures = findCapturePositions(isWhiteTurn);
//     var horizontal = captures["horizontal"]!;
//     var vertical = captures["vertical"]!;

//     if ((horizontal.length >= 2 || vertical.length >= 2)) {
//       if (horizontal.length == 2 || vertical.length == 2) {
//         if (vSpecialPos
//             .any((pos) => pos == BoardPosition(currentRow, currentCol))) {
//           if (!(midPositions.any((pos) => pos == vertical[0]) &&
//               midPositions.any((pos) => pos == vertical[1]))) {
//             cowCapture = true;
//           }
//         } else if (hSpecialPos
//             .any((pos) => pos == BoardPosition(currentRow, currentCol))) {
//           if (!(midPositions.any((pos) => pos == horizontal[0]) &&
//               midPositions.any((pos) => pos == horizontal[1]))) {
//             cowCapture = true;
//           }
//         } else {
//           cowCapture = true;
//         }
//       } else {
//         cowCapture = true;
//       }
//     }
//     return cowCapture;
//   }

//   void capture(bool isWhiteTurn) {
//     if (isWhiteTurn) {
//       blackPositions
//           .removeWhere((pos) => pos == BoardPosition(currentRow, currentCol));
//     } else {
//       whitePositions
//           .removeWhere((pos) => pos == BoardPosition(currentRow, currentCol));
//     }
//     boardGrid[currentRow][currentCol].cow = null;
//     clearSelection();
//   }

//   void placeCow(Cow cow) {
//     if (selectedCell != null && selectedCell!.hasNoCow) {
//       if (cow.isWhite) {
//         boardGrid[selectedRow][selectedCol].cow = cow;
//         whitePositions.add(BoardPosition(selectedRow, selectedCol));
//       } else {
//         boardGrid[selectedRow][selectedCol].cow = cow;
//         blackPositions.add(BoardPosition(selectedRow, selectedCol));
//       }
//     }
//   }

//   void moveCow(Cow cow) {
//     if (cow.isWhite) {
//       whitePositions
//           .removeWhere((pos) => pos == BoardPosition(selectedRow, selectedCol));
//       whitePositions.add(BoardPosition(currentRow, currentCol));
//     } else {
//       blackPositions
//           .removeWhere((pos) => pos == BoardPosition(selectedRow, selectedCol));
//       blackPositions.add(BoardPosition(currentRow, currentCol));
//     }
//     boardGrid[currentRow][currentCol].cow = selectedCell!.cow;
//     boardGrid[selectedRow][selectedCol].cow = null;
//   }

//   void highlightCaptures(bool isCapture, bool isWhiteTurn) {
//     var captures = findCapturePositions(isWhiteTurn);
//     List<BoardPosition> horizontal = captures["horizontal"]!;
//     List<BoardPosition> vertical = captures["vertical"]!;
//     late BoardPosition lastPosition;
//     if (isWhiteTurn) {
//       lastPosition = whitePositions.last;
//     } else {
//       lastPosition = blackPositions.last;
//     }
//     if (horizontal.length >= 2) {
//       for (var pos in horizontal) {
//         boardGrid[pos.row][pos.col].cow!.isCapture = isCapture;
//       }
//     }
//     if (vertical.length >= 2) {
//       for (var pos in vertical) {
//         boardGrid[pos.row][pos.col].cow!.isCapture = isCapture;
//       }
//     }
//     boardGrid[lastPosition.row][lastPosition.col].cow!.isCapture = isCapture;
//   }

//   void clearSelection() {
//     selectedCell = null;
//     selectedCol = -1;
//     selectedRow = -1;
//   }
// }
