import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:particle_life/models/particle_model.dart';
import 'package:particle_life/models/particle_simulation_model.dart';
import 'package:particle_life/notifiers/particle_simulation_notifier.dart';
import 'package:particle_life/providers/particle_simulation_provider.dart';

void main() {
  runApp(
    ParticleSimulationProvider(
      notifier: ParticleSimulationNotifier(
        params: ParticleSimulationParams(
          numberOfParticles: 2000,
          beta: 0.3,
          deltaTime: 0.02,
          frictionHalfTime: 0.040,
          maxRadius: 0.1,
          forceFactor: 10,
          frictionFactor: pow(0.5, 0.02 / 0.040).toDouble(),
        ),
      )..init(),
      child: Builder(
        builder: (context) {
          return const Application();
        },
      ),
    ),
  );
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application>
    with TickerProviderStateMixin {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(milliseconds: 1000 % 60),
      (timer) {
        setState(
            ParticleSimulationProvider.of(context)!.notifier.updatePositions);
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Particle>>(
      valueListenable: ParticleSimulationProvider.of(context)!.notifier,
      builder: (
        BuildContext context,
        List<Particle> value,
        Widget? child,
      ) {
        return CustomPaint(
          painter: CustomCanvas(
            particles: value,
          ),
        );
      },
    );
  }
}

class CustomCanvas extends CustomPainter {
  final List<Particle> particles;

  const CustomCanvas({
    required this.particles,
    super.repaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < particles.length; i++) {
      canvas.drawCircle(
        Offset(
          particles[i].position.x * size.width,
          particles[i].position.y * size.height,
        ),
        1,
        Paint()
          ..color = HSLColor.fromAHSL(1, 360 * (particles[i].color / 6), 1, 0.5)
              .toColor(),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
