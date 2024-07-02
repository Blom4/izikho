import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

class MappedSuit {
  final Color color;
  final String symbol;
  final Suit suit;
  const MappedSuit({
    required this.color,
    required this.symbol,
    required this.suit,
  });

  MappedSuit copyWith({
    Color? color,
    String? symbol,
    Suit? suit,
  }) {
    return MappedSuit(
      color: color ?? this.color,
      symbol: symbol ?? this.symbol,
      suit: suit ?? this.suit,
    );
  }
}

const List<MappedSuit> mappedSuits = [
  MappedSuit(
    color: Colors.black,
    symbol: '♠',
    suit: Suit.spades,
  ),
  MappedSuit(
    color: Colors.red,
    symbol: '♥',
    suit: Suit.hearts,
  ),
  MappedSuit(
    color: Colors.black,
    symbol: '♣',
    suit: Suit.clubs,
  ),
  MappedSuit(
    color: Colors.red,
    symbol: '♦',
    suit: Suit.diamonds,
  ),
];
