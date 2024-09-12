// import 'board_position.dart';
// import 'cow.dart';

// class Cell {
//   Cell(this.position) {
//     cow = null;
//     _isPath = false;
//     _isCell = true;
//   }

//   Cell.cow(this.position, {required this.cow}) {
//     _isPath = false;
//     _isCell = false;
//   }

//   Cell.path(this.position) {
//     cow = null;
//     _isPath = true;
//     _isCell = false;
//   }

//   late Cow? cow;
//   BoardPosition position;

//   late final bool _isCell;
//   late final bool _isPath;

//   @override
//   String toString() {
//     return 'Cell(position: $position, isPath: $_isPath, _isCell: $_isCell)';
//   }

//   bool get hasCow => !_isPath && !_isCell && cow != null;

//   bool get hasNoCow => !_isPath && !_isCell && cow == null;

//   bool get isNotPath => !_isPath;
// }
