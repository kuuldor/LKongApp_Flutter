library reducers;

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

import 'app_reducer.dart';
import 'auth_reducer.dart';
import 'ui_reducer.dart';

AppState appReducer(AppState state, action) {
  if (action is RehydrateSuccess) {
    return AppState().rebuild((b) => b..persistState.replace(action.state));
  }

  return state.rebuild((b) => b
    ..isLoading = loadingReducer(state.isLoading, action)
    ..persistState.replace(persistStateReducer(state.persistState, action))
    ..uiState.replace(uiStateReducer(state.uiState, action)));
}

PersistentState persistStateReducer(PersistentState state, action) {
  return state.rebuild((b) => b
    ..authState.replace(authReducer(state.authState, action))
    ..appConfig.replace(appConfigReducer(state.appConfig, action)));
}
