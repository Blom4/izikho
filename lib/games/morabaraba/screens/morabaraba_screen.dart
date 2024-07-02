import 'package:flutter/material.dart';

import '../components/cow.dart';
import '../components/game.dart';
import '../widgets/boardview_widget.dart';
import '../widgets/cow_widget.dart';

class MorabarabaScreen extends StatefulWidget {
  static const String routename = 'morabaraba_game_screen';
  const MorabarabaScreen({super.key});

  @override
  State<MorabarabaScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<MorabarabaScreen> {
  late Game game;
  @override
  void initState() {
    game = Game(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                PlayerInfoWidget(
                  playerName: "Player 1",
                  captureCows: game.whiteCaptured,
                  cowsToPlay: game.whiteCows,
                  isWhiteTurn: game.isWhiteTurn,
                  isPlayerOne: true,
                ),
                Flexible(
                  flex: 5,
                  child: BoardViewWidget(
                    board: game.board,
                    updateBoard: (row, col) {
                      setState(() {
                        game.updateBoard(row, col);
                      });
                    },
                  ),
                ),
                PlayerInfoWidget(
                  playerName: "Player 2",
                  cowsToPlay: game.blackCows,
                  captureCows: game.blackCaptured,
                  isWhiteTurn: !game.isWhiteTurn,
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
    required this.playerName,
    required this.captureCows,
    required this.cowsToPlay,
    required this.isWhiteTurn,
    this.isPlayerOne = false,
  });
  final String playerName;
  final bool isPlayerOne;
  final List<Cow> captureCows;
  final List<Cow> cowsToPlay;
  final bool isWhiteTurn;

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
                "$playerName ${isWhiteTurn ? "(your turn)" : ""}",
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
                  cows: cowsToPlay,
                  cowSize: 20,
                ),
                const SizedBox(width: 5),
                CowStackWidget(
                  cows: captureCows,
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

  final List<Cow> cows;
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
              child: CowWidget(
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
