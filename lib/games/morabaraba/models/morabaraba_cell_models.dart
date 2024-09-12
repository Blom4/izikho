// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  top(-1, 0),
  right(0, 1),
  bottom(1, 0),
  left(0, -1),
  topLeft(-1, -1),
  bottomRight(1, 1),
  topRight(-1, 1),
  bottomLeft(1, -1);

  final int x;
  final int y;

  const MorabarabaCowMove(this.x, this.y);
}

enum MorabarabaCowCaptureMove {
  top(-1, 0),
  right(0, 1),
  bottom(1, 0),
  left(0, -1);

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

  ({int row, int col}) get position => (row: row, col: col);

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
    this.isCaptureCell =false,
    this.isLastCowPlayed =false,
  });
  final MorabarabaCowType cowType;
  final bool isSelected;
  final bool isCaptureCell;
  final bool isLastCowPlayed;

  final List<({int row, int col})> _midCellPosition = [
    (row: 7, col: 7),
    (row: 2, col: 7),
    (row: 7, col: 2),
    (row: 12, col: 7),
    (row: 7, col: 12),
  ];

  final _vSpecialCellPosition = [
    (row:4, col:7),
    (row:10, col:7),
  ];
  final _hSpecialCellPosition = [
    (row:7,col: 4),
    (row:7,col: 10),
  ];


  bool get hasNoCow => cowType == MorabarabaCowType.none;

  bool get isMidCellPosition => _midCellPosition.any((e) => e == position);
  bool get isVSpecialCellPosition => _vSpecialCellPosition.any((e) => e == position);
  bool get isHSpecialCellPosition => _hSpecialCellPosition.any((e) => e == position);

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
      isCaptureCell: isCaptureCell??this.isCaptureCell
    );
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
      isCaptureCell.hashCode^
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
