import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'package:lkongapp/utils/cache_manager.dart';
import 'package:lkongapp/utils/globals.dart';
import 'package:lkongapp/utils/http_session.dart';

class CrossIsolatesMessage<T> {
  final SendPort sender;
  final T message;

  CrossIsolatesMessage({
    @required this.sender,
    this.message,
  });
}

class NetworkIsolate {
  SendPort _isolateSendPort;
  Isolate _networkIsolate;

  bool get isolateReady {
    return _isolateSendPort != null;
  }

  Future sendReceive(Map message) async {
    ReceivePort port = ReceivePort();

    _isolateSendPort.send(CrossIsolatesMessage<Map>(
      sender: port.sendPort,
      message: message,
    ));

    return port.first;
  }

  Future createNetworkIsolate(_main) async {
    ReceivePort receivePort = ReceivePort();
    _networkIsolate = await Isolate.spawn(
      _main,
      receivePort.sendPort,
    );

    _isolateSendPort = await receivePort.first;
  }
}
