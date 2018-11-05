import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/page_builder.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

Widget buildThemeWidget<T extends ThemeWidgetModel>(BuildContext context,
    T fromStore(Store<AppState> store), Widget buidler(ThemeWidgetModel vm)) {
  return StoreConnector<AppState, T>(
    converter: fromStore,
    builder: (context, vm) {
      return WidgetView(
        viewModel: vm,
        builder: buidler,
      );
    },
  );
}

class ThemeWidgetModel {
  AppTheme theme;

  ThemeWidgetModel({
    @required this.theme,
  });
  
  static AppTheme selectTheme(Store<AppState> store) {
    int themeIndex = store.state.appConfig.setting.nightMode
        ? store.state.appConfig.setting.themeSetting.night
        : store.state.appConfig.setting.themeSetting.day;
    return store.state.appConfig.setting.themeSetting.theme[themeIndex];
  }

  static ThemeWidgetModel fromStore(Store<AppState> store) {
    return ThemeWidgetModel(
      theme: selectTheme(store),
    );
  }
}

typedef Widget BuilderType(ThemeWidgetModel vm);

class WidgetView extends StatefulWidget {
  final ThemeWidgetModel viewModel;
  final BuilderType builder;

  WidgetView({
    Key key,
    @required this.viewModel,
    @required this.builder,
  }) : super(key: key);

  @override
  _WidgetViewState createState() => new _WidgetViewState();
}

class _WidgetViewState extends State<WidgetView> {
  @override
  Widget build(BuildContext context) {
    var viewModel = widget.viewModel;

    return widget.builder(viewModel);
  }
}
