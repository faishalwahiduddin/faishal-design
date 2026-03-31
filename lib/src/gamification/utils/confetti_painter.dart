import 'package:flutter/material.dart';

/// A particle in the confetti animation.
class ConfettiParticle {
  /// Constructor for a confetti particle.
  ConfettiParticle({
    required this.position,
    required this.color,
    required this.velocity,
    required this.size,
    required this.rotation,
    required this.rotationSpeed,
    required this.shape,
  });

  /// The current position of the particle.
  Offset position;

  /// The color of the particle.
  final Color color;

  /// The velocity of the particle.
  Offset velocity;

  /// The size of the particle.
  final Size size;

  /// The current rotation of the particle.
  double rotation;

  /// The speed at which the particle rotates.
  final double rotationSpeed;

  /// The shape of the particle (0 for rectangle, 1 for circle).
  final int shape;

  /// Updates the particle's position and rotation based on gravity and velocity.
  void update(double gravity) {
    velocity = Offset(velocity.dx, velocity.dy + gravity);
    position += velocity;
    rotation += rotationSpeed;
  }
}

/// Custom painter for rendering confetti particles.
class ConfettiPainter extends CustomPainter {
  /// Constructor for the confetti painter.
  ConfettiPainter({required this.particles});

  /// The list of particles to render.
  final List<ConfettiParticle> particles;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final particle in particles) {
      paint.color = particle.color;
      canvas.save();
      canvas.translate(particle.position.dx, particle.position.dy);
      canvas.rotate(particle.rotation);

      if (particle.shape == 0) {
        // Rectangle
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset.zero,
            width: particle.size.width,
            height: particle.size.height,
          ),
          paint,
        );
      } else {
        // Circle
        canvas.drawCircle(Offset.zero, particle.size.width / 2, paint);
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter oldDelegate) {
    return true; // Always repaint as particles are animating
  }
}
