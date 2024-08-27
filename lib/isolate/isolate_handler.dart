import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';

int heavyTaskonIsolate() {
  int value = 0;
  for (int i = 0; i < 100000; i++) {
    value += i;
  }

  return value;
}

Future<int> asyncheavyTaskonIsolate(dynamic data) async {
  int value = 0;
  final time = data as int;
  for (int i = 0; i < time; i++) {
    value += i;
  }

  return value;
}

class ProcessInIsolate {
  final int isoLateId;
  ProcessInIsolate({
    required this.isoLateId,
  });

  final ReceivePort _receivePort = ReceivePort();
  Isolate? _isolate;
  SendPort? _sendPort;

  final RootIsolateToken rootToken = RootIsolateToken.instance!;

  // must call
  Future<void> startIsolate() async {
    _isolate = await Isolate.spawn(
        _isolateEntryPoint, (_receivePort.sendPort, rootToken, isoLateId));
    _receivePort.listen(onReceiveMessage);
  }

  // must call
  void endIsolate() {
    _isolate?.kill(priority: Isolate.immediate);
    _receivePort.close();
  }

  static void _isolateEntryPoint(
      (SendPort, RootIsolateToken, int) input) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(input.$2);
    ReceivePort receivePort = ReceivePort();
    final sendPort = input.$1;
    sendPort.send(receivePort.sendPort);
    final id = input.$3;
    print("_isolateEntryPoint : ${input.$3}");
    receivePort.listen((message) async {
      try {
        if (message is IsoMessage) {
          final resp = message.func?.call();
          final asyresp =
              await message.asyncfunc2?.call(message.asyncfuncinput);
          sendPort.send({"id": id, "func": resp, "asyresp": asyresp});
        }
        if (message is String) {
          final val = regigeredFunc[message]?.call();

          sendPort.send({"id": id, "val": val});
        }
      } catch (e) {
        print(e);
        sendPort.send({"id": id, "error": e.toString()});
      }
    });
  }

  void onReceiveMessage(dynamic message) {
    if (message is SendPort && _sendPort == null) {
      _sendPort = message;
      return;
    }
    print("_onReceiveMessage : $message ");

    // Handle your code.
  }

  /// Send any instuction which can handle in isolate
  void sendMessage(dynamic message) {
    _sendPort?.send(message);
  }
}

final Map<String, dynamic Function()> regigeredFunc = {
  "func": heavyTaskonIsolate,
};

class IsoMessage {
  dynamic Function()? func;
  Future<dynamic> Function()? asyncfunc;

  dynamic funcinput;
  dynamic asyncfuncinput;
  dynamic Function(dynamic)? func2;
  FutureOr<dynamic> Function(dynamic message)? asyncfunc2;

  IsoMessage({
    this.funcinput,
    this.asyncfuncinput,
    this.func,
    this.asyncfunc,
    this.func2,
    this.asyncfunc2,
  });
}
