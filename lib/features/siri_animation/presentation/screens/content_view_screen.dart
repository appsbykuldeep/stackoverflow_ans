import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/siriwave18_painter.dart';

class ContentViewScreen extends StatefulWidget {
  const ContentViewScreen({super.key});

  @override
  _ContentViewScreenState createState() => _ContentViewScreenState();
}

enum SiriState { none, thinking }

class _ContentViewScreenState extends State<ContentViewScreen>
    with TickerProviderStateMixin {
  SiriState state = SiriState.thinking;

  // Ripple animation variables
  int counter = 0;
  Offset origin = const Offset(0.5, 0.5);

  // Gradient and masking variables
  double gradientSpeed = 0.03;
  Timer? timer;
  double maskTimer = 0.0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        maskTimer += rectangleSpeed;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          RippleEffect(
            origin: const Offset(0, 0),
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      state = state == SiriState.none
                          ? SiriState.thinking
                          : SiriState.none;
                    });
                  },
                  child: const Text("Toggle State"),
                ),
              ),
            ),
          ),

          if (state == SiriState.thinking)
            Positioned.fill(
              child: Center(
                child: Container(
                  width: size.width - 20,
                  height: size.height - 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 4),
                    borderRadius: BorderRadius.circular(52),
                  ),
                ),
              ),
            ),
          // Masked animated rectangle
          Positioned.fill(
            child: ClipRect(
              child: CustomPaint(
                painter: AnimatedRectanglePainter(
                  size: size,
                  cornerRadius: 48,
                  t: maskTimer,
                ),
              ),
            ),
          ),

          // Button to toggle state
        ],
      ),
    );
  }

  double get computedScale {
    switch (state) {
      case SiriState.none:
        return 1.2;
      case SiriState.thinking:
        return 1.0;
    }
  }

  double get rectangleSpeed {
    switch (state) {
      case SiriState.none:
        return 0.0;
      case SiriState.thinking:
        return gradientSpeed;
    }
  }

  double get animatedMaskBlur {
    switch (state) {
      case SiriState.none:
        return 8.0;
      case SiriState.thinking:
        return 28.0;
    }
  }
}

class RippleEffect extends StatefulWidget {
  final Widget child;
  final Offset origin;

  const RippleEffect({
    super.key,
    required this.child,
    required this.origin,
  });

  @override
  _RippleEffectState createState() => _RippleEffectState();
}

class _RippleEffectState extends State<RippleEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: RipplePainter(
            origin: widget.origin,
            elapsedTime: _controller.value * 3, // Scale animation to 3 seconds.
            duration: 3,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}


// class MeshGradientWidget extends StatelessWidget {
//   final double maskTimer;
//   final double gradientSpeed;

//   const MeshGradientWidget({
//     super.key,
//     required this.maskTimer,
//     required this.gradientSpeed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: MeshGradientPainter(maskTimer: maskTimer),
//       child: Container(),
//     );
//   }
// }

// class MeshGradientPainter extends CustomPainter {
//   final double maskTimer;

//   MeshGradientPainter({required this.maskTimer});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint();

//     // Define gradient colors and points
//     final List<Color> colors = [
//       Colors.yellow,
//       Colors.purple,
//       Colors.indigo,
//       Colors.orange,
//       Colors.red,
//       Colors.blue,
//       Colors.green,
//       Colors.teal,
//       Colors.pink,
//     ];
//     final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

//     paint.shader = RadialGradient(
//       colors: colors,
//       stops: List.generate(colors.length, (i) => i / (colors.length - 1)),
//     ).createShader(rect);

//     canvas.drawRect(rect, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// class AnimatedRectanglePainter extends CustomPainter {
//   final Size size;
//   final double cornerRadius;
//   final double t;
//   final double scale;
//   final double blurRadius;

//   AnimatedRectanglePainter({
//     required this.size,
//     required this.cornerRadius,
//     required this.t,
//     required this.scale,
//     required this.blurRadius,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()..color = Colors.black;

//     // Animate the rectangle path
//     final Path path = Path()
//       ..addRRect(
//         RRect.fromRectAndRadius(
//           Rect.fromLTWH(
//             size.width * (1 - scale) / 2,
//             size.height * (1 - scale) / 2,
//             size.width * scale,
//             size.height * scale,
//           ),
//           Radius.circular(cornerRadius),
//         ),
//       );

//     canvas.drawShadow(path, Colors.black, blurRadius, true);
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
