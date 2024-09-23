import 'morabaraba_cell_models.dart';

class MorabarabaBoardModel {
  final List<MorabarabaCell> boardCells;
  final MorabarabaCowCell? lastCowCellPlayed;
  final MorabarabaCowCell? selectedCowToMove;

  const MorabarabaBoardModel({
    required this.boardCells,
    this.lastCowCellPlayed,
    this.selectedCowToMove,
  });
  MorabarabaBoardModel copyWith({
    List<MorabarabaCell>? boardCells,
    MorabarabaCowCell? lastCowCellPlayed,
    MorabarabaCowCell? selectedCowToMove,
  }) {
    return MorabarabaBoardModel(
      boardCells: boardCells ?? this.boardCells,
      lastCowCellPlayed: lastCowCellPlayed ?? this.lastCowCellPlayed,
      selectedCowToMove: selectedCowToMove ?? this.selectedCowToMove,
    );
  }

  List<MorabarabaCowCell> get cowCells =>
      boardCells.whereType<MorabarabaCowCell>().toList();
  List<MorabarabaCowCell> get emptyCowPositions =>
      cowCells.where((e) => e.cowType == MorabarabaCowType.none).toList();
  List<MorabarabaCowCell> get blackCowPositions =>
      cowCells.where((e) => e.cowType == MorabarabaCowType.black).toList();
  List<MorabarabaCowCell> get whiteCowPositions =>
      cowCells.where((e) => e.cowType == MorabarabaCowType.white).toList();

  MorabarabaBoardModel placeCowBoardState(MorabarabaCowCell currentCowCell) {
    boardCells[currentCowCell.cellIndex] = currentCowCell.copyWith(
      isLastCowPlayed: true,
    );
    if (lastCowCellPlayed != null) {
      boardCells[lastCowCellPlayed!.cellIndex] =
          lastCowCellPlayed!.copyWith(isLastCowPlayed: false);
    }
    return copyWith(
      lastCowCellPlayed: currentCowCell.copyWith(
        isLastCowPlayed: true,
      ),
    );
  }

  MorabarabaBoardModel selectCowToMoveBoardState(
    MorabarabaCowCell currentCowCell,
  ) {
    final newCowCell = currentCowCell.copyWith(isSelected: true);
    boardCells[currentCowCell.cellIndex] = newCowCell;

    // if (selectedCowToMove != null && selectedCowToMove != currentCowCell) {
    //   boardCells[selectedCowToMove!.cellIndex] = selectedCowToMove!.copyWith(
    //     isSelected: false,
    //   );
    // }

    return copyWith(
      selectedCowToMove: newCowCell,
    );
  }

  MorabarabaBoardModel moveCowBoardState(MorabarabaCowCell currentCowCell) {
    if (selectedCowToMove == null) {
      throw Exception('Please select a Cow to move');
    }

    final newCowCell = currentCowCell.copyWith(
      cowType: selectedCowToMove!.cowType,
      isLastCowPlayed: true,
    );

    boardCells[selectedCowToMove!.cellIndex] = selectedCowToMove!.copyWith(
      cowType: MorabarabaCowType.none,
      isSelected: false,
    );

    boardCells[lastCowCellPlayed!.cellIndex] = lastCowCellPlayed!.copyWith(
      isLastCowPlayed: false,
    );

    boardCells[currentCowCell.cellIndex] = newCowCell;

    return copyWith(
      selectedCowToMove: null,
      lastCowCellPlayed: newCowCell,
    );
  }

  MorabarabaBoardModel captureCowBoardState(MorabarabaCowCell currentCowCell) {
    final newCowCell = currentCowCell.copyWith(cowType: MorabarabaCowType.none);
    boardCells[currentCowCell.cellIndex] = newCowCell;

    return copyWith(
      //lastCowCellPlayed: newCowCell,
      selectedCowToMove: null,
    );
  }

  void highlightCaptureCells(bool isCaptureCells) {
    boardCells[lastCowCellPlayed!.cellIndex] = lastCowCellPlayed!.copyWith(
      isCaptureCell: isCaptureCells,
    );
    for (var pos in captureCells) {
      boardCells[pos.cellIndex] = pos.copyWith(isCaptureCell: isCaptureCells);
    }
  }

  bool get isCowCapture => captureCells.isNotEmpty;

