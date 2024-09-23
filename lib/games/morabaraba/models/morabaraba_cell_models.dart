// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../utils/morabaraba_utils.dart';

enum MorabarabaCellType {
  path,
  cow,
  none,
}

enum MorabarabaCowType {
  white,
  black,
  none,
}

enum MorabarabaCowMove {
  top(0, -1),
  right(1, 0),
  bottom(0, 1),
  left(-1, 0),
  topLeft(-1, -1),
  bottomRight(1, 1),
  topRight(1, -1),
  bottomLeft(-1, 1);

  final int x;
  final int y;

  const MorabarabaCowMove(this.x, this.y);
}

enum MorabarabaCowCaptureMove {
  top(0, -1),
  right(1, 0),
  bottom(0, 1),
  left(-1, 0);

  final int x;
  final int y;

  const MorabarabaCowCaptureMove(this.x, this.y);
}

class MorabarabaCell {
  final MorabarabaCellType type;
  final int row;
  final int col;
  final int cellIndex;
  MorabarabaCell({
    this.type = MorabarabaCellType.none,
    required this.row,
    required this.col,
    required this.cellIndex,
  });

  String get position => '$row,$col';

  MorabarabaCell copyWith({
    MorabarabaCellType? type,
    int? row,
    int? col,
    int? cellIndex,
  }) {
    return MorabarabaCell(
      type: type ?? this.type,
      row: row ?? this.row,
      col: col ?? this.col,
      cellIndex: cellIndex ?? this.cellIndex,
    );
  }

  @override
  bool operator ==(covariant MorabarabaCell other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        other.row == row &&
        other.col == col &&
        other.cellIndex == cellIndex;
  }

  @override
  int get hashCode => type.hashCode ^ row.hashCode ^ col.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.name,
      'row': row,
      'col': col,
      'cellIndex': cellIndex,
    };
  }

  factory MorabarabaCell.fromMap(Map<String, dynamic> map) {
    return MorabarabaCell(
      type: MorabarabaCellType.values.firstWhere((e) => e.name == map['type']),
      row: map['row'] as int,
      col: map['col'] as int,
      cellIndex: map['cellIndex'] as int,
    );
  }

  @override
  String toString() {
    return 'MorabarabaCell(type: $type, row: $row, col: $col, cellIndex: $cellIndex)';
  }
}

class MorabarabaCowCell extends MorabarabaCell {
  MorabarabaCowCell({
    super.type = MorabarabaCellType.cow,
    required super.row,
    required super.col,
    required super.cellIndex,
    required this.cowType,
    this.isSelected = false,
    this.isCaptureCell = false,
    this.isLastCowPlayed = false,
  });
  final MorabarabaCowType cowType;
  final bool isSelected;
  final bool isCaptureCell;
  final bool isLastCowPlayed;

  bool get hasNoCow => cowType == MorabarabaCowType.none;

  bool get isMidCellPosition =>
      MorabarabaUtils.midCellPosition.any((e) => e == position);
  bool get isVSpecialCellPosition =>
      MorabarabaUtils.vSpecialCellPosition.any((e) => e == position);
  bool get isHSpecialCellPosition =>
      MorabarabaUtils.hSpecialCellPosition.any((e) => e == position);

  @override
  MorabarabaCowCell copyWith({
    MorabarabaCellType? type,
    int? row,
    int? col,
    int? cellIndex,
    MorabarabaCowType? cowType,
    bool? isSelected,
    bool? isLastCowPlayed,
    bool? isCaptureCell,
  }) {
    return MorabarabaCowCell(
        type: type ?? this.type,
        row: row ?? this.row,
        col: col ?? this.col,
        cellIndex: cellIndex ?? this.cellIndex,
        cowType: cowType ?? this.cowType,
        isSelected: isSelected ?? this.isSelected,
        isLastCowPlayed: isLastCowPlayed ?? this.isLastCowPlayed,
        isCaptureCell: isCaptureCell ?? this.isCaptureCell);
  }

  @override
  bool operator ==(covariant MorabarabaCowCell other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        other.row == row &&
        other.col == col &&
        other.cowType == cowType &&
        other.isSelected == isSelected &&
        other.isLastCowPlayed == isLastCowPlayed &&
        other.isCaptureCell == isCaptureCell;
  }

  @override
  int get hashCode =>
      type.hashCode ^
      row.hashCode ^
      col.hashCode ^
      cowType.hashCode ^
      isSelected.hashCode ^
      isCaptureCell.hashCode ^
      isLastCowPlayed.hashCode;

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.name,
      'row': row,
      'col': col,
      'cellIndex': cellIndex,
      'cowType': cowType.name,
      'isSelected': isSelected,
      'isCaptureCell': isCaptureCell,
      'isLastCowPlayed': isLastCowPlayed,
    };
  }

  factory MorabarabaCowCell.fromMap(Map<String, dynamic> map) {
    return MorabarabaCowCell(
      cowType: MorabarabaCowType.values.firstWhere(
        (e) => map['cowType'] == e.name,
      ),
      isSelected: map['isSelected'] as bool,
      isCaptureCell: map['isCaptureCell'] as bool,
      isLastCowPlayed: map['isLastCowPlayed'] as bool,
      row: map['row'] as int,
      cellIndex: map['cellIndex'] as int,
      col: map['col'] as int,
      type: MorabarabaCellType.values.firstWhere(
        (e) => e.name == map['type'],
      ),
    );
  }
}

class MorabarabaPathCell extends MorabarabaCell {
  MorabarabaPathCell({
    super.type = MorabarabaCellType.path,
    required super.row,
    required super.col,
    required super.cellIndex,
  });
}
