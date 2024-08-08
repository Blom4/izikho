import 'package:playing_cards/playing_cards.dart';


class PlayCard {
  // The suit of the card.
  final Suit suit;
  // The rank of the card. ace->king.
  final CardValue value;

  // Creates a playing card.
  PlayCard(
    this.suit,
    this.value,
  );

  PlayCard copyWith({
    Suit? suit,
    CardValue? value,
  }) {
    return PlayCard(
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

  factory PlayCard.fromMap(Map<String, dynamic> map) {
    return PlayCard(
      Suit.values.firstWhere((element) => element.name == map['suit']),
      CardValue.values.firstWhere((element) => element.name == map['value']),
    );
  }

  @override
  String toString() => 'PlayCard(suit: $suit, value: $value)';

  @override
  bool operator ==(covariant PlayCard other) {
    if (identical(this, other)) return true;

    return other.suit == suit && other.value == value;
  }

  @override
  int get hashCode => suit.hashCode ^ value.hashCode;
}
