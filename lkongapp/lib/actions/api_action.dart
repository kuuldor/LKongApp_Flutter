import 'dart:async';
import 'base_action.dart';

typedef APISuccess CreateSuccess(dynamic param);
typedef APIFailure CreateFailure(String error);

abstract class APIRequest extends AsyncRequest<String> {
  String api;
  Map parameters;

  CreateSuccess get goodResponse;
  CreateFailure get badResponse;

  APIRequest({Completer<String> completer, this.api, this.parameters})
      : super(completer);
}

class APIResponse {}

class APISuccess extends APIResponse {
  final APIRequest request;

  APISuccess(this.request);
}

class APIFailure extends APIResponse {
  final APIRequest request;
  final String error;
  APIFailure(this.request, this.error);
}
