import 'package:flutter/material.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

class LKAppModel {
  final LKongAppTheme theme;
  final User user;
  LKAppModel({
    @required this.theme,
    @required this.user,
  });

  static LKAppModel fromStore(Store<AppState> store) {
    var _theme = LKongAppTheme.fromStore(store);
    var _user = store.state.authState.isAuthed
        ? store.state.authState.currentUser
        : null;
    LKAppModel model = LKAppModel(theme: _theme, user: _user);
    return model;
  }

  @override
  bool operator ==(other) {
    return other is LKAppModel && theme == other.theme && user == other.user;
  }

  @override
  int get hashCode => hash2(theme, user);
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
