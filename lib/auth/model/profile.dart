// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProfileModel {
  final String id;
  final String username;
  final String fullName;
  final String website;
  final String avatarURL;
  final DateTime updatedAt;

  ProfileModel({
    required this.id,
    required this.username,
    required this.fullName,
    required this.website,
    required this.avatarURL,
    required this.updatedAt,
  });

  ProfileModel copyWith({
    String? id,
    String? username,
    String? fullName,
    String? website,
    String? avatarURL,
    DateTime? updatedAt,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      website: website ?? this.website,
      avatarURL: avatarURL ?? this.avatarURL,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'full_name': fullName,
      'website': website,
      'avatar_url': avatarURL,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as String,
      username: map['username'] as String,
      fullName: map['full_name'] as String,
      website: map['website'] as String,
      avatarURL: map['avatar_url'] as String,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileModel(id: $id, username: $username, fullName: $fullName, website: $website, avatarURL: $avatarURL, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ProfileModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.fullName == fullName &&
        other.website == website &&
        other.avatarURL == avatarURL &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        fullName.hashCode ^
        website.hashCode ^
        avatarURL.hashCode ^
        updatedAt.hashCode;
  }
}
