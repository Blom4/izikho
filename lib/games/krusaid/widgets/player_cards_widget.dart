import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playing_cards/playing_cards.dart';

import '../../../common/responsive/responsive.dart';
import '../components/play_card.dart';
import '../models/krusaid_player_model.dart';
import 'card_widget.dart';

class PlayerCardsWidget extends StatefulHookConsumerWidget {
  const PlayerCardsWidget({
    super.key,
    required this.player
  });

  final KrusaidPlayerModel player;

  @override
  ConsumerState<PlayerCardsWidget> createState() => _PlayerCardsWidgetState();
}

class _PlayerCardsWidgetState extends ConsumerState<PlayerCardsWidget> {
@override
  Widget build(BuildContext context) {
    return FittedBox(
      child: DragTarget<PlayCard>(
          onAcceptWithDetails: (card) {},
          builder: (context, candidateData, rejectedData) {
            return FlatCardFan(children: [
              const SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: Text("Player Cards"),
                ),
              ),
              ...List.generate(
                widget.player.cards.length,
                (index) => Draggable<PlayCard>(
                  data: widget.player.cards[index],
                  childWhenDragging: Container(),
                  feedback: CardWidget(
                    margin: Responsive.isMobile(context)
                        ? (100 * index.toDouble()) / 6
                        : 100 * index.toDouble() * 0.25,
                    size: Responsive.isMobile(context) ? 95 : 100,
                    card: widget.player.cards[index],
                  ),
                  child: CardWidget(
                    margin: Responsive.isMobile(context)
                        ? (100 * index.toDouble()) / 6
                        : 100 * index.toDouble() * 0.25,
                    size: Responsive.isMobile(context) ? 95 : 100,
                    card: widget.player.cards[index],
                  ),
                ),
              ),
            ]);
          }),
    );
  }
}
