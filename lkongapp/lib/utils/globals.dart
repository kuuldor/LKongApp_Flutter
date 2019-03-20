import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lkongapp/actions/app_action.dart';
import 'package:connectivity/connectivity.dart';

import 'package:lkongapp/utils/cache_manager.dart';
import 'package:lkongapp/utils/network_isolate.dart';
import 'package:redux/redux.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'package:lkongapp/models/app_state.dart';
import 'package:lkongapp/utils/http_session.dart';
import 'package:path_provider/path_provider.dart';
import 'package:package_info/package_info.dart';
import 'package:lkongapp/middlewares/middlewares.dart';
import 'package:lkongapp/reducers/reducers.dart';
import 'package:redux_logging/redux_logging.dart';

LKongHttpSession session;
NetworkIsolate apiIsolate;
NetworkIsolate downloadIsolate;
ConnectivityResult connectivity;

PackageInfo packageInfo;

Store<AppState> store;

String copyRight = '© 2018 Akeysoft';

double defaultShakeThreshold = 5.0;

const screenPages = const [
  {
    "title": '首页',
    "icon": Icons.home,
  },
  {
    "title": '版块',
    "icon": Icons.dashboard,
  },
  {
    "title": '热门',
    "icon": Icons.whatshot,
  },
  {
    "title": '通知',
    "icon": Icons.notifications,
  },
  {
    "title": '搜索',
    "icon": Icons.search,
  },
];

void initGlobals({bool testing: false}) async {
  store = Store<AppState>(
    appReducer,
    initialState: AppState(),
    middleware: []..addAll(createStoreMiddleware()),
    // ..add(LoggingMiddleware.printer(formatter: (
    //   dynamic state,
    //   dynamic action,
    //   DateTime timestamp,
    // ) {
    //   return "{Action: $action, ts: ${new DateTime.now()}}";
    // })),
    distinct: true,
  );
  store.dispatch(Rehydrate());

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

  packageInfo = await PackageInfo.fromPlatform();
}

Timer createPeriodicTimer(Store<AppState> store,
    {Duration period, Function(Timer) callback}) {
  return Timer.periodic(period, callback);
}
