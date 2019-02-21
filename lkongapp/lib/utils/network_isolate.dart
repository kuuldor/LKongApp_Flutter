import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:lkongapp/middlewares/api.dart';
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

void _isolateMain(SendPort callerSendPort) async {
  session = HttpSession(baseURL: 'http://lkong.cn', persist: false);

  ReceivePort apiReceivePort = ReceivePort();

  callerSendPort.send(apiReceivePort.sendPort);

  await for (var message in apiReceivePort) {
    CrossIsolatesMessage incomingMessage = message as CrossIsolatesMessage;
    Map params = incomingMessage.message as Map;

    var result;

    if (params.containsKey("API")) {
      result = await handleAPIRequest(params);
    }

    incomingMessage.sender.send(result);
  }
}

void createNetworkIsolate() async {
  ReceivePort receivePort = ReceivePort();
  _networkIsolate = await Isolate.spawn(
    _isolateMain,
    receivePort.sendPort,
  );

  _isolateSendPort = await receivePort.first;
}
