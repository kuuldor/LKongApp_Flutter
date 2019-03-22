import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';
import 'package:redux/redux.dart';

void navigatorPush(Store<AppState> store, action, NextDispatcher next) {
  String route = store.state.uiState.navigationRoute;
  if (action is UINavigationPush) {
    if (!action.unique || !route.endsWith(action.routeName)) {
      if (action.builder != null) {
        Navigator.of(action.context).push(CupertinoPageRoute(
          builder: action.builder,
        ));
      } else {
        Navigator.of(action.context).pushNamed(action.routeName);
      }
      route = route + action.routeName;
    }
  }
  next(UIUpdateCurrentRoute(route));
}

void navigatorPopTo(Store<AppState> store, action, NextDispatcher next) {
  String route = store.state.uiState.navigationRoute;
  if (action is UINavigationPopTo) {
    while (route != "/" && !route.endsWith(action.routeName)) {
      Navigator.of(action.context).pop();
      var index = route.lastIndexOf("/");
      route = route.substring(0, index);
    }
  }
  next(UIUpdateCurrentRoute(route));
}

void navigatorPop(Store<AppState> store, action, NextDispatcher next) {
  String route = store.state.uiState.navigationRoute;
  if (action is UINavigationPop) {
    if (route != "/") {
      Navigator.of(action.context).pop();
      var index = route.lastIndexOf("/");
      route = route.substring(0, index);
    }
  }
  next(UIUpdateCurrentRoute(route));
}
