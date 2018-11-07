import 'dart:async';
import 'base_action.dart';

typedef APISuccess CreateSuccess(dynamic param);
typedef APIFailure CreateFailure(String error);

abstract class APIRequest extends AsyncRequest<bool> {
  String api;
  Map parameters;

  CreateSuccess get goodResponse;
  CreateFailure get badResponse;

  APIRequest({Completer<bool> completer, this.api, this.parameters})
      : super(completer);
}

class APIResponse {}

class APISuccess extends APIResponse {}

class APIFailure extends APIResponse {
  final String error;
  APIFailure(this.error);
}
