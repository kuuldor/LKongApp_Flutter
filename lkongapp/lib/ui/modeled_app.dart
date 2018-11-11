import 'package:flutter/material.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

class LKAppModel {
  final LKongAppTheme theme;
  LKAppModel({
    @required this.theme,
   });

  static LKAppModel fromStore(Store<AppState> store) {
    var _theme = LKongAppTheme.fromStore(store);
    LKAppModel model = LKAppModel(theme: _theme);
    return model;
  }

  @override
  bool operator ==(other) {
    return other is LKAppModel && theme == other.theme;
  }

  @override
  int get hashCode => hash2(theme, 0);
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
