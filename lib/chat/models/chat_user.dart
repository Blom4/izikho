// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/widgets.dart';

enum Role { admin, agent, moderator, user }

@immutable
class ChatUser {
  final String username;
  final String id;
  final String email;
  final DateTime createdAt;
  final DateTime lastSeen;
  final String imageUrl;
  final Role role;
  const ChatUser({
    required this.username,
    required this.id,
    required this.email,
    required this.imageUrl,
    required this.createdAt,
    required this.lastSeen,
    this.role = Role.user,
  });

  ChatUser copyWith({
    String? username,
    String? id,
    String? email,
    DateTime? createdAt,
    DateTime? lastSeen,
    String? imageUrl,
    Role? role,
  }) {
    return ChatUser(
      username: username ?? this.username,
      id: id ?? this.id,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      lastSeen: lastSeen ?? this.lastSeen,
      imageUrl: imageUrl ?? this.imageUrl,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'id': id,
      'email': email,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastSeen': lastSeen.millisecondsSinceEpoch,
      'imageUrl': imageUrl,
      'role': role.name
    };
  }

  factory ChatUser.fromMap(Map<String, dynamic> map) {
    return ChatUser(
      username: map['username'] as String,
      id: map['id'] as String,
      email: map['email'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      lastSeen: DateTime.fromMillisecondsSinceEpoch(map['lastSeen'] as int),
      imageUrl: map['imageUrl'] as String,
      role: Role.values.firstWhere((element) => element.name == map['role']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatUser.fromJson(String source) =>
      ChatUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatUser(username: $username, id: $id, email: $email, createdAt: $createdAt, lastSeen: $lastSeen, imageUrl: $imageUrl, role: $role)';
  }

  @override
  bool operator ==(covariant ChatUser other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.id == id &&
        other.email == email &&
        other.createdAt == createdAt &&
        other.lastSeen == lastSeen &&
        other.imageUrl == imageUrl &&
        other.role == role;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        id.hashCode ^
        email.hashCode ^
        createdAt.hashCode ^
        lastSeen.hashCode ^
        imageUrl.hashCode ^
        role.hashCode;
  }
}
