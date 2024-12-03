import 'package:flutter/material.dart';

class OverlayShape extends ShapeBorder {
  /// It will be between 0-1
  final double amplitude;

  const OverlayShape({
    this.amplitude = 0,
  });

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return getLeftTopPath(rect)
      ..lineTo(
        rect.right,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.top,
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;

    final height = rect.height;

    final Paint paint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.blue, Colors.purple, Colors.pink],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, width, height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15 + (10 * amplitude)
      ..maskFilter = const MaskFilter.blur(BlurStyle.inner, 10);

    canvas
      // ..saveLayer(
      //   rect,
      //   paint,
      // )
      ..drawRRect(
        RRect.fromRectAndRadius(
          rect,
          const Radius.circular(10),
        ),
        paint,
      )
      ..restore();
  }

  @override
  ShapeBorder scale(double t) {
    return const OverlayShape();
  }
}
