// // ignore_for_file: public_member_api_docs, sort_constructors_first

// import '../utils/morabaraba_utils.dart';

// class BoardPosition {
//   final int row;
//   final int col;

//   const BoardPosition(this.row, this.col);

//   @override
//   bool operator ==(covariant BoardPosition other) {
//     if (identical(this, other)) return true;

//     return other.row == row && other.col == col;
//   }

//   bool get isInBounds => inBounds(row, col);

//   @override
//   int get hashCode => row.hashCode ^ col.hashCode;

//   @override
//   String toString() => '(row: $row, col: $col)';
// }
