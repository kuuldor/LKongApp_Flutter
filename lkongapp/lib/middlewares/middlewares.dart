library middlewares;

import 'dart:async';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/selectors/selectors.dart';

import 'persist.dart';
import 'api.dart';
import 'ui_nav.dart';

List<Middleware<AppState>> createStoreMiddleware() {
  return [
    filterAll,
    TypedMiddleware<AppState, DelayedAction>(delayed),
    thunkMiddleware
  ]
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
    store.dispatch(UserInfoRequest(null, user.uid));
    if (selectSetting(store).autoPunch) {
      store.dispatch(PunchCardRequest(null, user));
    }
    store.dispatch(ForumListRequest(null));
    store.dispatch(FollowListRequest(null, user));
  }

  if (action is RehydrateSuccess) {
    Future.delayed(Duration(milliseconds: 10), () {
      final setting = selectSetting(store);
      final user = selectUser(store);
      if (user != null && setting.autoLogin) {
        store.dispatch(LoginRequest(null, user));
      }
    });
  }

  if (action is FollowSuccess) {
    User user = selectUser(store);
    store.dispatch(FollowListRequest(null, user));
  }

  if (action is SendPMSuccess) {
    final request = action.request as SendPMRequest;
    final userData = selectUserData(store);
    final session = userData.pmSession[request.pmid];

    if (session != null) {
      store.dispatch(GetPMSessionRefreshRequest(
          null, request.uid, request.pmid, session.current));
    } else {
      store.dispatch(
          GetPMSessionNewRequest(null, request.uid, request.pmid, 0, 0));
    }
  }

  if (passon) {
    next(action);
  }
}

var delayedActions = Map<int, dynamic>();

void delayed(Store<AppState> store, DelayedAction action, NextDispatcher next) {
  int key = action.key;
  var delayed = action.delayed;

  delayedActions[key] = action;

  Future.delayed(delayed, () {
    var now = DateTime.now();
    var delayedAction = delayedActions[key] as DelayedAction;
    if (delayedAction != null && delayedAction.fireTime.isBefore(now)) {
      delayedActions[key] = null;
      store.dispatch(delayedAction.action);
    }
  });
}
