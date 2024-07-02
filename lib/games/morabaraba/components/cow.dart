// ignore_for_file: public_member_api_docs, sort_constructors_first
class Cow {
  late final bool isWhite;
  bool isCapture;
  Cow({required this.isWhite, this.isCapture = false});

  @override
  bool operator ==(covariant Cow other) {
    if (identical(this, other)) return true;

    return other.isWhite == isWhite;
  }

  @override
  int get hashCode => isWhite.hashCode;

  @override
  String toString() => 'Cow(isWhite: $isWhite)';
}
