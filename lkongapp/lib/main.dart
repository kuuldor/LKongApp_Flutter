import 'package:flutter/material.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/middlewares/middlewares.dart';
import 'package:lkongapp/reducers/reducers.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:lkongapp/ui/screens.dart';

void main() => runApp(new LKongApp());

class LKongApp extends StatelessWidget {
  // This widget is the root of your application.
  final store = Store<AppState>(appReducer,
      initialState: AppState(), middleware: []..addAll(createStoreMiddleware())
      // ..add(LoggingMiddleware.printer())
      );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      // child: _createApp(ThemedWidgetModel.fromStore(store)),
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
        initialRoute: LKongAppRoutes.login,
        routes: {
          LKongAppRoutes.login: (context) =>
              LoginScreen(key: LKongAppKeys.loginScreen),
          LKongAppRoutes.home: (context) => HomeScreen(),
        },
      ));
}
