// import 'package:flutter/material.dart';
// import 'package:motion_toast/motion_toast.dart';
// import 'board.dart';
// import 'board_position.dart';
// import 'cow.dart';

// enum GameAction {
//   place,
//   capture,
//   select,
//   move,
// }

// enum GameAlerts {
//   error,
//   warning,
//   success,
//   info,
// }

// final class Game {
//   late final Board board;
//   late List<Cow> blackCows;
//   late List<Cow> whiteCows;
//   late List<BoardPosition> validMoves;
//   late Set<BoardPosition> allValidMoves;
//   late Map<String, List<BoardPosition>> captures;
//   late bool _isWhiteTurn;
//   late GameAction gameAction;

//   late List<Cow> whiteCaptured;
//   late List<Cow> blackCaptured;
//   BuildContext context;

//   Game(this.context) {
//     board = Board();
//     _isWhiteTurn = true;
//     captures = {
//       "horizontal": [],
//       "vertical": [],
//     };
//     validMoves = [];
//     allValidMoves = {};
//     whiteCows = List.generate(12, (index) => Cow(isWhite: true));
//     blackCows = List.generate(12, (index) => Cow(isWhite: false));
//     gameAction = GameAction.place;
//     whiteCaptured = [];
//     blackCaptured = [];
//   }

//   bool get isWhiteTurn => _isWhiteTurn;

//   bool get noCowToPlace => blackCows.isEmpty && whiteCows.isEmpty;

//   bool get isMyTurn {
//     if (board.selectedCell != null &&
//         board.selectedCell!.cow!.isWhite == isWhiteTurn &&
//         board.currentCell.cow == null) {
//       return true;
//     }
//     if (board.hasCow && board.currentCell.cow!.isWhite == isWhiteTurn) {
//       return true;
//     }
//     return false;
//   }

//   void updateBoard(int row, int col) {
//     switch (gameAction) {
//       case GameAction.place:
//         placeCow(row, col);
//         break;
//       case GameAction.select:
//         selectCowToMove(row, col);
//         break;
//       case GameAction.move:
//         checkMove(row, col);
//         break;
//       case GameAction.capture:
//         selectCowToCapture(row, col);
//     }
//     validateAllMoves();
//   }

//   void placeCow(int row, int col) {
//     if (!noCowToPlace) {
//       var currentCell = board.getCurrentCell(row, col);
//       if (currentCell.hasNoCow) {
//         board.selectCell(row, col);
//         board.placeCow(
//             isWhiteTurn ? whiteCows.removeLast() : blackCows.removeLast());
//         board.clearSelection();
//         var isCowCapture = board.isCowCapture(isWhiteTurn);
//         if (isCowCapture) {
//           board.highlightCaptures(true, isWhiteTurn);
//           gameAction = GameAction.capture;
//         } else {
//           changeTurn();
//           if (noCowToPlace) {
//             gameAction = GameAction.move;
//           } else {
//             gameAction = GameAction.place;
//           }
//         }
//       } else {
//         debugPrint("please  put cow on empty position");
//         MotionToast.error(
//           title: const Text("Error"),
//           description: const Text("please  put cow on empty position"),
//         ).show(context);
//       }
//     }
//   }

//   void selectCowToMove(int row, int col) {
//     var currentCell = board.getCurrentCell(row, col);
//     if (isMyTurn &&
//         currentCell.cow != null &&
//         currentCell.cow!.isWhite == isWhiteTurn) {
//       board.selectCell(row, col);
//       validMoves = board.calculatedMoves(row, col);
//       debugPrint("validMoves : $validMoves");
//       gameAction = GameAction.move;
//     } else {
//       MotionToast.error(
//         title: const Text("Error"),
//         description: const Text("please select your own cow"),
//       ).show(context);
//     }
//   }

//   void checkMove(int row, int col) {
//     var currentCell = board.getCurrentCell(row, col);
//     if (validMoves.isEmpty) {
//       selectCowToMove(row, col);
//     } else {
//       if (currentCell.hasNoCow) {
//         if (validMoves.any((pos) => pos == BoardPosition(row, col))) {
//           moveCow(row, col);
//         } else {
//           MotionToast.error(
//             title: const Text("Error"),
//             description:
//                 const Text("Selected Cow can not to move to that location"),
//           ).show(context);
//         }
//       } else {
//         selectCowToMove(row, col);
//       }
//     }
//   }

//   void moveCow(int row, int col) {
//     board.moveCow(isWhiteTurn ? Cow(isWhite: true) : Cow(isWhite: false));
//     var isCowCapture = board.isCowCapture(isWhiteTurn);
//     if (isCowCapture) {
//       gameAction = GameAction.capture;
//       board.highlightCaptures(true, isWhiteTurn);
//       board.clearSelection();
//     } else {
//       changeTurn();
//       gameAction = GameAction.select;
//     }
//   }

//   void selectCowToCapture(int row, int col) {
//     var currentCell = board.getCurrentCell(row, col);
//     if (currentCell.hasCow && currentCell.cow!.isWhite != isWhiteTurn) {
//       board.highlightCaptures(false, isWhiteTurn);
//       board.capture(isWhiteTurn);
//       isWhiteTurn
//           ? whiteCaptured.add(Cow(isWhite: false))
//           : blackCaptured.add(Cow(isWhite: true));
//       changeTurn();
//       if (noCowToPlace) {
//         gameAction = GameAction.select;
//       } else {
//         gameAction = GameAction.place;
//       }
//     } else {
//       MotionToast.error(
//         title: const Text("Error"),
//         description: const Text("You Can't Capture Your own Cow"),
//       ).show(context);
//     }
//   }

//   bool isCellSelected(int row, int col) {
//     return board.isCellSelected(row, col);
//   }

//   void changeTurn() {
//     _isWhiteTurn = !_isWhiteTurn;
//     board.clearSelection();
//   }

//   void validateAllMoves() {
//     if (noCowToPlace) {
//       allValidMoves = board.checkAllValidMoves(isWhiteTurn);
//       if (allValidMoves.isEmpty) {
//         changeTurn();
//       }
//     }
//   }
// }
