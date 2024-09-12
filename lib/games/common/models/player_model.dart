import '../../../auth/model/profile_model.dart';
import '../../krusaid/models/krusaid_player_model.dart';
import '../../morabaraba/models/marabaraba_player_model.dart';

enum GamePlayerType {
  none,
  ak47,
  casino,
  chess,
  fivecards,
  krusaid,
  ludo,
  morabaraba;
}

abstract class PlayerModel {
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
    final playertype = GamePlayerType.values.firstWhere(
      (e) => map['playerType'] == e.name,
    );
    switch (playertype) {
      case KrusaidPlayerModel.playerType:
        return KrusaidPlayerModel.fromMap(map);
      default:
        throw UnimplementedError();
    }
  }

  factory PlayerModel.fromProfile(
    ProfileModel profile, {
    GamePlayerType playerType = GamePlayerType.none,
  }) {
    switch (playerType) {
      case GamePlayerType.krusaid:
        return KrusaidPlayerModel.fromProfile(profile);
      case GamePlayerType.morabaraba:
        return MorabarabaPlayerModel.fromProfile(profile);
      default:
        throw UnimplementedError();
    }
  }

  Map<String, dynamic> toMap();

  @override
  String toString() {
    return '''
    PlayerModel(
     id: $id, 
     username: $username, 
     joined: $joined, 
     isTurn: $isTurn
    )
    ''';
  }

  PlayerModel copyWith({
    String? id,
    String? username,
    bool? joined,
    bool? isTurn,
    bool? isOwner,
  });

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
