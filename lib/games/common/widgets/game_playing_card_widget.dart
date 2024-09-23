import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

import '../models/game_playing_card.dart';

class GamePlayingCardWidget extends StatelessWidget {
  const GamePlayingCardWidget({
    super.key,
    required this.card,
    this.showBack = false,
  });

  final bool showBack;
  final GamePlayingCard card;

  @override
  Widget build(BuildContext context) {
    return PlayingCardView(
      showBack: showBack,
      card: PlayingCard(card.suit, card.value),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
