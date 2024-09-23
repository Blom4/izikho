import 'package:playing_cards/playing_cards.dart';

import 'game_playing_card.dart';

class GameDeck {
  /// Generates a standard 52 card deck.
  static List<GamePlayingCard> myStandardFiftyTwoCardDeck() {
    List<GamePlayingCard> cards = [];
    for (Suit suit in STANDARD_SUITS) {
      for (CardValue v in SUITED_VALUES) {
        cards.add(GamePlayingCard(suit, v));
      }
    }

    return cards;
  }

// Standard fifty two card deck + two jokers.
  static List<GamePlayingCard> myStandardFiftyFourCardDeck() {
    List<GamePlayingCard> cards = myStandardFiftyTwoCardDeck();

    for (CardValue v in JOKER_VALUES) {
      cards.add(GamePlayingCard(Suit.joker, v));
    }
    return cards;
  }
}
