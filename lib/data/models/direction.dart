enum Direction {
  toFirst("to_first"),
  toLast("to_last");

  final String value;

  const Direction(this.value);

  @override
  String toString() => value;
}