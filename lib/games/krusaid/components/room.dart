// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'play_card.dart';
import 'player.dart';

class Room {
  final String id;
  final List<Player> players;
  final List<PlayCard> playedCards;
  final List<PlayCard> deck;
  final PlayCard? allowedCard;
  final int turnIndex;
  final int numOfPlayers;
  final bool created;
  final bool direction;
  final bool served;
  final bool gameOver;

  Room({
    required this.id,
    required this.players,
    required this.playedCards,
    required this.deck,
    this.allowedCard,
    required this.turnIndex,
    this.numOfPlayers = 3,
    this.created = false,
    this.direction = true,
    this.served = false,
    this.gameOver = false,
  });

  Room copyWith({
    String? id,
    List<Player>? players,
    List<PlayCard>? playedCards,
    List<PlayCard>? deck,
    PlayCard? allowedCard,
    int? turnIndex,
    int? numOfPlayers,
    bool? created,
    bool? direction,
    bool? served,
    bool? gameOver,
  }) {
    return Room(
      id: id ?? this.id,
      players: players ?? this.players,
      playedCards: playedCards ?? this.playedCards,
      deck: deck ?? this.deck,
      allowedCard: allowedCard ?? this.allowedCard,
      turnIndex: turnIndex ?? this.turnIndex,
      numOfPlayers: numOfPlayers ?? this.numOfPlayers,
      created: created ?? this.created,
      direction: direction ?? this.direction,
      served: served ?? this.served,
      gameOver: gameOver ?? this.gameOver,
    );
  }

  @override
  bool operator ==(covariant Room other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.players, players) &&
        listEquals(other.playedCards, playedCards) &&
        listEquals(other.deck, deck) &&
        other.allowedCard == allowedCard &&
        other.turnIndex == turnIndex &&
        other.numOfPlayers == numOfPlayers &&
        other.created == created &&
        other.direction == direction &&
        other.served == served &&
        other.gameOver == gameOver;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        players.hashCode ^
        playedCards.hashCode ^
        deck.hashCode ^
        allowedCard.hashCode ^
        turnIndex.hashCode ^
        numOfPlayers.hashCode ^
        created.hashCode ^
        direction.hashCode ^
        served.hashCode ^
        gameOver.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) =>
      Room.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Room(id: $id, players: $players, playedCards: $playedCards, deck: $deck, allowedCard: $allowedCard, turnIndex: $turnIndex, numOfPlayers: $numOfPlayers, created: $created, direction: $direction, served: $served, gameOver: $gameOver)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'players': players.map((x) => x.toMap()).toList(),
      'playedCards': playedCards.map((x) => x.toMap()).toList(),
      'deck': deck.map((x) => x.toMap()).toList(),
      'allowedCard': allowedCard?.toMap(),
      'turnIndex': turnIndex,
      'numOfPlayers': numOfPlayers,
      'created': created,
      'direction': direction,
      'served': served,
      'gameOver': gameOver,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['id'] as String,
      players: List<Player>.from(
        (map['players'] as List<dynamic>).map<Player>(
          (x) => Player.fromMap(x as Map<String, dynamic>),
        ),
      ),
      playedCards: List<PlayCard>.from(
        (map['playedCards'] as List<dynamic>).map<PlayCard>(
          (x) => PlayCard.fromMap(x as Map<String, dynamic>),
        ),
      ),
      deck: List<PlayCard>.from(
        (map['deck'] as List<dynamic>).map<PlayCard>(
          (x) => PlayCard.fromMap(x as Map<String, dynamic>),
        ),
      ),
      allowedCard: map['allowedCard'] != null
          ? PlayCard.fromMap(map['allowedCard'] as Map<String, dynamic>)
          : null,
      turnIndex: map['turnIndex'] as int,
      numOfPlayers: map['numOfPlayers'] as int,
      created: map['created'] as bool,
      direction: map['direction'] as bool,
      served: map['served'] as bool,
      gameOver: map['gameOver'] as bool,
    );
  }
}
