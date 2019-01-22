import 'package:lkongapp/models/models.dart';

import 'package:redux/redux.dart';

final showDetailTime = (Store<AppState> store) =>
    store.state.persistState.appConfig.setting.showDetailTime;

final selectSetting =
    (Store<AppState> store) => store.state.persistState.appConfig.setting;

final selectAccountSetting = (Store<AppState> store) =>
    store.state.persistState.appConfig.accountSettings;
