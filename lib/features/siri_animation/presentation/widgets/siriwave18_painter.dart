import 'dart:math';

import 'package:flutter/material.dart';

class SiriWave18Painter extends CustomPainter {
  final double amplitude;

  SiriWave18Painter(this.amplitude);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.blue, Colors.purple, Colors.pink],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);

    final Path path = Path();
    final double midY = size.height / 2;

    for (double x = 0; x <= size.width; x++) {
      double y = midY +
          amplitude * sin((2 * pi * x) / size.width) * cos(x * pi / size.width);
      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ShiriPainter extends CustomPainter {
  final double radius;
  final double opacity;

  ShiriPainter({required this.radius, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return radius != (oldDelegate as ShiriPainter).radius ||
        opacity != (oldDelegate).opacity;
  }
}

/// Painter for the ripple effect.
class RipplePainter extends CustomPainter {
  final Offset origin;
  final double elapsedTime;
  final double duration;

  final double amplitude;
  final double frequency;
  final double decay;
  final double speed;

  RipplePainter({
    required this.origin,
    required this.elapsedTime,
    required this.duration,
    this.amplitude = 12,
    this.frequency = 15,
    this.decay = 8,
    this.speed = 2000,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // RadialGradient(
    //   colors:  [Colors.blueAccent, Colors.transparent],
    //   stops: [0.0, 1.0],
    // );

    final Paint paint = Paint()
      ..shader = const RadialGradient(
        colors: [Colors.blueAccent, Colors.transparent],
        stops: [0.0, 1.0],
      ).createShader(Rect.fromCenter(
          center: origin, width: size.width / 2, height: size.width / 2))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    double progress = elapsedTime / duration;

    // Draw ripples
    for (int i = 0; i < 5; i++) {
      double radius = progress * speed + (i * amplitude);
      double alpha = (1.0 - progress) * 255;
      paint.color = Colors.blueAccent.withAlpha(alpha.toInt());

      canvas.drawCircle(origin, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant RipplePainter oldDelegate) {
    return elapsedTime != oldDelegate.elapsedTime;
  }
}

/// Custom Painter for the animated rectangle shape
class AnimatedRectanglePainter extends CustomPainter {
  final double t; // Time value for animation
  final Size size;
  final double padding;
  final double cornerRadius;

  AnimatedRectanglePainter({
    required this.t,
    required this.size,
    this.padding = 8.0,
    required this.cornerRadius,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final Path path = Path();

    final double width = size.width;
    final double height = size.height;
    final double radius = cornerRadius;

    // Initial points
    final List<Offset> initialPoints = [
      Offset(padding + radius, padding), // Top-left rounded corner start
      Offset(width * 0.25 + padding, padding), // Top edge 1
      Offset(width * 0.75 + padding, padding), // Top edge 2
      Offset(
          width - padding - radius, padding), // Top-right rounded corner start
      Offset(width - padding, padding + radius), // Top-right corner
      Offset(width - padding, height * 0.25 - padding), // Right edge 1
      Offset(width - padding, height * 0.75 - padding), // Right edge 2
      Offset(width - padding,
          height - padding - radius), // Bottom-right rounded corner start
      Offset(width - padding - radius, height - padding), // Bottom-right corner
      Offset(width * 0.75 - padding, height - padding), // Bottom edge 1
      Offset(width * 0.25 - padding, height - padding), // Bottom edge 2
      Offset(padding + radius,
          height - padding), // Bottom-left rounded corner start
      Offset(padding, height - padding - radius), // Bottom-left corner
      Offset(padding, height * 0.75 - padding), // Left edge 1
      Offset(padding, height * 0.25 - padding), // Left edge 2
      Offset(padding, padding + radius) // Top-left rounded corner end
    ];

    // Animate points
    final List<Offset> animatedPoints = initialPoints.map((point) {
      return Offset(
        point.dx + 10 * sin(t + point.dy * 0.1),
        point.dy + 10 * sin(t + point.dx * 0.1),
      );
    }).toList();

    // Draw the path
    path.moveTo(animatedPoints[0].dx, animatedPoints[0].dy);

    // Top edge
    for (int i = 1; i <= 3; i++) {
      path.lineTo(animatedPoints[i].dx, animatedPoints[i].dy);
    }

    // Right edge
    for (int i = 4; i <= 7; i++) {
      path.lineTo(animatedPoints[i].dx, animatedPoints[i].dy);
    }

    // Bottom edge
    for (int i = 8; i <= 11; i++) {
      path.lineTo(animatedPoints[i].dx, animatedPoints[i].dy);
    }

    // Left edge
    for (int i = 12; i < animatedPoints.length; i++) {
      path.lineTo(animatedPoints[i].dx, animatedPoints[i].dy);
    }

    path.close();

    // Draw the animated path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant AnimatedRectanglePainter oldDelegate) {
    return t != oldDelegate.t;
  }
}

/// Custom Painter for Mesh Gradient
class MeshGradientPainter extends CustomPainter {
  final double maskTimer;
  final List<Color> colors;
  final double gradientSpeed;

  MeshGradientPainter({
    required this.maskTimer,
    required this.colors,
    required this.gradientSpeed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    final double width = size.width;
    final double height = size.height;

    // Define a grid of points (3x3 grid for simplicity)
    final List<Offset> points = [
      const Offset(0, 0),
      Offset(width / 2, 0),
      Offset(width, 0),
      Offset(0, height / 2),
      Offset(width / 2, height / 2),
      Offset(width, height / 2),
      Offset(0, height),
      Offset(width / 2, height),
      Offset(width, height),
    ];

    // Animate points dynamically using sinInRange
    final List<Offset> animatedPoints = points.map((point) {
      return Offset(
        point.dx + sinInRange(-50, 50, 0.5, 0.3, maskTimer),
        point.dy + sinInRange(-50, 50, 1.0, 0.7, maskTimer),
      );
    }).toList();

    // Create a gradient mesh
    for (int i = 0; i < 8; i += 3) {
      final Path path = Path()
        ..moveTo(animatedPoints[i].dx, animatedPoints[i].dy)
        ..lineTo(animatedPoints[i + 1].dx, animatedPoints[i + 1].dy)
        ..lineTo(animatedPoints[i + 4].dx, animatedPoints[i + 4].dy)
        ..lineTo(animatedPoints[i + 3].dx, animatedPoints[i + 3].dy)
        ..close();

      paint.shader = LinearGradient(
        colors: [colors[i % colors.length], colors[(i + 1) % colors.length]],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(path.getBounds());

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant MeshGradientPainter oldDelegate) {
    return maskTimer != oldDelegate.maskTimer;
  }

  double sinInRange(
      double min, double max, double timeScale, double offset, double t) {
    final double amplitude = (max - min) / 2;
    final double midPoint = (max + min) / 2;
    return midPoint + amplitude * sin(timeScale * t + offset);
  }
}
