// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ErrorOccured {
  final String type;
  final String message;
  ErrorOccured({
    required this.type,
    required this.message,
  });

  ErrorOccured copyWith({
    String? type,
    String? message,
  }) {
    return ErrorOccured(
      type: type ?? this.type,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'message': message,
    };
  }

  factory ErrorOccured.fromMap(Map<String, dynamic> map) {
    return ErrorOccured(
      type: map['type'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorOccured.fromJson(String source) =>
      ErrorOccured.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ErrorOccured(type: $type, message: $message)';

  @override
  bool operator ==(covariant ErrorOccured other) {
    if (identical(this, other)) return true;

    return other.type == type && other.message == message;
  }

  @override
  int get hashCode => type.hashCode ^ message.hashCode;
}
