import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/responsive/responsive.dart';
import '../models/play_card.dart';
import '../models/krusaid_game_model.dart';
import 'custom_bottom_appbar.dart';
import 'player_cards_widget.dart';
import 'players_widget.dart';
import 'playground_widget.dart';

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
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PlayersWidget(players: game.players),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: PlayGroundWidget(
                        deckWidget: DeckWidget(deck: game.deck),
                        infoWidget: InfoWidget(
                          numOfDeckCards: game.deckCount,
                          turnPlayerName: game.currentPlayer.isTurn
                              ? "You"
                              : game.turnPlayer.username,
                          playable: game.playable,
                        ),
                        playedCardsWidget: PlayedCardsWidget(
                          playedCards: game.playedCards,
                          onPlayCard: onPlayCard,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: Responsive.isMobile(context) ? 3 : 4,
                      child: PlayerCardsWidget(
                        player: game.currentPlayer,
                        onDeckCard: onDeckCard,
                      ),
                    ),
                  ],
                ),
              ),
              if (!Responsive.isMobile(context)) const CustomBottomAppBar()
            ],
          ),
        ),
      ),
    );
  }
}
