import 'package:flutter/foundation.dart';

import 'package:izikho/games/morabaraba/models/morabaraba_cell_models.dart';

class MorabarabaBoardModel {
  final List<MorabarabaCell> boardCells;
  final List<MorabarabaCowCell> blackCowPositions;
  final List<MorabarabaCowCell> whiteCowPositions;
  final MorabarabaCowCell? lastCowCellPlayed;
  final MorabarabaCowCell? selectedCowToMove;

  const MorabarabaBoardModel({
    required this.boardCells,
    this.blackCowPositions = const [],
    this.whiteCowPositions = const [],
    this.lastCowCellPlayed,
    this.selectedCowToMove,
  });

  List<MorabarabaCowCell> get cowCells =>
      boardCells.whereType<MorabarabaCowCell>().toList();

  MorabarabaBoardModel copyWith({
    List<MorabarabaCell>? boardCells,
    List<MorabarabaCowCell>? blackCowPositions,
    List<MorabarabaCowCell>? whiteCowPositions,
    MorabarabaCowCell? lastCowCellPlayed,
    MorabarabaCowCell? selectedCowToMove,
  }) {
    return MorabarabaBoardModel(
      boardCells: boardCells ?? this.boardCells,
      blackCowPositions: blackCowPositions ?? this.blackCowPositions,
      whiteCowPositions: whiteCowPositions ?? this.whiteCowPositions,
      lastCowCellPlayed: lastCowCellPlayed ?? this.lastCowCellPlayed,
      selectedCowToMove: selectedCowToMove ?? this.selectedCowToMove,
    );
  }

  MorabarabaBoardModel placeCowBoardState(MorabarabaCowCell currentCowCell) {
    boardCells[currentCowCell.cellIndex] = currentCowCell.copyWith(
      isLastCowPlayed: true,
    );
    if (lastCowCellPlayed != null) {
      boardCells[lastCowCellPlayed!.cellIndex] =
          lastCowCellPlayed!.copyWith(isLastCowPlayed: false);
    }
    return copyWith(
      blackCowPositions: [
        ...blackCowPositions,
        if (currentCowCell.cowType == MorabarabaCowType.black) currentCowCell,
      ],
      whiteCowPositions: [
        ...whiteCowPositions,
        if (currentCowCell.cowType == MorabarabaCowType.white) currentCowCell,
      ],
      lastCowCellPlayed: currentCowCell.copyWith(
        isLastCowPlayed: true,
      ),
    );
  }

  MorabarabaBoardModel selectCowToMoveBoardState(
    MorabarabaCowCell currentCowCell,
  ) {
    // if (selectedCowToMove != null) {
    //   boardCells[selectedCowToMove!.cellIndex] = selectedCowToMove!.copyWith(
    //     isSelected: false,
    //   );
    // }
    final newCowCell = currentCowCell.copyWith(isSelected: true);
    boardCells[currentCowCell.cellIndex] = newCowCell;

    return copyWith(
      selectedCowToMove: currentCowCell,
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
      blackCowPositions: [
        ...blackCowPositions
            .where((e) => e.cellIndex != selectedCowToMove!.cellIndex),
        if (newCowCell.cowType == MorabarabaCowType.black) newCowCell
      ],
      whiteCowPositions: [
        ...whiteCowPositions
            .where((e) => e.cellIndex != selectedCowToMove!.cellIndex),
        if (newCowCell.cowType == MorabarabaCowType.white) newCowCell
      ],
      lastCowCellPlayed: newCowCell,
    );
  }

  MorabarabaBoardModel captureCowBoardState(MorabarabaCowCell currentCowCell) {
    boardCells[currentCowCell.cellIndex] =
        currentCowCell.copyWith(cowType: MorabarabaCowType.none);

    return copyWith(
      blackCowPositions: [
        ...blackCowPositions
            .where((e) => e.cellIndex != currentCowCell.cellIndex),
      ],
      whiteCowPositions: [
        ...blackCowPositions
            .where((e) => e.cellIndex != currentCowCell.cellIndex),
      ],
    );
  }

  void highlightCaptureCells(bool isCaptureCells) {
    boardCells[lastCowCellPlayed!.cellIndex] = lastCowCellPlayed!.copyWith(
      isCaptureCell: isCaptureCells,
    );
    if (captureCells.x.length >= 2) {
      for (var pos in captureCells.x) {
        boardCells[pos.cellIndex] = pos.copyWith(isCaptureCell: isCaptureCells);
      }
    }
    if (captureCells.y.length >= 2) {
      for (var pos in captureCells.y) {
        boardCells[pos.cellIndex] = pos.copyWith(isCaptureCell: isCaptureCells);
      }
    }
  }

