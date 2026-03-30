import 'dart:math';
import 'package:flutter/material.dart';

import 'confetti_painter.dart';

/// Controller for managing the confetti celebration animation lifecycle.
class CelebrationController extends ChangeNotifier {
  /// Constructor for the celebration controller.
  CelebrationController(this.vsync) {
    _animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 3),
    );

    _animationController.addListener(() {
      _updateParticles();
      notifyListeners();
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation finished
        _isPlaying = false;
        notifyListeners();
      }
    });
  }

  /// The vsync provider for the animation.
  final TickerProvider vsync;

  late final AnimationController _animationController;

  final List<ConfettiParticle> _particles = [];

  final Random _random = Random();

  bool _isPlaying = false;

  /// Returns the current list of particles.
  List<ConfettiParticle> get particles => _particles;

  /// Returns whether the animation is currently playing.
  bool get isPlaying => _isPlaying;

  /// Starts the celebration animation.
  void play({int count = 100}) {
    _particles.clear();
    for (var i = 0; i < count; i++) {
      _particles.add(_createParticle());
    }
    _isPlaying = true;
    _animationController.forward(from: 0);
  }

  /// Stops the celebration animation.
  void stop() {
    _isPlaying = false;
    _animationController.stop();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  ConfettiParticle _createParticle() {
    // Determine random start position within reasonable bounds, e.g., slightly above center
    final startX = _random.nextDouble() * 500 - 250; // -250 to 250
    final startY = -_random.nextDouble() * 300 - 100; // -100 to -400

    // Random velocity
    final vX = _random.nextDouble() * 10 - 5; // -5 to 5
    final vY =
        _random.nextDouble() * 5 - 10; // -5 to -10 (upwards burst initially)

    // Random color (Islamic green accent + secondary + gold/yellow for celebration)
    final colors = [
      const Color(0xFF2E7D32), // Islamic green
      const Color(0xFF66BB6A), // Light green
      const Color(0xFF1565C0), // Secondary
      const Color(0xFFFFD700), // Gold
      const Color(0xFFFFA000), // Amber
    ];
    final color = colors[_random.nextInt(colors.length)];

    // Random size
    final width = _random.nextDouble() * 10 + 5; // 5 to 15
    final height = _random.nextDouble() * 10 + 5; // 5 to 15

    return ConfettiParticle(
      position: Offset(startX, startY),
      color: color,
      velocity: Offset(vX, vY),
      size: Size(width, height),
      rotation: _random.nextDouble() * 2 * pi,
      rotationSpeed: _random.nextDouble() * 0.2 - 0.1, // -0.1 to 0.1
      shape: _random.nextInt(2), // 0 or 1
    );
  }

  void _updateParticles() {
    final gravity = 0.5; // Gravity pull down
    for (final particle in _particles) {
      particle.update(gravity);
    }
  }
}
