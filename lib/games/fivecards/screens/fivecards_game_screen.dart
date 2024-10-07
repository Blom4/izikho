import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/common/utils/snackbar.dart';

import '../../../common/screens/home_screen.dart';
import '../models/fivecards_game_model.dart';
import '../../common/models/game_playing_card.dart';
import '../providers/fivecards_game_provider.dart';
import '../widgets/fivecards_game_widget.dart';

class FivecardsGameScreen extends StatefulHookConsumerWidget {
  //const FivecardsGameScreen({super.key});
  const FivecardsGameScreen({super.key, required this.game});
  final FivecardsGameModel game;
  static const String routename = "fivecards-game-screen";                                

  @override
  ConsumerState<FivecardsGameScreen> createState() =>
      _FivecardsGameScreenState();
}

class _FivecardsGameScreenState extends ConsumerState<FivecardsGameScreen> {
  @override
  void initState() {
    super.initState();
    // ref.listenManual(gameOnlineProvider(widget.game.id).future,
    //     (_, next) async {
    //   var game = await next as FivecardsGameModel;
    //   if (game.currentPlayer.isTurn && game.currentPlayer.isShot) {
    //     await handleShot(game.currentPlayer);
    //   }
    // });
    Future(
      () => ref.read(fivecardsGameProvider(widget.game).notifier).serveCards(4),
    );
  }

  Future<void> handlePlayCard(GamePlayingCard card) async {
    try {
      final gameNotifier =
          ref.read(fivecardsGameProvider(widget.game).notifier);
      await gameNotifier.play(card);
    } catch (e) {
      if (mounted) {
        context.showSnackBar(e.toString(), isError: true);
      }
    }
  }

  void handleDeckCard() async {
    try {
      final gameNotifier =
          ref.read(fivecardsGameProvider(widget.game).notifier);
      gameNotifier.popDeck();
    } catch (e) {
      context.showSnackBar(e.toString(), isError: true);
    }
  }

  void handlePlayedCard() async {
    try {
      final gameNotifier =
          ref.read(fivecardsGameProvider(widget.game).notifier);
      gameNotifier.popPlayedCard();
    } catch (e) {
      context.showSnackBar(e.toString(), isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(fivecardsGameProvider(widget.game));
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            FivecardsGameWidget(
              game: gameState.data,
              onPlayCard: handlePlayCard,
              onDeckCard: handleDeckCard,
              onPlayedCard: handlePlayedCard,
              onSortPlayerCards: () => ref
                  .read(fivecardsGameProvider(gameState.data).notifier)
                  .sortPlayerCards(),
            ),
            if (gameState.loading)
              const Dialog.fullscreen(
                backgroundColor: Colors.black45,
                child: Center(child: CircularProgressIndicator()),
              ),
            if (gameState.error != null)
              Dialog.fullscreen(
                backgroundColor: Colors.black45,
                child: AlertDialog(
                  content: Text(gameState.error!),
                ),
              ),
            if (gameState.data.gameOver)
              Dialog.fullscreen(
                backgroundColor: Colors.black45,
                child: AlertDialog(
                  title: const Text('Game Over'),
                  content: Text(
                      "${gameState.data.isWinner ? 'You' : gameState.data.winner.username} won"),
                  actions: [
                    TextButton(
                      onPressed: () {},
                      child: const Text("Play Again"),
                    ),
                    TextButton(
                      onPressed: () => context.goNamed(HomeScreen.routename),
                      child: const Text("Quit"),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
