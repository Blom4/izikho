// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'play_card.dart';

class Player {
  final String id;
  final String username;
  final List<PlayCard> cards;
  final int index;
  final bool isTurn;
  final bool isShot;
  final bool joined;
  final int cardsToTake;

  Player({
    required this.id,
    required this.username,
    this.cards = const [],
    required this.index,
    this.isTurn = false,
    this.isShot = false,
    this.joined = false,
    this.cardsToTake = 0,
  });

  bool get hasCards => cards.isNotEmpty;

  Player copyWith({
    String? id,
    String? username,
    List<PlayCard>? cards,
    int? index,
    bool? isTurn,
    bool? isShot,
    bool? joined,
    int? cardsToTake,
  }) {
    return Player(
      id: id ?? this.id,
      username: username ?? this.username,
      cards: cards ?? this.cards,
      index: index ?? this.index,
      isTurn: isTurn ?? this.isTurn,
      isShot: isShot ?? this.isShot,
      joined: joined ?? this.joined,
      cardsToTake: cardsToTake ?? this.cardsToTake,
    );
  }

  @override
  String toString() {
    return '''
         Player( 
          id: $id, 
          username: $username,  
          cards: $cards, 
          index: $index, 
          isTurn: $isTurn, 
          isShot: $isShot, 
          joined: $joined, 
          cardsToTake: $cardsToTake 
        )
        ''';
  }

  @override
  bool operator ==(covariant Player other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        listEquals(other.cards, cards) &&
        other.index == index &&
        other.isTurn == isTurn &&
        other.isShot == isShot &&
        other.joined == joined &&
        other.cardsToTake == cardsToTake;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        cards.hashCode ^
        index.hashCode ^
        isTurn.hashCode ^
        isShot.hashCode ^
        joined.hashCode ^
        cardsToTake.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'cards': cards.map((x) => x.toMap()).toList(),
      'index': index,
      'isTurn': isTurn,
      'isShot': isShot,
      'joined': joined,
      'cardsToTake': cardsToTake,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id'] as String,
      username: map['username'] as String,
      cards: List<PlayCard>.from(
        (map['cards'] as List<dynamic>).map<PlayCard>(
          (x) => PlayCard.fromMap(x as Map<String, dynamic>),
        ),
      ),
      index: map['index'] as int,
      isTurn: map['isTurn'] as bool,
      isShot: map['isShot'] as bool,
      joined: map['joined'] as bool,
      cardsToTake: map['cardsToTake'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) =>
      Player.fromMap(json.decode(source) as Map<String, dynamic>);
}
