import 'dart:async';

import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'base_action.dart';
import 'api_action.dart';

abstract class HomeListRequest extends APIRequest with StartLoading {
  final bool threadOnly;

  final int nexttime;
  final int current;

  HomeListRequest(
      Completer completer, this.threadOnly, this.nexttime, this.current)
      : super(completer: completer, api: HOMELIST_API, parameters: {
          "nexttime": nexttime,
          "current": current,
          "threadOnly": threadOnly
        });
}

class HomeListNewRequest extends HomeListRequest {
  HomeListNewRequest(Completer completer, bool threadOnly, int nexttime, int current) : super(completer, threadOnly, nexttime, current);

  @override
  CreateFailure get badResponse => (error) => HomeListNewFailure(error);

  @override
  CreateSuccess get goodResponse => (list) => HomeListNewSuccess(list);
}

class HomeListRefreshRequest extends HomeListRequest {
  final bool threadOnly;
  final int current;

  HomeListRefreshRequest(Completer completer, this.threadOnly, this.current)
      : super(completer, threadOnly, 0, current);

  @override
  CreateFailure get badResponse => (error) => HomeListRefreshFailure(error);

  @override
  CreateSuccess get goodResponse => (list) => HomeListRefreshSuccess(list);
}

class HomeListLoadMoreRequest extends HomeListRequest {
  final bool threadOnly;
  final int nexttime;

  HomeListLoadMoreRequest(Completer completer, this.threadOnly, this.nexttime)
      : super(completer, threadOnly, nexttime, 0);

  @override
  CreateFailure get badResponse => (error) => HomeListLoadMoreFailure(error);

  @override
  CreateSuccess get goodResponse => (list) => HomeListLoadMoreSuccess(list);
}

class HomeListSuccess extends APISuccess with StopLoading {
  final HomeListResult list;

  HomeListSuccess(this.list);
}

class HomeListFailure extends APIFailure with StopLoading {
  HomeListFailure(String error) : super(error);
}

class HomeListNewSuccess extends HomeListSuccess {
  HomeListNewSuccess(HomeListResult list) : super(list);
}

class HomeListNewFailure extends HomeListFailure {
  HomeListNewFailure(String error) : super(error);
}

class HomeListRefreshSuccess extends HomeListSuccess with StopLoading {
  HomeListRefreshSuccess(HomeListResult list) : super(list);
}

class HomeListRefreshFailure extends HomeListFailure {
  HomeListRefreshFailure(String error) : super(error);
}

class HomeListLoadMoreSuccess extends HomeListSuccess {
  HomeListLoadMoreSuccess(HomeListResult list) : super(list);
}

class HomeListLoadMoreFailure extends HomeListFailure {
  HomeListLoadMoreFailure(String error) : super(error);
}
