import 'package:playing_cards/playing_cards.dart';

import 'play_card.dart';

/// Generates a standard 52 card deck.
List<PlayCard> myStandardFiftyTwoCardDeck() {
  List<PlayCard> cards = [];
  for (Suit suit in STANDARD_SUITS) {
    for (CardValue v in SUITED_VALUES) {
      cards.add(PlayCard(suit, v));
    }
  }

  return cards;
}

// Standard fifty two card deck + two jokers.
List<PlayCard> myStandardFiftyFourCardDeck() {
  List<PlayCard> cards = myStandardFiftyTwoCardDeck();

  for (CardValue v in JOKER_VALUES) {
    cards.add(PlayCard(Suit.joker, v));
  }
  return cards;
}
