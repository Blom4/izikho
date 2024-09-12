import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/common/utils/snackbar.dart';

import '../models/marabaraba_player_model.dart';
import '../models/morabaraba_cell_models.dart';
import '../models/morabaraba_game_model.dart';
import '../providers/morabaraba_game_provider.dart';
import '../widgets/Morabaraba_board_widget.dart';
import '../widgets/morabaraba_cow_cell_widget.dart';

class MorabarabaGameScreen extends StatefulHookConsumerWidget {
  static const String routename = 'morabaraba_game_screen';
  const MorabarabaGameScreen({
    super.key,
    required this.gameOptions,
  });
  final MorabarabaGameOptions gameOptions;

  @override
  ConsumerState<MorabarabaGameScreen> createState() =>
      _MorabarabaGameScreenState();
}

class _MorabarabaGameScreenState extends ConsumerState<MorabarabaGameScreen> {
  void updateBoard(MorabarabaCowCell cowCell) {
    try {
      // print(cowCell);
      ref
          .read(morabarabaGameProvider(widget.gameOptions).notifier)
          .updatGameState(cowCell);
    } catch (e) {
      //throw Exception(e);
      context.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final game = ref.watch(morabarabaGameProvider(widget.gameOptions));
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                PlayerInfoWidget(
                  player: game.players.first,
                  isPlayerOne: true,
                ),
                Flexible(
                  flex: 5,
                  child: MorabarabaBoardWidget(
                    board: game.board,
                    updateBoard: updateBoard,
                  ),
                ),
                PlayerInfoWidget(
                  player: game.players.last,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlayerInfoWidget extends StatelessWidget {
  const PlayerInfoWidget({
    super.key,
    required this.player,
    this.isPlayerOne = false,
  });
  final MorabarabaPlayerModel player;
  final bool isPlayerOne;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                player.isTurn ? "(your turn)" : "",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.undo)),
                  if (isPlayerOne)
                    IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CowStackWidget(
                  cows: [
                    for (int i = 1; i <= player.cowsInHand; i++)
                      MorabarabaCowCell(
                        row: 1,
                        col: 1,
                        cellIndex: 0,
                        cowType: player.cowType,
                      ),
                  ],
                  cowSize: 20,
                ),
                const SizedBox(width: 5),
                CowStackWidget(
                  cows: player.capturedCows,
                  cowSize: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CowStackWidget extends StatelessWidget {
  const CowStackWidget({
    super.key,
    required this.cows,
    required this.cowSize,
    this.overlapFactor = 0.5,
    this.backgroundColor = Colors.black12,
  });

  final List<MorabarabaCowCell> cows;
  final double cowSize;
  final double overlapFactor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: (cowSize * 12 * overlapFactor) + 15,
      height: cowSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(100)),
      ),
      child: Stack(
        children: [
          for (int i = 0; i < cows.length; i++)
            Container(
              margin: EdgeInsets.only(left: (i.toDouble() * cowSize) * 0.5),
              child: MorabarabaCow(
                cow: cows[i],
                size: cowSize,
              ),
            )
        ],
      ),
    );
  }
}

//5679Word@9
//morabaraba solution 1.41.30
