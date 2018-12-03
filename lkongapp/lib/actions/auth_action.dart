import 'dart:async';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'base_action.dart';
import 'api_action.dart';

class LoginRequest extends APIRequest with StartLoading {
  User user;

  LoginRequest(Completer completer, this.user)
      : super(completer: completer, api: LOGIN_API, parameters: {"user": user});

  @override
  CreateFailure get badResponse => (error) => LoginFailure(this, error);

  @override
  CreateSuccess get goodResponse => (user) => LoginSuccess(this, user);
}

class LoginSuccess extends APISuccess with StopLoading {
  final User user;

  LoginSuccess(request, this.user) : super(request);
}

class LoginFailure extends APIFailure with StopLoading {
  LoginFailure(request, String error) : super(request, error);
}

class UserInfoRequest extends APIRequest with StartLoading {
  User user;

  UserInfoRequest(Completer completer, this.user)
      : super(
            completer: completer,
            api: USERINFO_API,
            parameters: {"id": user.uid, "forceRenew": true});

  @override
  CreateFailure get badResponse => (error) => UserInfoFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (userInfo) => UserInfoSuccess(this, userInfo);
}

class UserInfoSuccess extends APISuccess with StopLoading {
  final UserInfo userInfo;

  UserInfoSuccess(request, this.userInfo) : super(request);
}

class UserInfoFailure extends APIFailure with StopLoading {
  UserInfoFailure(request, String error) : super(request, error);
}

class LogoutRequest extends APIRequest with StartLoading {
  LogoutRequest(Completer completer)
      : super(completer: completer, api: LOGOUT_API, parameters: {});

  @override
  CreateFailure get badResponse => (error) => LogoutFailure(this, error);

  @override
  CreateSuccess get goodResponse => (ignored) => LogoutSuccess(this);
}

class LogoutSuccess extends APISuccess with StopLoading {
  LogoutSuccess(request) : super(request);
}

class LogoutFailure extends APIFailure with StopLoading {
  LogoutFailure(request, String error) : super(request, error);
}
