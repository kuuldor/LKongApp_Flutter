import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, LoginSuccess>(_loginSucceeded),
  TypedReducer<AuthState, LoginFailure>(_loginFailed),
  TypedReducer<AuthState, LoginTestSuccess>(_loginTestSucceeded),
  TypedReducer<AuthState, LoginTestFailure>(_loginTestFailed),
  TypedReducer<AuthState, UserInfoSuccess>(_userInfoSucceeded),
  TypedReducer<AuthState, UserInfoFailure>(_userInfoFailed),
  TypedReducer<AuthState, LogoutSuccess>(_logoutSucceeded),
  TypedReducer<AuthState, DeleteUsers>(_deleteUsers),
]);

AuthState _loginSucceeded(AuthState state, action) {
  User user = action.user;
  return state.rebuild((b) => b
    ..isAuthed = true
    ..currentUser = user.uid
    ..lastUser = user.uid
    ..error = null
    ..userRepo.updateValue(
        user.uid,
        (v) => v.rebuild((b) => b
          ..uid = user.uid
          ..identity = user.identity
          ..password = user.password),
        ifAbsent: () => user));
}

AuthState _loginFailed(AuthState state, action) {
  return state.rebuild((b) => b
    ..isAuthed = false
    ..currentUser = -1
    ..error = action.error);
}

AuthState _loginTestSucceeded(AuthState state, action) {
  User user = action.user;
  return state.rebuild((b) => b
    ..error = null
    ..userRepo.updateValue(
        user.uid,
        (v) => v.rebuild((b) => b
          ..uid = user.uid
          ..identity = user.identity
          ..password = user.password),
        ifAbsent: () => user));
}

AuthState _loginTestFailed(AuthState state, action) {
  return state.rebuild((b) => b..error = action.error);
}

AuthState _userInfoSucceeded(AuthState state, UserInfoSuccess action) {
  UserInfo info = action.userInfo;
  final user = state.userRepo[info.uid];
  var newState = state;
  if (user != null) {
    newState = newState.rebuild((b) => b.userRepo.updateValue(
        info.uid, (v) => v.rebuild((b) => b..userInfo.replace(info))));
  }
  return newState;
}

AuthState _userInfoFailed(AuthState state, UserInfoFailure action) {
  return state.rebuild((b) => b..error = action.error);
}

AuthState _logoutSucceeded(AuthState state, action) {
  return state.rebuild((b) => b
    ..isAuthed = false
    ..currentUser = -1
    ..error = null);
}

AuthState _deleteUsers(AuthState state, action) {
  Set<User> users = action.users;
  final uidSet = users.map((u) => u.uid).toSet();

  return state.rebuild(
      (b) => b..userRepo.removeWhere((uid, _) => uidSet.contains(uid)));
}
