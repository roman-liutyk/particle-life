import 'package:flutter/widgets.dart';
import 'package:particle_life/notifiers/particle_simulation_notifier.dart';

class ParticleSimulationProvider extends InheritedWidget {
  const ParticleSimulationProvider({
    super.key,
    required this.notifier,
    required super.child,
  });

  final ParticleSimulationNotifier notifier;

  static ParticleSimulationProvider? of(BuildContext context) {
    final ParticleSimulationProvider? provider = context
        .dependOnInheritedWidgetOfExactType<ParticleSimulationProvider>();

    assert(provider != null, 'No ParticleSimulationProvider found in context');

    return provider;
  }

  @override
  bool updateShouldNotify(ParticleSimulationProvider oldWidget) {
    return oldWidget.notifier != notifier;
  }
}
