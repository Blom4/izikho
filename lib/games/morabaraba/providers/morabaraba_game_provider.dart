import 'package:izikho/games/morabaraba/models/morabaraba_cell_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/models/game_model.dart';
import '../models/morabaraba_board_model.dart';
import '../models/morabaraba_game_model.dart';
import '../utils/morabaraba_utils.dart';

part 'morabaraba_game_provider.g.dart';

@riverpod
class MorabarabaGame extends _$MorabarabaGame {
  @override
  MorabarabaGameModel build(MorabarabaGameOptions options) {
    return MorabarabaGameModel(
      started: true,
      gameMode: GameMode.offline,
      players: options.players,
      gameType: GameType.morabaraba,
      board: MorabarabaBoardModel(
        boardCells: MorabarabaUtils.generateBoardCells(),
      ),
    );
  }

  void updateGame(MorabarabaCowCell currentCowCell) {
    final newGameState = switch (state.gameAction) {
      MorabarabaGameAction.place => () {
          var newGameState = state.placeCowGameState(currentCowCell);
          if (newGameState.noCowToPlace) {
            newGameState = newGameState.copyWith(
              gameAction: MorabarabaGameAction.select,
            );
          }
          return newGameState;
        }(),
      MorabarabaGameAction.select =>
        state.selectCowToMoveGameState(currentCowCell),
      MorabarabaGameAction.move => state.checkMoveGameState(currentCowCell),
      MorabarabaGameAction.capture =>
        state.selectCowToCaptureGameState(currentCowCell)
    };
    final allValidMoves = newGameState.board.allBoardValidMoves(
      newGameState.turnPlayer.cowType,
    );

    if (newGameState.gameAction == MorabarabaGameAction.select &&
        allValidMoves.isEmpty) {
      state = newGameState.copyWith(
        turnIndex: newGameState.nextTurnIndex,
        players: [
          for (final player in newGameState.players)
            if (player.isTurn)
              player.copyWith(isTurn: false)
            else
              player.copyWith(isTurn: true)
        ],
      );
    } else {
      state = newGameState;
    }
  }
}
