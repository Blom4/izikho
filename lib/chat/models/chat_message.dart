// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'chat_user.dart';

enum MessageType { audio, file, image, text, video }

enum Status { delivered, error, seen, sending, sent }

@immutable
class ChatMessage {
  final ChatUser author;
  final DateTime createdAt;
  final String id;
  final ChatMessage? repliedMessage;
  final String roomId;
  final bool showStatus;
  final Status status;
  final MessageType type;
  final DateTime updatedAt;
  final String text;
  const ChatMessage({
    required this.author,
    required this.createdAt,
    required this.id,
    this.repliedMessage,
    required this.roomId,
    this.showStatus = false,
    this.status = Status.sending,
    this.type = MessageType.text,
    required this.updatedAt,
    required this.text,
  });

  ChatMessage copyWith({
    ChatUser? author,
    DateTime? createdAt,
    String? id,
    ChatMessage? repliedMessage,
    String? roomId,
    bool? showStatus,
    Status? status,
    MessageType? type,
    DateTime? updatedAt,
    String? text,
  }) {
    return ChatMessage(
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      repliedMessage: repliedMessage ?? this.repliedMessage,
      roomId: roomId ?? this.roomId,
      showStatus: showStatus ?? this.showStatus,
      status: status ?? this.status,
      type: type ?? this.type,
      updatedAt: updatedAt ?? this.updatedAt,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'author': author.toMap(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'id': id,
      'repliedMessage': repliedMessage?.toMap(),
      'roomId': roomId,
      'showStatus': showStatus,
      'status': status.name,
      'type': type.name,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'text': text,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      author: ChatUser.fromMap(map['author'] as Map<String, dynamic>),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      id: map['id'] as String,
      repliedMessage: map['repliedMessage'] != null
          ? ChatMessage.fromMap(map['repliedMessage'] as Map<String, dynamic>)
          : null,
      roomId: map['roomId'] as String,
      showStatus: map['showStatus'] as bool,
      status:
          Status.values.firstWhere((element) => element.name == map['status']),
      type: MessageType.values
          .firstWhere((element) => element.name == map['type']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatMessage(author: $author, createdAt: $createdAt, id: $id, repliedMessage: $repliedMessage, roomId: $roomId, showStatus: $showStatus, status: $status, type: $type, updatedAt: $updatedAt, text: $text)';
  }

  @override
  bool operator ==(covariant ChatMessage other) {
    if (identical(this, other)) return true;

    return other.author == author &&
        other.createdAt == createdAt &&
        other.id == id &&
        other.repliedMessage == repliedMessage &&
        other.roomId == roomId &&
        other.showStatus == showStatus &&
        other.status == status &&
        other.type == type &&
        other.updatedAt == updatedAt &&
        other.text == text;
  }

  @override
  int get hashCode {
    return author.hashCode ^
        createdAt.hashCode ^
        id.hashCode ^
        repliedMessage.hashCode ^
        roomId.hashCode ^
        showStatus.hashCode ^
        status.hashCode ^
        type.hashCode ^
        updatedAt.hashCode ^
        text.hashCode;
  }
}

abstract class AudioChatMessage extends ChatMessage {
  final Duration duration;
  final String? mimeType;
  final String name;
  final num size;
  final String audioUri;
  final List<double> waveForm;

  const AudioChatMessage({
    required this.duration,
    this.mimeType,
    required this.name,
    required this.size,
    required this.audioUri,
    required this.waveForm,
    required super.author,
    required super.createdAt,
    required super.id,
    required super.roomId,
    required super.updatedAt,
    required super.text,
  });
}

// abstract class ImageChatMessage extends ChatMessage {
//   const ImageChatMessage({
//     required super.author,
//     required super.createdAt,
//     required super.id,
//     required super.roomId,
//     required super.status,
//     required super.updatedAt,
//     required super.text,
//     super.type = MessageType.image,
//   });
// }

// abstract class FileChatMessage extends ChatMessage {
//   const FileChatMessage({
//     required super.author,
//     required super.createdAt,
//     required super.id,
//     required super.roomId,
//     required super.status,
//     required super.updatedAt,
//     required super.text,
//     super.type = MessageType.file,
//   });
// }

// abstract class VideoChatMessage extends ChatMessage {
//   const VideoChatMessage( {
//     required super.author,
//     required super.createdAt,
//     required super.id,
//     required super.roomId,
//     required super.status,
//     required super.updatedAt,
//     required super.text,
//     super.type = MessageType.video,
//   });

//   final String videoUrl;
// }
