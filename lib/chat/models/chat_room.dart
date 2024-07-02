// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'chat_message.dart';
import 'chat_user.dart';

enum RoomType { channel, direct, group }

class ChatRoom {
  final String id;
  final String imageUrl;
  final RoomType type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ChatMessage> lastMessages;
  final List<ChatUser> users;
  ChatRoom({
    required this.id,
    required this.imageUrl,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.lastMessages,
    required this.users,
  });

  ChatRoom copyWith({
    String? id,
    String? imageUrl,
    RoomType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<ChatMessage>? lastMessages,
    List<ChatUser>? users,
  }) {
    return ChatRoom(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastMessages: lastMessages ?? this.lastMessages,
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
      'type': type.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'lastMessages': lastMessages.map((x) => x.toMap()).toList(),
      'users': users.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
      type:
          RoomType.values.firstWhere((element) => element.name == map['type']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      lastMessages: List<ChatMessage>.from(
        (map['lastMessages'] as List<int>).map<ChatMessage>(
          (x) => ChatMessage.fromMap(x as Map<String, dynamic>),
        ),
      ),
      users: List<ChatUser>.from(
        (map['users'] as List<int>).map<ChatUser>(
          (x) => ChatUser.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoom.fromJson(String source) =>
      ChatRoom.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatRoom(id: $id, imageUrl: $imageUrl, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, lastMessages: $lastMessages, users: $users)';
  }

  @override
  bool operator ==(covariant ChatRoom other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.imageUrl == imageUrl &&
        other.type == type &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        listEquals(other.lastMessages, lastMessages) &&
        listEquals(other.users, users);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imageUrl.hashCode ^
        type.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        lastMessages.hashCode ^
        users.hashCode;
  }
}
