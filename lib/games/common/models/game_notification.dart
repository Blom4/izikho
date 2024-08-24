class GameNotificationModel {
  final int? id;
  final String gameId;
  final bool viewed;
  final String senderName;
  final String message;

  GameNotificationModel({
    this.id,
    required this.gameId,
    required this.senderName,
    required this.message,
    this.viewed = false,
  });

  GameNotificationModel copyWith({
    int? id,
    String? gameId,
    bool? viewed,
    String? senderName,
    String? message,
  }) {
    return GameNotificationModel(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      viewed: viewed ?? this.viewed,
      senderName: senderName ?? this.senderName,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'game_id': gameId,
      'viewed': viewed,
      'sender_name': senderName,
      'message': message,
    };
  }

  factory GameNotificationModel.fromMap(Map<String, dynamic> map) {
    return GameNotificationModel(
      id: map['id'] != null ? map['id'] as int : null,
      gameId: map['game_id'] as String,
      viewed: map['viewed'] as bool,
      senderName: map['sender_name'] as String,
      message: map['message'] as String,
    );
  }

  @override
  String toString() {
    return 'GameNotificationModel(senderName: $senderName, message: $message,)';
  }

  @override
  bool operator ==(covariant GameNotificationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.gameId == gameId &&
        other.viewed == viewed &&
        other.senderName == senderName &&
        other.message == message;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        gameId.hashCode ^
        viewed.hashCode ^
        senderName.hashCode ^
        message.hashCode;
  }
}
