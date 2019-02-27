import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/setting_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:connectivity/connectivity.dart';
import 'package:lkongapp/utils/shake_detector.dart';

import 'package:lkongapp/models/models.dart';

import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:lkongapp/ui/screens.dart';
import 'package:lkongapp/utils/globals.dart' as globals;

void main() {
  globals.initGlobals();
  runApp(new LKongApp());
}

class LKongApp extends StatefulWidget {
  LKongApp({Key key}) : super(key: key);

  @override
  LKongAppState createState() {
    return new LKongAppState();
  }
}

class LKongAppState extends State<LKongApp> with WidgetsBindingObserver {
  Timer autoPunchTimer;
  Timer checkNotifTimer;
  var connectSubscription;
  var shakeSubscription;

  ShakeDetector shakeDetector;

  int quickSwitchNightMode = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    connectSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      globals.connectivity = result;
    });

    quickSwitchNightMode = -1;
    ShakeDetector.getInstance().then((detector) {
      shakeDetector = detector;
      shakeSubscription = shakeDetector.listen((shake) => switchNightMode());
      if (quickSwitchNightMode < 0) {
        shakeDetector.stopCaptureSensor();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    connectSubscription.cancel();
    shakeSubscription.cancel();
    shakeDetector.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final user = selectUser(globals.store);
      if (user != null && user.uid > 0) {
        globals.store.dispatch(PunchCardRequest(null, user));
        globals.store.dispatch(CheckNoticeRequest(null, user));
      }

      final settings = selectSetting(globals.store);
      if (shakeDetector != null &&
          settings.shakeToShiftNightMode &&
          (settings.switchMethod ?? 0) == 0) {
        shakeDetector.startCaptureSensor();
      }
    } else if (state == AppLifecycleState.paused) {
      if (shakeDetector != null) {
        shakeDetector.stopCaptureSensor();
      }
    }
  }

  void setSwitchMode(bool enabled, int mode) {
    if (enabled) {
      if (quickSwitchNightMode != mode) {
        quickSwitchNightMode = mode;
        if (mode == 0) {
          shakeDetector?.startCaptureSensor();
        } else {
          shakeDetector?.stopCaptureSensor();
        }
      }
    } else {
      quickSwitchNightMode = -1;
      shakeDetector?.stopCaptureSensor();
    }
  }

  @override
  Widget build(BuildContext context) {
    autoPunchTimer = globals.createPeriodicTimer(
      globals.store,
      period: Duration(hours: 12),
      callback: (timer) {
        if (selectSetting(globals.store).autoPunch) {
          final user = selectUser(globals.store);
          if (user != null && user.uid > 0) {
            globals.store.dispatch(PunchCardRequest(null, user));
          }
        }
      },
    );

    checkNotifTimer = globals.createPeriodicTimer(
      globals.store,
      period: Duration(minutes: 1),
      callback: (timer) {
        final user = selectUser(globals.store);
        if (user != null && user.uid > 0) {
          globals.store.dispatch(CheckNoticeRequest(null, user));
        }
      },
    );

    return StoreProvider<AppState>(
      store: globals.store,
      child: buildConnectedWidget(context, LKAppModel.fromStore, (viewModel) {
        final settings = selectSetting(globals.store);
        final enabled = settings.shakeToShiftNightMode;
        final mode = settings.switchMethod;

        setSwitchMode(enabled, mode);

        if (enabled && mode == 1) {
          return LKModeledApp(
            model: viewModel,
            child: GestureDetector(
              child: MaterialApp(
                title: LKongLocalizations().appTitle,
                theme: viewModel.theme.themeData,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: [
                  LKongLocalizationsDelegate(),
                ],
                initialRoute: LKongAppRoutes.home,
                routes: {
                  LKongAppRoutes.login: (context) =>
                      LoginScreen(key: LKongAppKeys.loginScreen),
                  LKongAppRoutes.home: (context) => HomeScreen(),
                  LKongAppRoutes.settings: (context) => SettingScreen(),
                  LKongAppRoutes.accountManage: (context) =>
                      AccountManageScreen(),
                  LKongAppRoutes.manageBlacklist: (context) =>
                      BlacklistManageScreen(),
                  LKongAppRoutes.favorite: (context) => FavoriteScreen(),
                },
              ),
              onLongPress: () {
                switchNightMode();
              },
            ),
          );
        } else {
          return LKModeledApp(
            model: viewModel,
            child: MaterialApp(
              title: LKongLocalizations().appTitle,
              theme: viewModel.theme.themeData,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                LKongLocalizationsDelegate(),
              ],
              initialRoute: LKongAppRoutes.home,
              routes: {
                LKongAppRoutes.login: (context) =>
                    LoginScreen(key: LKongAppKeys.loginScreen),
                LKongAppRoutes.home: (context) => HomeScreen(),
                LKongAppRoutes.settings: (context) => SettingScreen(),
                LKongAppRoutes.accountManage: (context) =>
                    AccountManageScreen(),
                LKongAppRoutes.manageBlacklist: (context) =>
                    BlacklistManageScreen(),
                LKongAppRoutes.favorite: (context) => FavoriteScreen(),
              },
            ),
          );
        }
      }),
    );
  }

  switchNightMode() {
    final setting = selectSetting(globals.store);
    if (setting.shakeToShiftNightMode) {
      globals.store.dispatch(
          ChangeSetting((b) => b..nightMode = (b.nightMode == false)));
    }
  }
}
