class ParticleSimulationParams {
  final int numberOfParticles;
  final double beta;
  final double deltaTime;
  final double frictionHalfTime;
  final double maxRadius;
  final double forceFactor;
  final double frictionFactor;

  const ParticleSimulationParams({
    required this.numberOfParticles,
    required this.beta,
    required this.deltaTime,
    required this.frictionHalfTime,
    required this.maxRadius,
    required this.forceFactor,
    required this.frictionFactor,
  });
}
