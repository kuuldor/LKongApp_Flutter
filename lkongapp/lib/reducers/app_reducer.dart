import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

import 'setting_reducer.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, StartLoading>(_setLoading),
  TypedReducer<bool, StopLoading>(_setLoaded),
]);

bool _setLoading(bool state, action) {
  return true;
}

bool _setLoaded(bool state, action) {
  return false;
}

AppConfig appConfigReducer (AppConfig config, action) {
  return config.rebuild((b) => b
    ..setting.replace(settingsReducer(config.setting, action))
  );
}