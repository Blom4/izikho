import '../../common/models/game_model.dart';
import '../../common/models/player_model.dart';
import 'marabaraba_player_model.dart';
import 'morabaraba_board_model.dart';
import 'morabaraba_cell_models.dart';

enum MorabarabaGameAction {
  place,
  capture,
  select,
  move,
}

enum GameAlerts {
  error,
  warning,
  success,
  info,
}

enum GameLevel {
  easy,
  normal,
  hard,
}

enum PlayerType {
  computer,
  player,
}

class MorabarabaGameOptions extends GameOptions<MorabarabaPlayerModel> {
  MorabarabaGameOptions({
    required super.gameType,
    required super.gameMode,
    required super.players,
    required super.gamePlayerType,
  });
}

class MorabarabaGameModel extends GameModel<MorabarabaPlayerModel> {
  MorabarabaGameModel({
    super.id,
    super.profileId,
    super.gameOver,
    super.started,
    required super.players,
    required super.gameType,
    required super.gameMode,
    required this.board,
    this.turnIndex = 0,
    this.gameAction = MorabarabaGameAction.place,
  });

  final MorabarabaBoardModel board;
  final int turnIndex;
  final MorabarabaGameAction gameAction;

  int get nextTurnIndex => (turnIndex + 1) % players.length;

  MorabarabaGameModel placeCowGameState(MorabarabaCowCell currentCowCell) {
    if (currentPlayer.cowsInHand <= 0) {
      throw Exception('Sorry,You don\'t have cow to Place');
    }
    if (!currentPlayer.isTurn) {
      throw Exception('Sorry, is not your turn');
    }
    if (!currentCowCell.hasNoCow) {
      throw Exception('Please put cow on empty position');
    }
    final newBoard = board.placeCowBoardState(
      currentCowCell.copyWith(
        cowType: currentPlayer.cowType,
      ),
    );
    if (newBoard.isCowCapture) {
      newBoard.highlightCaptureCells(true);
      return copyWith(
        board: newBoard,
        turnIndex: turnIndex,
        gameAction: MorabarabaGameAction.capture,
        players: [
          for (final player in players)
            if (player.isTurn)
              player.copyWith(
                cowsInHand: player.cowsInHand - 1,
              )
            else
              player
        ],
      );
    }

    return copyWith(
      board: newBoard,
      turnIndex: nextTurnIndex,
      gameAction: MorabarabaGameAction.place,
      players: [
        for (final player in players)
          if (player.isTurn)
            player.copyWith(
              isTurn: false,
              cowsInHand: player.cowsInHand - 1,
            )
          else
            player.copyWith(isTurn: true)
      ],
    );
  }

  MorabarabaGameModel selectCowToMoveGameState(
    MorabarabaCowCell currentCowCell,
  ) {
    if (!currentPlayer.isTurn) {
      throw Exception('Sorry, is not your turn');
    }
    if (currentCowCell.hasNoCow) {
      throw Exception('please select a cow to move');
    }

    if (currentCowCell.cowType != turnPlayer.cowType) {
      throw Exception('please select your own cow to move');
    }

    final validMoves = board.getCurrentCowValidMoves(currentCowCell);
    if (validMoves.isEmpty) {
      throw Exception('Sorry, no available moves for the current cow');
    }
    final newBoard = board.selectCowToMoveBoardState(currentCowCell);

    return copyWith(
      board: newBoard,
      gameAction: MorabarabaGameAction.move,
    );
  }

  MorabarabaGameModel checkMoveGameState(MorabarabaCowCell currentCowCell) {
    if (!currentPlayer.isTurn) {
      throw Exception('Sorry, is not your turn');
    }
    if (!currentCowCell.hasNoCow) {
      if (currentCowCell.cowType != turnPlayer.cowType) {
        throw Exception('please select empty position or your own cow to move');
      }
      return selectCowToMoveGameState(currentCowCell);
    }

    final validMoves = board.getCurrentCowValidMoves(board.selectedCowToMove!);
    if (!validMoves.any((e) => e == currentCowCell)) {
      throw Exception('Selected position is not valid');
    }

    return moveCowGameState(currentCowCell);
  }

