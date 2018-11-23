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
  CreateFailure get badResponse => (error) => LoginFailure(error);

  @override
  CreateSuccess get goodResponse => (user) => LoginSuccess(user);
}

class LoginSuccess extends APISuccess with StopLoading {
  final User user;

  LoginSuccess(this.user);
}

class LoginFailure extends APIFailure with StopLoading {
  LoginFailure(String error) : super(error);
}

class UserInfoRequest extends APIRequest with StartLoading {
  User user;

  UserInfoRequest(Completer completer, this.user)
      : super(
            completer: completer,
            api: USERINFO_API,
            parameters: {"id": user.uid, "forceRenew": true});

  @override
  CreateFailure get badResponse => (error) => UserInfoFailure(error);

  @override
  CreateSuccess get goodResponse => (userInfo) => UserInfoSuccess(userInfo);
}

class UserInfoSuccess extends APISuccess with StopLoading {
  final UserInfo userInfo;

  UserInfoSuccess(this.userInfo);
}

class UserInfoFailure extends APIFailure with StopLoading {
  UserInfoFailure(String error) : super(error);
}