  ({List<MorabarabaCowCell> x, List<MorabarabaCowCell> y}) get captureCells {
    if (lastCowCellPlayed == null) {
      return (x: [], y: []);
    }

    int steps = lastCowCellPlayed!.isMidCellPosition ? 1 : 2;

    List<MorabarabaCowCell> yCaptures = [];
    List<MorabarabaCowCell> xCaptures = [];
    for (var captureMove in MorabarabaCowCaptureMove.values) {
      int i = 1;
      int count = 0;
      while (true) {
        final newCellPosition = (
          row: lastCowCellPlayed!.row + i * captureMove.x,
          col: lastCowCellPlayed!.col + i * captureMove.y,
        );

        final newBoardCell = boardCells.firstWhere(
          (e) => e.position == newCellPosition,
          orElse: () => MorabarabaCell(
            row: -1,
            col: -1,
            cellIndex: -1,
          ),
        );
        i++;

        if (newBoardCell.type == MorabarabaCellType.none || count == steps) {
          break;
        }

        if (newBoardCell is MorabarabaCowCell) {
          if (newBoardCell.hasNoCow ||
              newBoardCell.cowType != lastCowCellPlayed!.cowType) {
            break;
          }

          if (captureMove.x == 0) {
            xCaptures.add(newBoardCell);
            count++;
          }
          if (captureMove.y == 0) {
            yCaptures.add(newBoardCell);
            count++;
          }
        }
      }
    }
    return (x: xCaptures, y: yCaptures);
  }

  bool get isCowCapture {
    bool cowCapture = false;
    if ((captureCells.x.length >= 2 || captureCells.y.length >= 2)) {
      if (captureCells.x.length == 2 || captureCells.y.length == 2) {
        if (lastCowCellPlayed!.isVSpecialCellPosition) {
          if (!(captureCells.y.every((e) => e.isMidCellPosition))) {
            cowCapture = true;
          }
        } else if (lastCowCellPlayed!.isHSpecialCellPosition) {
          if (!(captureCells.x.every((e) => e.isMidCellPosition))) {
            cowCapture = true;
          }
        } else {
          cowCapture = true;
        }
      } else {
        cowCapture = true;
      }
    }
    return cowCapture;
  }

  List<MorabarabaCowCell> getCurrentCowValidMoves(
    MorabarabaCowCell currentCowCell,
  ) {
    List<MorabarabaCowCell> currentCowValidMoves = [];
    for (var cowMove in MorabarabaCowMove.values) {
      int i = 1;
      while (true) {
        final newCellPosition = (
          row: currentCowCell.row + i * cowMove.x,
          col: currentCowCell.col + i * cowMove.y,
        );
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
    if (lastCowCellPlayed != null) {
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
    }
    return allMoves;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'boardCells': boardCells.map((x) => x.toMap()).toList(),
      'blackCowPositions': blackCowPositions.map((x) => x.toMap()).toList(),
      'whiteCowPositions': whiteCowPositions.map((x) => x.toMap()).toList(),
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
      blackCowPositions: List<MorabarabaCowCell>.from(
        (map['blackCowPositions'] as List<int>).map<MorabarabaCowCell>(
          (x) => MorabarabaCowCell.fromMap(x as Map<String, dynamic>),
        ),
      ),
      whiteCowPositions: List<MorabarabaCowCell>.from(
        (map['whiteCowPositions'] as List<int>).map<MorabarabaCowCell>(
          (x) => MorabarabaCowCell.fromMap(x as Map<String, dynamic>),
        ),
      ),
      lastCowCellPlayed: map['lastCowCellPlayed'],
      selectedCowToMove: map['selectedCowToMove'],
    );
  }

  @override
  String toString() =>
      'MorabarabaBoardModel(boardCells: $boardCells, blackCowPositions: $blackCowPositions, whiteCowPositions: $whiteCowPositions)';

  @override
  bool operator ==(covariant MorabarabaBoardModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.boardCells, boardCells) &&
        listEquals(other.blackCowPositions, blackCowPositions) &&
        listEquals(other.whiteCowPositions, whiteCowPositions) &&
        other.lastCowCellPlayed == lastCowCellPlayed &&
        other.selectedCowToMove == selectedCowToMove;
  }

  @override
  int get hashCode =>
      boardCells.hashCode ^
      blackCowPositions.hashCode ^
      whiteCowPositions.hashCode ^
      lastCowCellPlayed.hashCode ^
      selectedCowToMove.hashCode;
}
