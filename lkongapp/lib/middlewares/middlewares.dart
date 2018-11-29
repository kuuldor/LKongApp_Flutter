library middlewares;

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

import 'persist.dart';
import 'api.dart';
import 'ui_nav.dart';

List<Middleware<AppState>> createStoreMiddleware() {
  return [filterAll, thunkMiddleware]
    ..addAll(createStorePersistentMiddleware())
    ..addAll(createAPICallMiddleware())
    ..addAll(createUINavigationMiddleware());
}

List<Middleware<AppState>> createStorePersistentMiddleware() {
  return [
    TypedMiddleware<AppState, Rehydrate>(loadAppState),
    TypedMiddleware<AppState, Dehydrate>(saveAppState),
    checkAndSaveAppState
  ];
}

List<Middleware<AppState>> createAPICallMiddleware() {
  return [
    TypedMiddleware<AppState, APIRequest>(callAPI),
  ];
}

List<Middleware<AppState>> createUINavigationMiddleware() {
  return [
    TypedMiddleware<AppState, UINavigationPush>(navigatorPush),
    TypedMiddleware<AppState, UINavigationPopTo>(navigatorPopTo),
    TypedMiddleware<AppState, UINavigationPop>(navigatorPop),
  ];
}

// Filter every action here
void filterAll(Store<AppState> store, action, NextDispatcher next) {
  // if an action should be consumed here, set passon to false
  bool passon = true;

  //Filter all the actions and do dispatch another action if necessary
  if (action is LoginSuccess) {
    User user = action.user;
    store.dispatch(UserInfoRequest(null, user));
  }

  if (passon) {
    next(action);
  }
}
