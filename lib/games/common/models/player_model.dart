import '../../../auth/model/profile_model.dart';
import '../../krusaid/models/krusaid_player_model.dart';

enum PlayerType {
  ak47,
  casino,
  chess,
  fivecards,
  krusaid,
  ludo,
  morabaraba;
}

class PlayerModel {
  final String id;
  final String username;
  final bool joined;
  final bool isTurn;
  final bool isOwner;

  PlayerModel({
    required this.id,
    required this.username,
    this.joined = false,
    this.isTurn = false,
    this.isOwner = false,
  });

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    final playertype = PlayerType.values.firstWhere(
      (e) => map['playerType'] == e.name,
    );
    switch (playertype) {
      case KrusaidPlayerModel.playerType:
        return KrusaidPlayerModel.fromMap(map);
      default:
        throw UnimplementedError();
    }
  }

  factory PlayerModel.fromProfile(ProfileModel profile) {
    return PlayerModel(id: profile.id, username: profile.username);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'joined': joined,
      'isTurn': isTurn,
      'isOwner': isOwner,
    };
  }

  @override
  String toString() {
    return 'PlayerModel(id: $id, username: $username, joined: $joined, isTurn: $isTurn)';
  }

  PlayerModel copyWith({
    String? id,
    String? username,
    bool? joined,
    bool? isTurn,
    bool? isOwner,
  }) {
    return PlayerModel(
      id: id ?? this.id,
      username: username ?? this.username,
      joined: joined ?? this.joined,
      isTurn: isTurn ?? this.isTurn,
      isOwner: isOwner ?? this.isOwner,
    );
  }

  @override
  bool operator ==(covariant PlayerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.joined == joined &&
        other.isTurn == isTurn &&
        other.isOwner == isOwner;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        joined.hashCode ^
        isTurn.hashCode ^
        isOwner.hashCode;
  }
}
