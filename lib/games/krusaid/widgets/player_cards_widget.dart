import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playing_cards/playing_cards.dart';

import '../../../common/responsive/responsive.dart';
import '../components/play_card.dart';
import '../providers/krusaid_player_provider.dart';
import 'card_widget.dart';

class PlayerCardsWidget extends ConsumerWidget {
  const PlayerCardsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerProvider = ref.watch(krusaidPlayerProvider);
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
                playerProvider.cards.length,
                (index) => Draggable<PlayCard>(
                  data: playerProvider.cards[index],
                  childWhenDragging: Container(),
                  feedback: CardWidget(
                    margin: Responsive.isMobile(context)
                        ? (100 * index.toDouble()) / 6
                        : 100 * index.toDouble() * 0.25,
                    size: Responsive.isMobile(context) ? 95 : 100,
                    card: playerProvider.cards[index],
                  ),
                  child: CardWidget(
                    margin: Responsive.isMobile(context)
                        ? (100 * index.toDouble()) / 6
                        : 100 * index.toDouble() * 0.25,
                    size: Responsive.isMobile(context) ? 95 : 100,
                    card: playerProvider.cards[index],
                  ),
                ),
              ),
            ]);
          }),
    );
  }
}
