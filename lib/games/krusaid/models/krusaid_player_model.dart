import 'package:flutter/foundation.dart';

import '../../../auth/model/profile_model.dart';
import '../../common/models/player_model.dart';
import '../components/play_card.dart';

class KrusaidPlayerModel extends PlayerModel {
  static const playerType = PlayerType.krusaid;
  final List<PlayCard> cards;
  final int index;
  final bool isShot;
  final int cardsToTake;

  KrusaidPlayerModel({
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
  KrusaidPlayerModel copyWith({
    String? id,
    String? username,
    List<PlayCard>? cards,
    int? index,
    bool? isTurn,
    bool? isShot,
    bool? joined,
    bool? isOwner,
    int? cardsToTake,
  }) {
    return KrusaidPlayerModel(
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

  factory KrusaidPlayerModel.fromProfile(ProfileModel profile) {
    return KrusaidPlayerModel(
      id: profile.id,
      username: profile.username,
      index: 0,
    );
  }
  factory KrusaidPlayerModel.fromMap(Map<String, dynamic> map) {
    return KrusaidPlayerModel(
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
      isOwner: map['isOwner'] as bool,
      cardsToTake: map['cardsToTake'] as int,
    );
  }
   
   

  @override
  String toString() {
    return 'KrusaidPlayerModel(cards: $cards, index: $index, isShot: $isShot, cardsToTake: $cardsToTake)';
  }

  @override
  bool operator ==(covariant KrusaidPlayerModel other) {
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
