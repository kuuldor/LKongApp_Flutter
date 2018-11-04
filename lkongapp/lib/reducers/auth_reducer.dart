import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, LoginSuccess>(_loginSucceeded),
  TypedReducer<AuthState, LoginFailure>(_loginFailed),
]);

AuthState _loginSucceeded(AuthState state, action) {
  return state.rebuild((b) => b
    ..isAuthed = true
    ..currentUser.replace(action.user));
}

AuthState _loginFailed(AuthState state, action) {
  return state.rebuild((b) => b
    ..isAuthed = false
    ..currentUser.replace(User())
    ..error = action.error);
}
