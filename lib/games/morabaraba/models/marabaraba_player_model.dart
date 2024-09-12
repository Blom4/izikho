import 'package:flutter/foundation.dart';

import '../../../auth/model/profile_model.dart';
import '../../common/models/player_model.dart';
import 'morabaraba_cell_models.dart';

class MorabarabaPlayerModel extends PlayerModel {
  MorabarabaPlayerModel({
    required super.id,
    required super.username,
    this.capturedCows = const [],
    required this.cowType,
    this.cowsInHand = 12,
    super.isOwner,
    super.isTurn,
    super.joined,
  });
  static const playerType = GamePlayerType.morabaraba;
  final List<MorabarabaCowCell> capturedCows;
  final MorabarabaCowType cowType;
  final int cowsInHand;

  @override
  MorabarabaPlayerModel copyWith({
    String? id,
    List<MorabarabaCowCell>? capturedCows,
    MorabarabaCowType? cowType,
    int? cowsInHand,
    String? username,
    bool? joined,
    bool? isTurn,
    bool? isOwner,
  }) {
    return MorabarabaPlayerModel(
      id: id ?? this.id,
      capturedCows: capturedCows ?? this.capturedCows,
      cowType: cowType ?? this.cowType,
      cowsInHand: cowsInHand ?? this.cowsInHand,
      username: username ?? this.username,
      joined: joined ?? this.joined,
      isTurn: isTurn ?? this.isTurn,
      isOwner: isOwner ?? this.isOwner,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'joined': joined,
      'isTurn': isTurn,
      'isOwner': isOwner,
      'capturedCows': capturedCows.map((x) => x.toMap()).toList(),
      'cowType': cowType.name,
      'cowsInHand': cowsInHand,
    };
  }

  factory MorabarabaPlayerModel.fromMap(Map<String, dynamic> map) {
    return MorabarabaPlayerModel(
      capturedCows: List<MorabarabaCowCell>.from(
        (map['capturedCows'] as List<dynamic>).map<MorabarabaCowCell>(
          (x) => MorabarabaCowCell.fromMap(x as Map<String, dynamic>),
        ),
      ),
      cowType: MorabarabaCowType.values.firstWhere(
        (e) => e.name == map['cowType'],
      ),
      cowsInHand: map['cowsInHand'] as int,
      id: map['id'] as String,
      username: map['username'] as String,
      isOwner: map['isOwner'] as bool,
      isTurn: map['isTurn'] as bool,
      joined: map['joined'] as bool,
    );
  }

  factory MorabarabaPlayerModel.fromProfile(ProfileModel profile) {
    return MorabarabaPlayerModel(
      id: profile.id,
      username: profile.username,
      cowType: MorabarabaCowType.none,
    );
  }

  @override
  String toString() => '''
  MorabarabaPlayerModel(
   capturedCows: $capturedCows, 
   cowType: $cowType, 
   cowsInHand: $cowsInHand
  )
  ''';

  @override
  bool operator ==(covariant MorabarabaPlayerModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.capturedCows, capturedCows) &&
        other.cowType == cowType &&
        other.cowsInHand == cowsInHand &&
        other.id == id &&
        other.username == username &&
        other.joined == joined &&
        other.isTurn == isTurn &&
        other.isOwner == isOwner;
  }

  @override
  int get hashCode =>
      capturedCows.hashCode ^
      cowType.hashCode ^
      cowsInHand.hashCode ^
      id.hashCode ^
      username.hashCode ^
      joined.hashCode ^
      isTurn.hashCode ^
      isOwner.hashCode;
}
