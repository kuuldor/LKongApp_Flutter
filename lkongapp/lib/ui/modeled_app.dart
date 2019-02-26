import 'package:flutter/material.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

class LKAppModel {
  final LKongAppTheme theme;
  final bool shakeToNM;

  LKAppModel({
    @required this.theme,
    @required this.shakeToNM,
  });

  static LKAppModel fromStore(Store<AppState> store) {
    var _theme = LKongAppTheme.fromStore(store);
    LKAppModel model = LKAppModel(
        theme: _theme, shakeToNM: selectSetting(store).shakeToShiftNightMode);
    return model;
  }

  @override
  bool operator ==(other) {
    return other is LKAppModel &&
        theme == other.theme &&
        shakeToNM == other.shakeToNM;
  }

  @override
  int get hashCode => hash2(theme, shakeToNM);
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
