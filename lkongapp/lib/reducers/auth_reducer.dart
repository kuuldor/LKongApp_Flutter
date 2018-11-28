import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, LoginSuccess>(_loginSucceeded),
  TypedReducer<AuthState, LoginFailure>(_loginFailed),
  TypedReducer<AuthState, UserInfoSuccess>(_userInfoSucceeded),
  TypedReducer<AuthState, UserInfoFailure>(_userInfoFailed),
]);

AuthState _loginSucceeded(AuthState state, action) {
  return state.rebuild((b) => b
    ..isAuthed = true
    ..error = null
    ..currentUser.replace(action.user));
}

AuthState _loginFailed(AuthState state, action) {
  return state.rebuild((b) => b
    ..isAuthed = false
    ..currentUser.replace(User())
    ..error = action.error);
}

AuthState _userInfoSucceeded(AuthState state, action) {
  return state.rebuild((b) => b..userInfo.replace(action.userInfo));
}

AuthState _userInfoFailed(AuthState state, action) {
  return state.rebuild((b) => b..error = action.error);
}
