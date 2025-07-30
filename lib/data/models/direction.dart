class Direction {
  final String value;
  final String displayName;

  const Direction._(this.value, this.displayName);

  static const toFirst = Direction._('to_first', 'На Пр. Космонавтов');
  static const toLast = Direction._('to_last', 'На ботанику');

  static const values = [toFirst, toLast];

  @override
  String toString() => displayName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Direction &&
              runtimeType == other.runtimeType &&
              value == other.value;

  @override
  int get hashCode => value.hashCode;
}