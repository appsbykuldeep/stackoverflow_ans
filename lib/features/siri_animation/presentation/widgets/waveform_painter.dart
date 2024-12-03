import 'dart:math';

import 'package:flutter/material.dart';

class WaveformPainter extends CustomPainter {
  final double amplitude;

  WaveformPainter(this.amplitude);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();
    const double frequency = 2.0; // Number of waves in the view
    final double midY = size.height / 2;

    for (double x = 0; x <= size.width; x++) {
      final double y = midY +
          amplitude *
              sin((2 * pi * frequency * x) / size.width) *
              cos(x * pi / size.width);
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
