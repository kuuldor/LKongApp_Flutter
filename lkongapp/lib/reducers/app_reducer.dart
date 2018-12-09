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

final appConfigReducer = combineReducers<AppConfig>([
  TypedReducer<AppConfig, SaveConfig>(_saveConfig),
  _appConfigReducer,
]);

AppConfig _saveConfig(AppConfig config, SaveConfig action) {
  return action.newConfig;
}

AppConfig _appConfigReducer(AppConfig config, action) {
  return config.rebuild((b) => b
    ..setting.replace(settingsReducer(config.setting, action))
    ..accountSettings
        .replace(accountSettingReducer(config.accountSettings, action)));
}
