import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

import '../models/play_card.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.card,
    this.margin = 0,
    this.size = 90,
    this.showBack = false,
  });
  final double size;
  final bool showBack;
  final PlayCard card;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: margin),
      width: size,
      constraints: const BoxConstraints(maxWidth: 250),
      child: PlayingCardView(
        showBack: showBack,
        card: PlayingCard(card.suit, card.value),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
    );
  }
}
