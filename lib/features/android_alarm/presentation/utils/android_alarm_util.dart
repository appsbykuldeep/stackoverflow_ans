import 'dart:developer' as dev;
import 'dart:io';
import 'dart:isolate';

// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:path_provider/path_provider.dart';

class AndroidAlarmUtil {
  final helloAlarmID = 0;
  Future<void> startAlarm() async {
    // final status = await AndroidAlarmManager.periodic(
    //     const Duration(minutes: 1), helloAlarmID, printHello);
    // dev.log("startAlarm :: $status :: $helloAlarmID");
  }

  Future<void> stopAlarm() async {
    // final status = await AndroidAlarmManager.cancel(helloAlarmID);
    // dev.log("stopAlarm :: $status :: $helloAlarmID");
  }

  Future<void> printTextFile() async {
    final file = await _getTextFile();
    final text = await file.readAsString();
    dev.log("printTextFile::\n$text");
  }

  void init() {}
}

Future<File> _getTextFile() async {
  final path = "${(await getApplicationDocumentsDirectory()).path}/test.text";
  final file = File(path);
  return file;
}

@pragma('vm:entry-point')
void printHello() async {
  final file = await _getTextFile();
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  final message =
      "[$now] Hello, world! isolate=$isolateId function='$printHello'";
  await file.writeAsString(
    message,
    mode: FileMode.append,
  );
  dev.log(message);
}
