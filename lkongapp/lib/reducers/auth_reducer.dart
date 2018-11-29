import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, LoginSuccess>(_loginSucceeded),
  TypedReducer<AuthState, LoginFailure>(_loginFailed),
  TypedReducer<AuthState, UserInfoSuccess>(_userInfoSucceeded),
  TypedReducer<AuthState, UserInfoFailure>(_userInfoFailed),
  TypedReducer<AuthState, LogoutSuccess>(_logoutSucceeded),
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

AuthState _userInfoSucceeded(AuthState state, action) {
  UserInfo info = action.userInfo;
  return state.rebuild((b) => b.userRepo.updateValue(
      info.uid, (v) => v.rebuild((b) => b.userInfo.replace(info))));
}

AuthState _userInfoFailed(AuthState state, action) {
  return state.rebuild((b) => b..error = action.error);
}

AuthState _logoutSucceeded(AuthState state, action) {
  return state.rebuild((b) => b
    ..isAuthed = false
    ..currentUser = -1
    ..error = null);
}
