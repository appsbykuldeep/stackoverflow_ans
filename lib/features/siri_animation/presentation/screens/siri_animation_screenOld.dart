// Auto generated.

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/waveform_painter.dart';

class SiriAnimationScreenOld extends StatefulWidget {
  const SiriAnimationScreenOld({super.key});

  @override
  State<SiriAnimationScreenOld> createState() => _SiriAnimationScreenOldState();
}

class _SiriAnimationScreenOldState extends State<SiriAnimationScreenOld>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  double _amplitude = 0.0;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _amplitude = Random().nextDouble() * 20; // Simulating amplitude
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CustomPaint(
          painter: WaveformPainter(_amplitude),
          size: const Size(300, 100),
        ),
      ),
    );
  }
}
