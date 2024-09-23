import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:izikho/games/common/dialogs/deck_dialog.dart';
import 'package:izikho/games/krusaid/dialogs/krusaid_dialogs.dart';

import 'package:playing_cards/playing_cards.dart';

import '../../../common/screens/home_screen.dart';
import '../../common/providers/game_online_provider.dart';
import '../models/krusaid_game_model.dart';
import '../models/krusaid_player_model.dart';
import '../../common/models/game_playing_card.dart';
import '../providers/krusaid_game_provider.dart';
import '../widgets/krusaid_game_widget.dart';

class KrusaidGameScreen extends StatefulHookConsumerWidget {
  //const KrusaidGameScreen({super.key});
  const KrusaidGameScreen({super.key, required this.game});
  final KrusaidGameModel game;
  static const String routename = "Krusaid-game-screen";

  @override
  ConsumerState<KrusaidGameScreen> createState() => _KrusaidGameScreenState();
}

class _KrusaidGameScreenState extends ConsumerState<KrusaidGameScreen> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(gameOnlineProvider(widget.game.id).future,
        (_, next) async {
      var game = await next as KrusaidGameModel;
      if (game.currentPlayer.isTurn && game.currentPlayer.isShot) {
        await handleShot(game.currentPlayer);
      }
    });
    Future(
      () => ref.read(krusaidGameProvider(widget.game).notifier).serveCards(4),
    );
  }

  Future<void> handlePlayCard(GamePlayingCard card) async {
    final game = ref.read(krusaidGameProvider(widget.game)).data;
    if (!game.currentPlayer.isTurn) {
      return;
    }
    if (game.isPlayable(card)) {
      final gameNotifier = ref.read(krusaidGameProvider(widget.game).notifier);
      if (game.islastPlayCard) {
        await gameNotifier.play(card, Playable.any);
        return;
      }
      switch (card.value) {
        case CardValue.eight:
          final playable = await context.showEightDialog();
          if (playable != null) {
            await gameNotifier.play(card, playable);
          }
          break;
        case CardValue.joker_1 || CardValue.joker_2:
          final isShoot = await context.showJokerDialog();
          if (isShoot != null) {
            if (isShoot) {
              await gameNotifier.play(card, Playable.any);
            } else {
              if (mounted) {
                final playable = await context.showEightDialog();
                if (playable != null) {
                  await gameNotifier.play(card, playable);
                }
              }
            }
          }
          break;
        default:
          final playable = Playable.values.firstWhere(
            (e) => e.suit == card.suit,
          );
          await gameNotifier.play(card, playable);
      }
    }
  }

  void handleDeckCard(GamePlayingCard card) async {
    final game = ref.read(krusaidGameProvider(widget.game)).data;
    if (!game.currentPlayer.isTurn) {
      return;
    }

    final playableCards = [
      card,
      ...game.currentPlayer.cards,
    ].where((e) => game.isPlayable(e)).toList();

    final gameNotifier = ref.read(krusaidGameProvider(widget.game).notifier);
    gameNotifier.popDeck();
    if (playableCards.isEmpty) {
      await gameNotifier.playDeck();
    } else {
      final deckCard = await context.showDeckDialog(playableCards);
      if (deckCard == null) {
        await gameNotifier.playDeck();
      } else {
        await handlePlayCard(deckCard);
      }
    }
  }

  Future<void> handleShot(KrusaidPlayerModel player) async {
    final gameNotifier = ref.read(krusaidGameProvider(widget.game).notifier);
    final gunCards = player.cards
        .where(
          (e) => e.suit == Suit.joker || e.value == CardValue.two,
        )
        .toList();

    if (gunCards.isEmpty) {
      await gameNotifier.acceptShot(player);
    } else {
      final gunCard = await context.showShotDialog(gunCards);
      if (gunCard == null) {
        await gameNotifier.acceptShot(player);
      } else {
        gunCard.suit == Suit.joker
            ? await gameNotifier.play(gunCard, Playable.any)
            : await gameNotifier.play(
                gunCard,
                Playable.values.firstWhere((e) => e.suit == gunCard.suit),
              );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(krusaidGameProvider(widget.game));
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            KrusaidGameWidget(
              game: gameState.data,
              onDeckCard: handleDeckCard,
              onPlayCard: handlePlayCard,
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
