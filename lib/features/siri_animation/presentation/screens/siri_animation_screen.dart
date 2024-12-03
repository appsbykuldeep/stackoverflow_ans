// Auto generated.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stackoverflow_ans/features/siri_animation/presentation/widgets/overlay_shape.dart';

class SiriAnimationScreen extends StatefulWidget {
  const SiriAnimationScreen({super.key});

  @override
  State<SiriAnimationScreen> createState() => _SiriAnimationScreenState();
}

class _SiriAnimationScreenState extends State<SiriAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _amplitude;

  Tween<double> randomTween([double? begin]) =>
      Tween<double>(begin: begin ?? Random().nextDouble(), end: 1);

  void setAplitude() {
    _amplitude = Tween<double>(begin: Random().nextDouble(), end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addStatusListener(
        (status) {
          print(status);
          if (status.isCompleted) {
            // setAplitude();
            // _controller.reverse();
          }
        },
      );

    // setAplitude();

    final tweenSequence = TweenSequence<double>(
      [
        TweenSequenceItem(
          tween: randomTween(0),
          weight: 0.2,
        ),
        TweenSequenceItem(
          tween: randomTween(),
          weight: 0.5,
        ),
        TweenSequenceItem(
          tween: randomTween(),
          weight: 0.3,
        ),
      ],
    );

    _amplitude = tweenSequence.animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    ));

    _controller.repeat(reverse: true);

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [],
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              color: Colors.white,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hello World !",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _amplitude,
              builder: (context, child) {
                return Container(
                  decoration: ShapeDecoration(
                    shape: OverlayShape(amplitude: _amplitude.value),
                  ),
                );
              },
            )
          ],
        )
        // body: Center(
        //   child: AnimatedBuilder(
        //     animation: _amplitude,
        //     builder: (context, child) {
        //       return CustomPaint(
        //         painter: SiriWave18Painter(_amplitude.value),
        //         size: const Size(300, 150),
        //       );
        //     },
        //   ),
        // ),
        );
  }
}


/*

https://github.com/metasidd/Prototype-Siri-Screen-Animation


https://pub.dev/packages/siri_wave

 */