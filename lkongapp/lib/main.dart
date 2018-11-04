import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/middlewares/middlewares.dart';
import 'package:lkongapp/reducers/reducers.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:lkongapp/ui/screens.dart';

void main() => runApp(new LKongApp());

class LKongApp extends StatefulWidget {
  // This widget is the root of your application.
  final store = Store<AppState>(appReducer,
      initialState: AppState(),
      middleware: []
        ..addAll(createStoreMiddleware())
        ..add(LoggingMiddleware.printer()));

  @override
  State<StatefulWidget> createState() {
    return LKongAppState();
  }
}

class LKongAppState extends State<LKongApp> {
  Store<AppState> store;

  LKongAppState();

  @override
  void initState() {
    store = widget.store;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: LKongLocalizations().appTitle,
        theme: LKongAppTheme.theme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          LKongLocalizationsDelegate(),
        ],
        initialRoute: LKongAppRoutes.login,
        routes: {
          LKongAppRoutes.login: (context) =>
              LoginScreen(key: LKongAppKeys.loginScreen),
          LKongAppRoutes.home: (context) =>
              HomeScreen(),
        },
      ),
    );
  }
}
