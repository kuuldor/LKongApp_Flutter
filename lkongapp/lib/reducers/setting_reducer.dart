import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

final settingsReducer = combineReducers<AppSetting>([
  TypedReducer<AppSetting, ChangeSetting>(_changeSetting),
]);

AppSetting _changeSetting(AppSetting setting, ChangeSetting action) {
  return setting.rebuild((b) => action.change(b));
}


