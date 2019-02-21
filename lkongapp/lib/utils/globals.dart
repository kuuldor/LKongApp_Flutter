import 'dart:async';
import 'package:lkongapp/utils/network_isolate.dart';
import 'package:redux/redux.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'package:lkongapp/models/app_state.dart';
import 'package:lkongapp/utils/http_session.dart';

HttpSession session;

String appVersion = "1.1.9";

void initGlobals({bool testing: false}) {
  if (testing) {
    session = HttpSession(baseURL: 'http://lkong.cn', persist: false);
  } else {
    createNetworkIsolate();
  }
}

Timer createPeriodicTimer(Store<AppState> store,
    {Duration period, Function(Timer) callback}) {
  return Timer.periodic(period, callback);
}
