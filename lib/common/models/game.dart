// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GameModel {
  final String name;
  final String? description;
  final int rating;
  final String image;
  final String routeName;
  const GameModel({
    required this.name,
    this.description,
    this.rating = 0,
    required this.image,
    required this.routeName,
  });

  GameModel copyWith({
    String? name,
    String? description,
    int? rating,
    String? image,
    String? routeName,
  }) {
    return GameModel(
      name: name ?? this.name,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      image: image ?? this.image,
      routeName: routeName ?? this.routeName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'rating': rating,
      'image': image,
      'routeName': routeName,
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      rating: map['rating'] as int,
      image: map['image'] as String,
      routeName: map['routeName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GameModel.fromJson(String source) =>
      GameModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GameModel(name: $name, description: $description, rating: $rating, image: $image, routeName: $routeName)';
  }

  @override
  bool operator ==(covariant GameModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.rating == rating &&
        other.image == image &&
        other.routeName == routeName;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        rating.hashCode ^
        image.hashCode ^
        routeName.hashCode;
  }
}