  MorabarabaGameModel moveCowGameState(MorabarabaCowCell currentCowCell) {
    final newBoard = board.moveCowBoardState(currentCowCell);

    if (newBoard.isCowCapture) {
      newBoard.highlightCaptureCells(true);
      return copyWith(
        board: newBoard,
        gameAction: MorabarabaGameAction.capture,
      );
    }
    return copyWith(
      board: newBoard,
      turnIndex: nextTurnIndex,
      gameAction: MorabarabaGameAction.select,
      players: [
        for (final player in players)
          if (player.isTurn)
            player.copyWith(isTurn: false)
          else
            player.copyWith(isTurn: true)
      ],
    );
  }

  MorabarabaGameModel selectCowToCaptureGameState(
      MorabarabaCowCell currentCowCell) {
    if (!currentPlayer.isTurn) {
      throw Exception('Sorry,  is not your turn');
    }
    if (currentCowCell.hasNoCow) {
      throw Exception('Please select a cell with a cow');
    }
    if (currentCowCell.cowType == turnPlayer.cowType) {
      throw Exception('Please select another player cow');
    }
    // if (!noCowToPlace) {
    //   throw Exception('Please Place A cow');
    // }

    final newBoard = board.captureCowBoardState(currentCowCell);
    newBoard.highlightCaptureCells(false);

    return copyWith(
      board: newBoard,
      turnIndex: nextTurnIndex,
      gameAction: noCowToPlace
          ? MorabarabaGameAction.select
          : MorabarabaGameAction.place,
      players: [
        for (final player in players)
          if (player.isTurn)
            player.copyWith(
              isTurn: false,
              capturedCows: [
                ...player.capturedCows,
                currentCowCell,
              ],
            )
          else
            player.copyWith(isTurn: true)
      ],
    );
  }

  bool get noCowToPlace => players.every((e) => e.cowsInHand < 1);
  //bool get noCowToPlace => turnPlayer.cowsInHand < 1;
  MorabarabaPlayerModel get turnPlayer => players[turnIndex];

  @override
  MorabarabaPlayerModel get currentPlayer {
    if (gameMode == GameMode.offline) {
      return players[turnIndex];
    }
    return players.firstWhere(
      (e) => e.id == profileId,
      orElse: () => MorabarabaPlayerModel(
        id: 'No Id',
        username: 'No player',
        cowType: MorabarabaCowType.none,
      ),
    );
  }

  @override
  List<MorabarabaPlayerModel> get otherPlayers =>
      players.where((e) => e.id != profileId).toList();

  @override
  MorabarabaPlayerModel get winner => throw UnimplementedError();

  @override
  MorabarabaGameModel copyWith({
    String? id,
    String? profileId,
    bool? gameOver,
    bool? started,
    List<MorabarabaPlayerModel>? players,
    GameType? gameType,
    GameMode? gameMode,
    MorabarabaBoardModel? board,
    MorabarabaGameAction? gameAction,
    int? turnIndex,
  }) {
    return MorabarabaGameModel(
      turnIndex: turnIndex ?? this.turnIndex,
      id: id ?? this.id,
      board: board ?? this.board,
      players: players ?? this.players,
      gameType: gameType ?? this.gameType,
      gameMode: gameMode ?? this.gameMode,
      gameOver: gameOver ?? this.gameOver,
      profileId: profileId ?? this.profileId,
      gameAction: gameAction ?? this.gameAction,
    );
  }

  factory MorabarabaGameModel.fromMap(Map<String, dynamic> map) {
    final extra = map['extra_props'] as Map<String, dynamic>;
    return MorabarabaGameModel(
      id: map['id'] as String,
      gameType: GameType.values.firstWhere((e) => e.name == map['game_type']),
      gameMode: GameMode.values.firstWhere((e) => e.name == map['game_mode']),
      players: List<MorabarabaPlayerModel>.from(
          (map['players'] as List<dynamic>).map<PlayerModel>(
              (x) => PlayerModel.fromMap(x as Map<String, dynamic>))),
      started: map['started'] as bool,
      gameOver: map['game_over'] as bool,
      board: MorabarabaBoardModel.fromMap(
        extra['board'] as Map<String, dynamic>,
      ),
      turnIndex: extra['turn_index'] as int,
      gameAction: MorabarabaGameAction.values
          .firstWhere((e) => e.name == extra['game_action']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'game_type': gameType.name,
      'game_mode': gameMode.name,
      'players': players.map((x) => x.toMap()).toList(),
      'started': started,
      'game_over': gameOver,
      'extra_props': {
        'board': board.toMap(),
        'turn_index': turnIndex,
        'game_action': gameAction,
      }
    };
  }
}
