import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:lkongapp/utils/cache_manager.dart';
import 'package:lkongapp/utils/network_isolate.dart';
import 'package:redux/redux.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'package:lkongapp/models/app_state.dart';
import 'package:lkongapp/utils/http_session.dart';
import 'package:path_provider/path_provider.dart';

LKongHttpSession session;
NetworkIsolate apiIsolate;
NetworkIsolate downloadIsolate;
ConnectivityResult connectivity;

String appVersion = "1.2.1";

void initGlobals({bool testing: false}) async {
  final appDocDir = await getApplicationDocumentsDirectory();
  if (testing) {
    session = LKongHttpSession(
        baseURL: 'http://lkong.cn', appDocDir: appDocDir.path, persist: false);
  } else {
    downloadIsolate = NetworkIsolate();
    downloadIsolate.createNetworkIsolate(downloadIsolateMain);

    apiIsolate = NetworkIsolate();
    await apiIsolate.createNetworkIsolate(apiIsolateMain);

    apiIsolate.sendReceive({"DOCDIR": appDocDir.path});
  }
}

Timer createPeriodicTimer(Store<AppState> store,
    {Duration period, Function(Timer) callback}) {
  return Timer.periodic(period, callback);
}
