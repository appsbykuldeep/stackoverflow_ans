import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'isolate_handler.dart';

class IsolateTestScreen extends StatefulWidget {
  const IsolateTestScreen({super.key});

  @override
  State<IsolateTestScreen> createState() => _IsolateTestScreenState();
}

class _IsolateTestScreenState extends State<IsolateTestScreen> {
  List<ProcessInIsolate> isos =
      List.generate(5, (i) => ProcessInIsolate(isoLateId: i));
  // ProcessInIsolate iso = ProcessInIsolate(isoLateId: 1);

  late final maxIndex = isos.length - 1;

  int i = 0;

  void onTapStart() {
    final x = Platform.numberOfProcessors;
    print("x : $x");
    // iso.startIsolate();
  }

  void onTapSend() {
    final ms = IsoMessage(
      func: heavyTaskonIsolate,
      asyncfunc2: asyncheavyTaskonIsolate,
      asyncfuncinput: 9999999,
    );

    final f0 = ms.func;

    final t0 = [
      f0 is Function,
      f0 is Function(),
      f0 is Function(dynamic),
      f0 is dynamic Function(),
      f0 is FutureOr<dynamic> Function(),
      f0 is dynamic Function(dynamic),
      f0 is FutureOr<dynamic> Function(dynamic),
    ];
    print(t0);

    // isos[i].sendMessage(ms);

    // if (i == maxIndex) {
    //   i = 0;
    // } else {
    //   i++;
    // }
  }

  void onPageInit() {
    for (var x in isos) {
      x.startIsolate();
    }
  }

  void onPageClose() {
    for (var x in isos) {
      x.endIsolate();
    }
  }

  @override
  void initState() {
    onPageInit();
    super.initState();
  }

  @override
  void dispose() {
    onPageClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: onTapStart,
            child: const Text(
              "Start",
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: onTapSend,
              child: const Text(
                "Send",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
