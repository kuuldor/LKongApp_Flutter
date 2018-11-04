import 'dart:async';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'base_action.dart';
import 'api_action.dart';

class LoginRequest extends APIRequest with StartLoading {
  User user;

  LoginRequest(Completer completer, this.user)
      : super(completer: completer, api: LOGIN_API, parameters: {"user": user});
}

class LoginSuccess extends APISuccess with StopLoading {
  final User user;

  LoginSuccess(this.user);
}

class LoginFailure extends APIFailure with StopLoading {
  LoginFailure(String error) : super(error);
}
