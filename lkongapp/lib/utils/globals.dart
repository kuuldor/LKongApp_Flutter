import 'dart:async';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/app_state.dart';
import 'package:lkongapp/utils/http_session.dart';

HttpSession session;

String appVersion = "1.1.7";

void initGlobals({bool testing: false}) {
  session = HttpSession(baseURL: 'http://lkong.cn', persist: !testing);
}

Timer createPeriodicTimer(Store<AppState> store,
    {Duration period, Function(Timer) callback}) {
  return Timer.periodic(period, callback);
}
