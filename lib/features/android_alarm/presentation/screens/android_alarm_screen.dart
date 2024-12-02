// Auto generated.

import 'package:flutter/material.dart';
import 'package:stackoverflow_ans/extensions/num_ext.dart';
import 'package:stackoverflow_ans/features/android_alarm/presentation/utils/android_alarm_util.dart';

class AndroidAlarmScreen extends StatefulWidget {
  const AndroidAlarmScreen({super.key});

  @override
  State<AndroidAlarmScreen> createState() => _AndroidAlarmScreenState();
}

class _AndroidAlarmScreenState extends State<AndroidAlarmScreen> {
  AndroidAlarmUtil util = AndroidAlarmUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alarm"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FilledButton(
              onPressed: util.startAlarm,
              child: const Text("startAlarm"),
            ),
            20.heightBox,
            FilledButton(
              onPressed: util.stopAlarm,
              child: const Text("stopAlarm"),
            ),
            20.heightBox,
            FilledButton(
              onPressed: util.printTextFile,
              child: const Text("printTextFile"),
            ),
            20.heightBox,
          ],
        ),
      ),
    );
  }
}
