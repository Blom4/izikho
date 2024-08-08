// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ProfileModel {
  final String id;
  final String username;
  final String email;
  final String? avatarURL;
  final types.User? user;

  ProfileModel({
    required this.id,
    required this.email,
    required this.username,
    this.avatarURL,
    this.user,
  });

  factory ProfileModel.fromUser(types.User user) {
    return ProfileModel(
      id: user.id,
      email: user.metadata!['email']!,
      username: user.metadata!['username']!,
      avatarURL: user.imageUrl,
      user: user,
    );
  }

  types.User toUser() =>
      user ??
      types.User(
        id: id,
        imageUrl: avatarURL,
        metadata: {
          'email': email,
          'username': username,
        },
      );

  @override
  String toString() {
    return 'ProfileModel(id: $id, username: $username, email: $email, avatarURL: $avatarURL)';
  }

  @override
  bool operator ==(covariant ProfileModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.email == email &&
        other.avatarURL == avatarURL;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        avatarURL.hashCode;
  }

  ProfileModel copyWith(
      {String? id,
      String? username,
      String? email,
      String? avatarURL,
      types.User? user}) {
    return ProfileModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatarURL: avatarURL ?? this.avatarURL,
      user: user ?? this.user,
    );
  }
}