  List<MorabarabaCowCell> get captureCells {
    if (lastCowCellPlayed == null) {
      return [];
    }

    int steps = lastCowCellPlayed!.isMidCellPosition ? 1 : 2;

    final leftCaptures = findCaptures(
      lastCowCellPlayed!,
      MorabarabaCowMove.left,
      steps,
    );
    final rightCaptures = findCaptures(
      lastCowCellPlayed!,
      MorabarabaCowMove.right,
      steps,
    );
    final topCaptures = findCaptures(
      lastCowCellPlayed!,
      MorabarabaCowMove.top,
      steps,
    );
    final bottomCaptures = findCaptures(
      lastCowCellPlayed!,
      MorabarabaCowMove.bottom,
      steps,
    );

    if (lastCowCellPlayed!.isMidCellPosition) {
      return [
        if (topCaptures.isNotEmpty && bottomCaptures.isNotEmpty) ...[
          ...topCaptures,
          ...bottomCaptures
        ],
        if (leftCaptures.isNotEmpty && rightCaptures.isNotEmpty) ...[
          ...leftCaptures,
          ...rightCaptures
        ]
      ];
    }
    if (lastCowCellPlayed!.isHSpecialCellPosition) {
      return [
        if (topCaptures.length == 2) ...topCaptures,
        if (bottomCaptures.length == 2) ...bottomCaptures,
        if (leftCaptures.isNotEmpty && rightCaptures.isNotEmpty) ...[
          ...leftCaptures,
          ...rightCaptures
        ]
      ];
    }
    if (lastCowCellPlayed!.isVSpecialCellPosition) {
      return [
        if (leftCaptures.length == 2) ...leftCaptures,
        if (rightCaptures.length == 2) ...rightCaptures,
        if (topCaptures.isNotEmpty && bottomCaptures.isNotEmpty) ...[
          ...topCaptures,
          ...bottomCaptures
        ]
      ];
    }
    return [
      if (leftCaptures.length == 2) ...leftCaptures,
      if (rightCaptures.length == 2) ...rightCaptures,
      if (topCaptures.length == 2) ...topCaptures,
      if (bottomCaptures.length == 2) ...bottomCaptures,
    ];
  }

  List<MorabarabaCowCell> findCaptures(
      MorabarabaCell cell, MorabarabaCowMove move, steps) {
    List<MorabarabaCowCell> captures = [];
    int i = 1;
    int count = 0;
    while (true) {
      final newRow = lastCowCellPlayed!.row + i * move.x;
      final newCol = lastCowCellPlayed!.col + i * move.y;
      final newCellPosition = '$newRow,$newCol';
      i++;

      final newBoardCell = boardCells.firstWhere(
        (e) => e.position == newCellPosition,
        orElse: () => MorabarabaCell(row: -1, col: -1, cellIndex: -1),
      );

      if (count == steps) {
        break;
      }

      if (newBoardCell.type == MorabarabaCellType.none) {
        break;
      }

      if (newBoardCell is MorabarabaCowCell) {
        if (newBoardCell.cowType != lastCowCellPlayed!.cowType) {
          break;
        }
        if (newBoardCell.hasNoCow) {
          break;
        }

        captures.add(newBoardCell);
        count++;
      }
    }
    return captures;
  }

  List<MorabarabaCowCell> getCurrentCowValidMoves(
    MorabarabaCowCell currentCowCell,
  ) {
    List<MorabarabaCowCell> currentCowValidMoves = [];
    for (var cowMove in MorabarabaCowMove.values) {
      int i = 1;
      while (true) {
        final newRow = currentCowCell.row + i * cowMove.x;
        final newCol = currentCowCell.col + i * cowMove.y;
        final newCellPosition = '$newRow,$newCol';
        i++;

        final newBoardCell = boardCells.firstWhere(
          (e) => e.position == newCellPosition,
          orElse: () => MorabarabaCell(row: -1, col: -1, cellIndex: -1),
        );
        if (newBoardCell.type == MorabarabaCellType.none) {
          break;
        }

        if (newBoardCell is MorabarabaCowCell) {
          if (newBoardCell.hasNoCow) {
            currentCowValidMoves.add(newBoardCell);
            break;
          } else {
            break;
          }
        }
      }
    }
    return currentCowValidMoves;
  }

  Set<MorabarabaCowCell> allBoardValidMoves(MorabarabaCowType cowTurn) {
    Set<MorabarabaCowCell> allMoves = {};

    if (cowTurn == MorabarabaCowType.white) {
      for (var pos in whiteCowPositions) {
        allMoves = <MorabarabaCowCell>{
          ...allMoves,
          ...getCurrentCowValidMoves(pos)
        };
      }
    } else {
      for (var pos in blackCowPositions) {
        allMoves = <MorabarabaCowCell>{
          ...allMoves,
          ...getCurrentCowValidMoves(pos)
        };
      }
    }

    return allMoves;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'boardCells': boardCells.map((x) => x.toMap()).toList(),
      'lastCowCellPlayed': lastCowCellPlayed?.toMap(),
      'selectedCowToMove': selectedCowToMove?.toMap(),
    };
  }

  factory MorabarabaBoardModel.fromMap(Map<String, dynamic> map) {
    return MorabarabaBoardModel(
      boardCells: List<MorabarabaCell>.from(
        (map['boardCells'] as List<int>).map<MorabarabaCell>(
          (x) => MorabarabaCell.fromMap(x as Map<String, dynamic>),
        ),
      ),
      lastCowCellPlayed: map['lastCowCellPlayed'],
      selectedCowToMove: map['selectedCowToMove'],
    );
  }

  @override
  String toString() => '''
        MorabarabaBoardModel(
          boardCells: $boardCells, 
          blackCowPositions: $blackCowPositions, 
          whiteCowPositions: $whiteCowPositions
        )
      ''';
}
