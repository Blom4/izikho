import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/games/krusaid/widgets/playground_widget.dart';

import '../models/krusaid_player_model.dart';
import '../models/play_card.dart';
import '../models/krusaid_game_model.dart';
import 'player_cards_widget.dart';
import 'other_players_info_widget.dart';

class KrusaidGameWidget extends HookConsumerWidget {
  final KrusaidGameModel game;
  final void Function(PlayCard) onPlayCard;
  final void Function(PlayCard) onDeckCard;

  const KrusaidGameWidget({
    super.key,
    required this.game,
    required this.onPlayCard,
    required this.onDeckCard,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          OtherPlayersInfoWidget(
            otherPlayers: game.otherPlayers,
          ),
          playerTurn(game.turnPlayer),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DeckWidget(deck: game.deck),
                      playableCard(game.playable),
                      PlayedCardsWidget(
                        playedCards: game.playedCards,
                        onPlayCard: onPlayCard,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                PlayerCardsWidget(
                  player: game.currentPlayer,
                  onDeckCard: onDeckCard,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  FittedBox playableCard(Playable playable) {
    return FittedBox(
      child: SizedBox(
        width: 20,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            playable.symbol,
            style: TextStyle(color: playable.color),
          ),
        ),
      ),
    );
  }

  Text playerTurn(KrusaidPlayerModel turn) {
    return Text.rich(
      TextSpan(
        text: "${game.isMyTurn ? 'Your ' : '${turn.username}\' '} ",
        children: const [
          TextSpan(
            text: 'turn',
            style: TextStyle(color: Colors.deepPurple),
          )
        ],
      ),
    );
  }
}
