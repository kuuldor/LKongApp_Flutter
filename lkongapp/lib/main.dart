import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/setting_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/middlewares/middlewares.dart';
import 'package:lkongapp/reducers/reducers.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:lkongapp/ui/screens.dart';
import 'package:lkongapp/utils/globals.dart' as globals;

void main() {
  globals.initGlobals();
  runApp(new LKongApp());
}

class LKongApp extends StatefulWidget {
  // This widget is the root of your application.
  static final store = Store<AppState>(
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

  LKongApp({Key key}) : super(key: key);

  @override
  LKongAppState createState() {
    return new LKongAppState();
  }
}

class LKongAppState extends State<LKongApp> with WidgetsBindingObserver {
  Timer autoPunchTimer;
  Timer checkNotifTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final user = selectUser(LKongApp.store);
      if (user != null && user.uid > 0) {
        LKongApp.store.dispatch(PunchCardRequest(null, user));
        LKongApp.store.dispatch(CheckNoticeRequest(null, user));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    autoPunchTimer = globals.createPeriodicTimer(
      LKongApp.store,
      period: Duration(hours: 12),
      callback: (timer) {
        if (selectSetting(LKongApp.store).autoPunch) {
          final user = selectUser(LKongApp.store);
          if (user != null && user.uid > 0) {
            LKongApp.store.dispatch(PunchCardRequest(null, user));
          }
        }
      },
    );

    checkNotifTimer = globals.createPeriodicTimer(
      LKongApp.store,
      period: Duration(minutes: 1),
      callback: (timer) {
        final user = selectUser(LKongApp.store);
        if (user != null && user.uid > 0) {
          LKongApp.store.dispatch(CheckNoticeRequest(null, user));
        }
      },
    );

    LKongApp.store.dispatch(Rehydrate());
    return StoreProvider<AppState>(
      store: LKongApp.store,
      child: buildConnectedWidget(
          context, LKAppModel.fromStore, _createModeledApp),
    );
  }
}

Widget _createModeledApp(viewModel) {
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
          LKongAppRoutes.accountManage: (context) => AccountManageScreen(),
          LKongAppRoutes.favorite: (context) => FavoriteScreen(),
        },
      ));
}
