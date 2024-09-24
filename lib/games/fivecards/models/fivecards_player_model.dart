import 'package:flutter/foundation.dart';

import '../../../auth/model/profile_model.dart';
import '../../common/models/player_model.dart';
import '../../common/models/game_playing_card.dart';

class FivecardsPlayerModel extends PlayerModel {
  static const playerType = GamePlayerType.krusaid;
  final List<GamePlayingCard> cards;
  final int index;
  final bool isShot;
  final int cardsToTake;

  FivecardsPlayerModel({
    required super.id,
    required super.username,
    super.isTurn,
    super.joined,
    super.isOwner,
    required this.index,
    this.cards = const [],
    this.isShot = false,
    this.cardsToTake = 0,
  });

  @override
  FivecardsPlayerModel copyWith({
    String? id,
    String? username,
    List<GamePlayingCard>? cards,
    int? index,
    bool? isTurn,
    bool? isShot,
    bool? joined,
    bool? isOwner,
    int? cardsToTake,
  }) {
    return FivecardsPlayerModel(
      id: id ?? this.id,
      username: username ?? this.username,
      cards: cards ?? this.cards,
      index: index ?? this.index,
      isTurn: isTurn ?? this.isTurn,
      isShot: isShot ?? this.isShot,
      joined: joined ?? this.joined,
      isOwner: isOwner ?? this.isOwner,
      cardsToTake: cardsToTake ?? this.cardsToTake,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'playerType': playerType.name,
      'username': username,
      'cards': cards.map((x) => x.toMap()).toList(),
      'index': index,
      'isTurn': isTurn,
      'isShot': isShot,
      'joined': joined,
      'isOwner': isOwner,
      'cardsToTake': cardsToTake,
    };
  }

  factory FivecardsPlayerModel.fromProfile(ProfileModel profile) {
    return FivecardsPlayerModel(
      id: profile.id,
      username: profile.username,
      index: -1,
    );
  }

  factory FivecardsPlayerModel.fromMap(Map<String, dynamic> map) {
    return FivecardsPlayerModel(
      id: map['id'] as String,
      username: map['username'] as String,
      cards: List<GamePlayingCard>.from(
        (map['cards'] as List<dynamic>).map<GamePlayingCard>(
          (x) => GamePlayingCard.fromMap(x as Map<String, dynamic>),
        ),
      ),
      index: map['index'] as int,
      isTurn: map['isTurn'] as bool,
      isShot: map['isShot'] as bool,
      joined: map['joined'] as bool,
      isOwner: map['isOwner'] as bool,
      cardsToTake: map['cardsToTake'] as int,
    );
  }

  @override
  String toString() {
    return 'FivecardsPlayerModel(cards: $cards, index: $index, isShot: $isShot, cardsToTake: $cardsToTake)';
  }

  @override
  bool operator ==(covariant FivecardsPlayerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.isTurn == isTurn &&
        other.joined == joined &&
        other.isOwner == isOwner &&
        other.username == username &&
        listEquals(other.cards, cards) &&
        other.index == index &&
        other.isShot == isShot &&
        other.cardsToTake == cardsToTake;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        isTurn.hashCode ^
        joined.hashCode ^
        isOwner.hashCode ^
        cards.hashCode ^
        index.hashCode ^
        isShot.hashCode ^
        cardsToTake.hashCode;
  }
}
