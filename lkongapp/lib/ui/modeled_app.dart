import 'package:flutter/material.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

class LKAppModel {
  final LKongAppTheme theme;
  final bool shakeToNM;
  final int switchMethod;

  LKAppModel({
    @required this.theme,
    @required this.shakeToNM,
    @required this.switchMethod,
  });

  static LKAppModel fromStore(Store<AppState> store) {
    final _theme = LKongAppTheme.fromStore(store);
    final settings = selectSetting(store);
    LKAppModel model = LKAppModel(
      theme: _theme,
      shakeToNM: settings.shakeToShiftNightMode,
      switchMethod: settings.switchMethod,
    );
    return model;
  }

  @override
  bool operator ==(other) {
    return other is LKAppModel &&
        theme == other.theme &&
        shakeToNM == other.shakeToNM &&
        switchMethod == other.switchMethod;
  }

  @override
  int get hashCode => hash3(theme, shakeToNM, switchMethod);
}

class LKModeledApp extends InheritedWidget {
  final LKAppModel model;

  LKModeledApp({Key key, @required this.model, @required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(LKModeledApp old) {
    return old.model != model;
  }

  static LKAppModel modelOf(BuildContext context) {
    LKModeledApp app = context.inheritFromWidgetOfExactType(LKModeledApp);
    return app.model;
  }
}
