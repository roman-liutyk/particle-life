class Coordinates<T extends num> {
  final T x;
  final T y;

  const Coordinates({
    required this.x,
    required this.y,
  });

  Coordinates<T> copyWith({
    T? x,
    T? y,
  }) {
    return Coordinates(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }
}
