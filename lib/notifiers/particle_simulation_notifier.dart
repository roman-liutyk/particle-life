import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:particle_life/models/coordinates_model.dart';
import 'package:particle_life/models/particle_model.dart';
import 'package:particle_life/models/particle_simulation_model.dart';

class ParticleSimulationNotifier extends ValueNotifier<List<Particle>> {
  ParticleSimulationNotifier({
    required this.params,
  }) : super([]);
  final ParticleSimulationParams params;
  final Random _random = Random();
  final List<List<double>> _attraction = [];

  void init() {
    _attraction.addAll(
      List.generate(
        6,
        (index) {
          return List.generate(6, (index) => _random.nextDouble() * 2 - 1);
        },
      ),
    );

    value = List.generate(
      params.numberOfParticles,
      (index) => Particle(
        position: Coordinates<double>(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
        ),
        velocity: Coordinates<double>(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
        ),
        color: _random.nextInt(6),
      ),
    );
  }

  double force(double r, double a) {
    if (r < params.beta) {
      return r / params.beta - 1;
    } else if (params.beta < r && r < 1) {
      return a * (1 - (2 * r - 1 - params.beta).abs() / (1 - params.beta));
    } else {
      return 0;
    }
  }

  void updatePositions() {
    for (int i = 0; i < params.numberOfParticles; i++) {
      double totalForceX = 0;
      double totalForceY = 0;

      for (int j = 0; j < params.numberOfParticles; j++) {
        if (j == i) {
          continue;
        }

        final double rx = value[j].position.x - value[i].position.x;
        final double ry = value[j].position.y - value[i].position.y;

        final r = sqrt(pow(rx, 2) + pow(ry, 2));

        if (r > 0 && r < params.maxRadius) {
          final double f = force(
            r / params.maxRadius,
            _attraction[value[i].color][value[j].color],
          );

          totalForceX += rx / r * f;
          totalForceY += ry / r * f;
        }
      }

      totalForceX *= params.maxRadius * params.forceFactor;
      totalForceY *= params.maxRadius * params.forceFactor;

      final Coordinates<double> velocity = value[i].velocity.copyWith(
            x: value[i].velocity.x * params.frictionFactor +
                params.deltaTime * totalForceX,
            y: value[i].velocity.y * params.frictionFactor +
                params.deltaTime * totalForceY,
          );

      value[i] = value[i].copyWith(velocity: velocity);
    }

    for (int i = 0; i < params.numberOfParticles; i++) {
      value[i] = value[i].copyWith(
        position: value[i].position.copyWith(
              x: value[i].position.x + value[i].velocity.x * params.deltaTime,
              y: value[i].position.y + value[i].velocity.y * params.deltaTime,
            ),
      );
    }
  }
}
