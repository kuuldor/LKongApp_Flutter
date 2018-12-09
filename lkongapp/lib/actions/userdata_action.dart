import 'dart:async';

import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'package:meta/meta.dart';
import 'base_action.dart';
import 'api_action.dart';

// --- Base classes for all get my data requests/responses
abstract class GetMyDataRequest extends APIRequest with StartLoading {
  final int uid;
  final int nexttime;
  final int current;
  final int mode;

  GetMyDataRequest(
      Completer completer, this.uid, this.mode, this.nexttime, this.current)
      : super(completer: completer, api: MYDATA_API, parameters: {
          "uid": uid,
          "mode": mode,
          "nexttime": nexttime,
          "current": current,
        });
}

abstract class GetMyDataSuccess extends APISuccess with StopLoading {
  GetMyDataSuccess(APIRequest request) : super(request);
}

abstract class GetMyDataFailure extends APIFailure with StopLoading {
  GetMyDataFailure(APIRequest request, String error) : super(request, error);
}

//---- Get my favorites
abstract class GetMyFavoritesRequest extends GetMyDataRequest {
  GetMyFavoritesRequest(Completer completer, int uid, int nexttime, int current)
      : super(completer, uid, 0, nexttime, current);
}

class GetMyFavoritesSuccess extends GetMyDataSuccess with StopLoading {
  final StoryListResult result;

  GetMyFavoritesSuccess(request, this.result) : super(request);
}

class GetMyFavoritesFailure extends GetMyDataFailure {
  GetMyFavoritesFailure(APIRequest request, String error)
      : super(request, error);
}

class GetMyFavoritesNewRequest extends GetMyFavoritesRequest {
  GetMyFavoritesNewRequest(
      Completer completer, int uid, int nexttime, int current)
      : super(completer, uid, nexttime, current);

  @override
  CreateFailure get badResponse =>
      (error) => GetMyFavoritesNewFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetMyFavoritesNewSuccess(this, result);
}

class GetMyFavoritesRefreshRequest extends GetMyFavoritesRequest {
  GetMyFavoritesRefreshRequest(Completer completer, int uid, int current)
      : super(completer, uid, 0, current);

  @override
  CreateFailure get badResponse =>
      (error) => GetMyFavoritesRefreshFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetMyFavoritesRefreshSuccess(this, result);
}

class GetMyFavoritesLoadMoreRequest extends GetMyFavoritesRequest {
  GetMyFavoritesLoadMoreRequest(Completer completer, int uid, int nexttime)
      : super(completer, uid, nexttime, 0);

  @override
  CreateFailure get badResponse =>
      (error) => GetMyFavoritesLoadMoreFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetMyFavoritesLoadMoreSuccess(this, result);
}

class GetMyFavoritesNewSuccess extends GetMyFavoritesSuccess {
  GetMyFavoritesNewSuccess(request, StoryListResult result)
      : super(request, result);
}

class GetMyFavoritesNewFailure extends GetMyFavoritesFailure {
  GetMyFavoritesNewFailure(request, String error) : super(request, error);
}

class GetMyFavoritesRefreshSuccess extends GetMyFavoritesSuccess
    with StopLoading {
  GetMyFavoritesRefreshSuccess(request, StoryListResult result)
      : super(request, result);
}

class GetMyFavoritesRefreshFailure extends GetMyFavoritesFailure {
  GetMyFavoritesRefreshFailure(request, String error) : super(request, error);
}

class GetMyFavoritesLoadMoreSuccess extends GetMyFavoritesSuccess {
  GetMyFavoritesLoadMoreSuccess(request, StoryListResult result)
      : super(request, result);
}

class GetMyFavoritesLoadMoreFailure extends GetMyFavoritesFailure {
  GetMyFavoritesLoadMoreFailure(request, String error) : super(request, error);
}

//--- Get my AtMe messages
abstract class GetMyAtsRequest extends GetMyDataRequest {
  GetMyAtsRequest(Completer completer, int uid, int nexttime, int current)
      : super(completer, uid, 1, nexttime, current);
}

class GetMyAtsSuccess extends GetMyDataSuccess with StopLoading {
  final StoryListResult result;

  GetMyAtsSuccess(request, this.result) : super(request);
}

class GetMyAtsFailure extends GetMyDataFailure {
  GetMyAtsFailure(APIRequest request, String error) : super(request, error);
}

class GetMyAtsNewRequest extends GetMyAtsRequest {
  GetMyAtsNewRequest(Completer completer, int uid, int nexttime, int current)
      : super(completer, uid, nexttime, current);

  @override
  CreateFailure get badResponse => (error) => GetMyAtsNewFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetMyAtsNewSuccess(this, result);
}

class GetMyAtsRefreshRequest extends GetMyAtsRequest {
  GetMyAtsRefreshRequest(Completer completer, int uid, int current)
      : super(completer, uid, 0, current);

  @override
  CreateFailure get badResponse =>
      (error) => GetMyAtsRefreshFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetMyAtsRefreshSuccess(this, result);
}

class GetMyAtsLoadMoreRequest extends GetMyAtsRequest {
  GetMyAtsLoadMoreRequest(Completer completer, int uid, int nexttime)
      : super(completer, uid, nexttime, 0);

  @override
  CreateFailure get badResponse =>
      (error) => GetMyAtsLoadMoreFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetMyAtsLoadMoreSuccess(this, result);
}

class GetMyAtsNewSuccess extends GetMyAtsSuccess {
  GetMyAtsNewSuccess(request, StoryListResult result) : super(request, result);
}

class GetMyAtsNewFailure extends GetMyAtsFailure {
  GetMyAtsNewFailure(request, String error) : super(request, error);
}

class GetMyAtsRefreshSuccess extends GetMyAtsSuccess with StopLoading {
  GetMyAtsRefreshSuccess(request, StoryListResult result)
      : super(request, result);
}

class GetMyAtsRefreshFailure extends GetMyAtsFailure {
  GetMyAtsRefreshFailure(request, String error) : super(request, error);
}

class GetMyAtsLoadMoreSuccess extends GetMyAtsSuccess {
  GetMyAtsLoadMoreSuccess(request, StoryListResult result)
      : super(request, result);
}

class GetMyAtsLoadMoreFailure extends GetMyAtsFailure {
  GetMyAtsLoadMoreFailure(request, String error) : super(request, error);
}
