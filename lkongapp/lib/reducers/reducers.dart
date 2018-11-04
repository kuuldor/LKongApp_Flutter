
library reducers;

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

import 'app_reducer.dart';
import 'auth_reducer.dart';

AppState appReducer(AppState state, action) {
  if (action is RehydrateSuccess) {
    return AppState().rebuild((b) => b.replace(action.state));
  }

  return state.rebuild((b) => b
    ..isLoading = loadingReducer(state.isLoading, action)
    ..authState.replace(authReducer(state.authState, action))
    ..uiState.replace(uiStateReducer(state.uiState, action))
    ..appConfig.replace(appConfigReducer(state.appConfig, action))
  );
}

