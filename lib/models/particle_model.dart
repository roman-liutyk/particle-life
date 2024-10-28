import 'package:particle_life/models/coordinates_model.dart';

class Particle {
  final Coordinates<double> position;
  final Coordinates<double> velocity;
  final int color;

  const Particle({
    required this.position,
    required this.velocity,
    required this.color,
  });

  Particle copyWith({
    Coordinates<double>? position,
    Coordinates<double>? velocity,
    int? color,
  }) {
    return Particle(
      position: position ?? this.position,
      velocity: velocity ?? this.velocity,
      color: color ?? this.color,
    );
  }
}
