import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/widgets/game_screen_header_widget.dart';
import '../models/fivecards_player_model.dart';
import '../../common/models/game_playing_card.dart';
import '../models/fivecards_game_model.dart';
import 'fivecards_player_cards_widget.dart';
import 'fivecards_players_info_widget.dart';
import 'fivecards_playground_widget.dart';

class FivecardsGameWidget extends HookConsumerWidget {
  final FivecardsGameModel game;
  final void Function(GamePlayingCard) onPlayCard;
  final void Function() onDeckCard;
  final void Function() onPlayedCard;
  final void Function() onSortPlayerCards;

  const FivecardsGameWidget({
    super.key,
    required this.game,
    required this.onPlayCard,
    required this.onDeckCard,
    required this.onPlayedCard,
    required this.onSortPlayerCards,
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
            FivecardsPlayersInfoWidget(
              otherPlayers: game.otherPlayers,
            ),
            const SizedBox(height: 10),
            playerTurn(game.turnPlayer),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FivecardsDeckWidget(deck: game.deck),
                //playableCard(game.playable),
                const SizedBox(width: 20),
                FivecardsPlayedCardsWidget(
                  playedCards: game.playedCards,
                  onPlayCard: onPlayCard,
                ),
              ],
            ),
            FivecardsPlayerCardsWidget(
              player: game.currentPlayer,
              onDeckCard: onDeckCard,
              onPlayedCard: onPlayedCard
            ),
            const SizedBox(height: 10),
            FivecardsCurrentPlayerInfoWidget(
              player: game.currentPlayer,
              deckLength: game.deck.length,
              playedLength: game.playedCards.length,
              onSortPlayerCards: onSortPlayerCards
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

  Text playerTurn(FivecardsPlayerModel turn) {
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

class FivecardsCurrentPlayerInfoWidget extends StatelessWidget {
  const FivecardsCurrentPlayerInfoWidget({
    super.key,
    required this.player,
    required this.deckLength,
    required this.playedLength,
    required this.onSortPlayerCards,
  });

  final FivecardsPlayerModel player;
  final int deckLength;
  final int playedLength;
  final void Function() onSortPlayerCards;
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
            icon: const Icon(Icons.sort),
            onPressed:onSortPlayerCards,
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
