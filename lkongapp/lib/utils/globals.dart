import 'dart:async';
import 'package:lkongapp/utils/cache_manager.dart';
import 'package:lkongapp/utils/network_isolate.dart';
import 'package:redux/redux.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'package:lkongapp/models/app_state.dart';
import 'package:lkongapp/utils/http_session.dart';

LKongHttpSession session;
NetworkIsolate apiIsolate;
NetworkIsolate downloadIsolate;

String appVersion = "1.1.9";

void initGlobals({bool testing: false}) {
  if (testing) {
    session = LKongHttpSession(baseURL: 'http://lkong.cn', persist: false);
  } else {
    apiIsolate = NetworkIsolate();
    apiIsolate.createNetworkIsolate(apiIsolateMain);

    downloadIsolate = NetworkIsolate();
    downloadIsolate.createNetworkIsolate(downloadIsolateMain);
  }
}

Timer createPeriodicTimer(Store<AppState> store,
    {Duration period, Function(Timer) callback}) {
  return Timer.periodic(period, callback);
}
