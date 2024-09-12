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

  // void startGame(MorabarabaGameOptions options) {
  //   final newGame = state.copyWith(
  //     players:options.players,
  //   );
  //   state = newGame;
  // }

  void updatGameState(MorabarabaCowCell currentCowCell) {
    state = state.updatedGameState(currentCowCell);
  }
}
