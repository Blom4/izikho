import 'package:flutter/foundation.dart';

import '../../../auth/model/profile_model.dart';
import '../../common/models/player_model.dart';
import '../../common/models/game_playing_card.dart';

class FivecardsPlayerModel extends PlayerModel {
  static const playerType = GamePlayerType.fivecards;
  final List<GamePlayingCard> cards;
  final int index;

  FivecardsPlayerModel({
    required super.id,
    required super.username,
    super.isTurn,
    super.joined,
    super.isOwner,
    required this.index,
    this.cards = const [],
  });

   FivecardsPlayerModel withSortedCards() {
    
    cards.sort((a, b) => a.value.rank.compareTo(b.value.rank));
    return copyWith(
      cards: cards
    );
  }

  @override
  FivecardsPlayerModel copyWith({
    String? id,
    String? username,
    List<GamePlayingCard>? cards,
    int? index,
    bool? isOwner,
    bool? isTurn,
    bool? joined,
  }) {
    return FivecardsPlayerModel(
      id: id ?? this.id,
      username: username ?? this.username,
      cards: cards ?? this.cards,
      index: index ?? this.index,
      isTurn: isTurn ?? this.isTurn,
      joined: joined ?? this.joined,
      isOwner: isOwner ?? this.isOwner,
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
      'joined': joined,
      'isOwner': isOwner,
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
      joined: map['joined'] as bool,
      isOwner: map['isOwner'] as bool,
    );
  }

  @override
  String toString() {
    return '''
        FivecardsPlayerModel(
          cards: $cards, 
          index: $index
        )
     ''';
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
        other.index == index;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        isTurn.hashCode ^
        joined.hashCode ^
        isOwner.hashCode ^
        cards.hashCode ^
        index.hashCode;
  }
}
