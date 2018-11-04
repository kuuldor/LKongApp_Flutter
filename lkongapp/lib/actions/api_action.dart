import 'dart:async';
import 'base_action.dart';

class APIRequest extends AsyncRequest<bool> {
  String api;
  Map parameters;
  APIRequest({Completer<bool> completer, this.api, this.parameters})
      : super(completer);
}

class APIResponse {}

class APISuccess extends APIResponse {}

class APIFailure extends APIResponse {
    final String error;
    APIFailure(this.error);
}