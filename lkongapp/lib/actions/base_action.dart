import 'dart:async';

class StartLoading {}

class StopLoading {}

class AsyncRequest<T> {
  final Completer<T> completer;
  AsyncRequest(this.completer);
}

