import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

final settingsReducer = combineReducers<AppSetting>([
  TypedReducer<AppSetting, ChangeSetting>(_changeSetting),
]);

AppSetting _changeSetting(AppSetting setting, ChangeSetting action) {
  return setting.rebuild((b) => action.change(b));
}


final accountSettingReducer = combineReducers<AccountSettings>([
  TypedReducer<AccountSettings, LoginSuccess>(_accountSettingReducer),
]);

AccountSettings _accountSettingReducer(
    AccountSettings acctSetting, LoginSuccess action) {
  int uid = action.user.uid;
  AccountSetting userSetting = acctSetting.accounts[uid] ?? AccountSetting();

  return acctSetting.rebuild((b) => b
    ..currentSetting.replace(userSetting)
    ..accounts
        .updateValue(uid, (v) => userSetting, ifAbsent: () => userSetting));
}

