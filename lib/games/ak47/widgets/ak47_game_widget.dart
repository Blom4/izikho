import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/widgets/game_screen_header_widget.dart';
import '../models/ak47_player_model.dart';
import '../../common/models/game_playing_card.dart';
import '../models/ak47_game_model.dart';
import 'ak47_player_cards_widget.dart';
import 'ak47_players_info_widget.dart';
import 'ak47_playground_widget.dart';

class Ak47GameWidget extends HookConsumerWidget {
  final Ak47GameModel game;
  final void Function(GamePlayingCard) onPlayCard;
  final void Function(GamePlayingCard) onDeckCard;

  const Ak47GameWidget({
    super.key,
    required this.game,
    required this.onPlayCard,
    required this.onDeckCard,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: FittedBox(
        fit: BoxFit.cover,
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //mainAxisSize: MainAxisSize.min,
          children: [
            GameScreenHeaderWidget(
              title: game.gameType.name,
            ),
            const SizedBox(height: 20),
            Ak47PlayersInfoWidget(
              otherPlayers: game.otherPlayers,
            ),
            const SizedBox(height: 10),
            playerTurn(game.turnPlayer),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ak47DeckWidget(deck: game.deck),
                playableCard(game.playable),
                Ak47PlayedCardsWidget(
                  playedCards: game.playedCards,
                  onPlayCard: onPlayCard,
                ),
              ],
            ),
            Ak47PlayerCardsWidget(
              player: game.currentPlayer,
              onDeckCard: onDeckCard,
            ),
            const SizedBox(height: 10),
            Ak47CurrentPlayerInfoWidget(
              player: game.currentPlayer,
              deckLength: game.deck.length,
              playedLength: game.playedCards.length,
            )
          ],
        ),
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

  Text playerTurn(Ak47PlayerModel turn) {
    return Text.rich(
      TextSpan(
        text: "${game.isMyTurn ? 'Your ' : '${turn.username}\'s'} ",
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

class Ak47CurrentPlayerInfoWidget extends StatelessWidget {
  const Ak47CurrentPlayerInfoWidget({
    super.key,
    required this.player,
    required this.deckLength,
    required this.playedLength,
  });

  final Ak47PlayerModel player;
  final int deckLength;
  final int playedLength;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Badge.count(
            count: player.cards.length,
            alignment: Alignment.bottomRight,
            child: const CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YOU',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Row(
                  children: [
                    Text(
                      'Deck: ($deckLength)',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Played: ($playedLength)',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
