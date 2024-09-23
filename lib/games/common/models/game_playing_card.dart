import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

enum Playable {
  any(color: Colors.black, suit: Suit.joker, symbol: ' * '),
  spades(color: Colors.black, suit: Suit.spades, symbol: '♠'),
  hearts(color: Colors.red, suit: Suit.hearts, symbol: '♥'),
  diamonds(color: Colors.red, suit: Suit.diamonds, symbol: '♦'),
  clubs(color: Colors.black, suit: Suit.clubs, symbol: '♣');

  final Color color;
  final String symbol;
  final Suit suit;

  const Playable({
    required this.color,
    required this.symbol,
    required this.suit,
  });
}

class GamePlayingCard {
  // The suit of the card.
  final Suit suit;
  // The rank of the card. ace->king.
  final CardValue value;

  // Creates a playing card.
  GamePlayingCard(
    this.suit,
    this.value,
  );

  GamePlayingCard copyWith({
    Suit? suit,
    CardValue? value,
  }) {
    return GamePlayingCard(
      suit ?? this.suit,
      value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'suit': suit.name,
      'value': value.name,
    };
  }

  factory GamePlayingCard.fromMap(Map<String, dynamic> map) {
    return GamePlayingCard(
      Suit.values.firstWhere((element) => element.name == map['suit']),
      CardValue.values.firstWhere((element) => element.name == map['value']),
    );
  }

  @override
  String toString() => 'GamePlayingCard(suit: $suit, value: $value)';

  @override
  bool operator ==(covariant GamePlayingCard other) {
    if (identical(this, other)) return true;

    return other.suit == suit && other.value == value;
  }

  @override
  int get hashCode => suit.hashCode ^ value.hashCode;
}

extension CardValueExtension on CardValue {
  String get shortName {
    switch (this) {
      case CardValue.two:
        return "2";
      case CardValue.three:
        return "3";
      case CardValue.four:
        return "4";
      case CardValue.five:
        return "5";
      case CardValue.six:
        return "6";
      case CardValue.seven:
        return "7";
      case CardValue.eight:
        return "8";
      case CardValue.nine:
        return "9";
      case CardValue.ten:
        return "I0";
      case CardValue.jack:
        return "J";
      case CardValue.queen:
        return "Q";
      case CardValue.king:
        return "K";
      case CardValue.ace:
        return "A";
      case CardValue.joker_1:
      case CardValue.joker_2:
        return "JOKER";
    }
  }

  int get rank {
    switch (this) {
      case CardValue.ace:
        return 1;
      case CardValue.two:
        return 2;
      case CardValue.three:
        return 3;
      case CardValue.four:
        return 4;
      case CardValue.five:
        return 5;
      case CardValue.six:
        return 6;
      case CardValue.seven:
        return 7;
      case CardValue.eight:
        return 8;
      case CardValue.nine:
        return 9;
      case CardValue.ten:
        return 10;
      case CardValue.jack:
        return 11;
      case CardValue.queen:
        return 12;
      case CardValue.king:
        return 13;
      case CardValue.joker_1:
        return 14;
      case CardValue.joker_2:
        return 15;
    }
  }
}
