import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/common/utils/snackbar.dart';

import '../../common/widgets/game_screen_header_widget.dart';
import '../models/marabaraba_player_model.dart';
import '../models/morabaraba_cell_models.dart';
import '../models/morabaraba_game_model.dart';
import '../providers/morabaraba_game_provider.dart';
import '../widgets/morabaraba_board_widget.dart';
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
      ref
          .read(morabarabaGameProvider(widget.gameOptions).notifier)
          .updateGame(cowCell);
    } catch (e) {
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
                GameScreenHeaderWidget(title: game.gameType.name),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 20),
                    MorabarabaPlayerInfoWidget(
                      player: game.players.first,
                    ),
                    const SizedBox(height: 10),
                    Text(
                        '${game.turnPlayer.username}(${game.turnPlayer.cowType.name})\'s turn'),
                    const SizedBox(height: 10),
                    MorabarabaBoardWidget(
                      board: game.board,
                      updateBoard: updateBoard,
                    ),
                    const SizedBox(height: 20),
                    MorabarabaPlayerInfoWidget(
                      player: game.players.last,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MorabarabaPlayerInfoWidget extends StatelessWidget {
  const MorabarabaPlayerInfoWidget({
    super.key,
    required this.player,
  });

  final MorabarabaPlayerModel player;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color:
            Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            child: Icon(
              Icons.person,
              size: 30,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${player.username}  ( ${player.cowType.name} )',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            cowSize: 17,
                          ),
                          Text(
                            'In Hand ( ${player.cowsInHand} )',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                        ],
                      ),
                      //const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CowStackWidget(
                            cows: player.capturedCows,
                            cowSize: 17,
                          ),
                          Text(
                            'Captured ( ${player.capturedCows.length} )',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              // showMenu(
              //   context: context,
              //   position: RelativeRect.fromRect(, container),
              //   items: [
              //     const PopupMenuItem(
              //       child: Text('Quit'),
              //     ),
              //   ],
              // );
            },
            icon: const Icon(Icons.menu),
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
