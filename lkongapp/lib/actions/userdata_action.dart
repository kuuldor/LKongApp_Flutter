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
  dynamic get result;
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

//--- Get my Notice messages
abstract class GetNoticeRequest extends GetMyDataRequest {
  GetNoticeRequest(Completer completer, int uid, int nexttime, int current)
      : super(completer, uid, 2, nexttime, current);
}

class GetNoticeSuccess extends GetMyDataSuccess with StopLoading {
  final NoticeResult result;

  GetNoticeSuccess(request, this.result) : super(request);
}

class GetNoticeFailure extends GetMyDataFailure {
  GetNoticeFailure(APIRequest request, String error) : super(request, error);
}

class GetNoticeNewRequest extends GetNoticeRequest {
  GetNoticeNewRequest(Completer completer, int uid, int nexttime, int current)
      : super(completer, uid, nexttime, current);

  @override
  CreateFailure get badResponse => (error) => GetNoticeNewFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetNoticeNewSuccess(this, result);
}

class GetNoticeRefreshRequest extends GetNoticeRequest {
  GetNoticeRefreshRequest(Completer completer, int uid, int current)
      : super(completer, uid, 0, current);

  @override
  CreateFailure get badResponse =>
      (error) => GetNoticeRefreshFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetNoticeRefreshSuccess(this, result);
}

class GetNoticeLoadMoreRequest extends GetNoticeRequest {
  GetNoticeLoadMoreRequest(Completer completer, int uid, int nexttime)
      : super(completer, uid, nexttime, 0);

  @override
  CreateFailure get badResponse =>
      (error) => GetNoticeLoadMoreFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetNoticeLoadMoreSuccess(this, result);
}

class GetNoticeNewSuccess extends GetNoticeSuccess {
  GetNoticeNewSuccess(request, NoticeResult result) : super(request, result);
}

class GetNoticeNewFailure extends GetNoticeFailure {
  GetNoticeNewFailure(request, String error) : super(request, error);
}

class GetNoticeRefreshSuccess extends GetNoticeSuccess with StopLoading {
  GetNoticeRefreshSuccess(request, NoticeResult result)
      : super(request, result);
}

class GetNoticeRefreshFailure extends GetNoticeFailure {
  GetNoticeRefreshFailure(request, String error) : super(request, error);
}

class GetNoticeLoadMoreSuccess extends GetNoticeSuccess {
  GetNoticeLoadMoreSuccess(request, NoticeResult result)
      : super(request, result);
}

class GetNoticeLoadMoreFailure extends GetNoticeFailure {
  GetNoticeLoadMoreFailure(request, String error) : super(request, error);
}

//--- Get my Ratelog messages
abstract class GetRatelogRequest extends GetMyDataRequest {
  GetRatelogRequest(Completer completer, int uid, int nexttime, int current)
      : super(completer, uid, 3, nexttime, current);
}

class GetRatelogSuccess extends GetMyDataSuccess with StopLoading {
  final RatelogResult result;

  GetRatelogSuccess(request, this.result) : super(request);
}

class GetRatelogFailure extends GetMyDataFailure {
  GetRatelogFailure(APIRequest request, String error) : super(request, error);
}

class GetRatelogNewRequest extends GetRatelogRequest {
  GetRatelogNewRequest(Completer completer, int uid, int nexttime, int current)
      : super(completer, uid, nexttime, current);

  @override
  CreateFailure get badResponse => (error) => GetRatelogNewFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetRatelogNewSuccess(this, result);
}

class GetRatelogRefreshRequest extends GetRatelogRequest {
  GetRatelogRefreshRequest(Completer completer, int uid, int current)
      : super(completer, uid, 0, current);

  @override
  CreateFailure get badResponse =>
      (error) => GetRatelogRefreshFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetRatelogRefreshSuccess(this, result);
}

class GetRatelogLoadMoreRequest extends GetRatelogRequest {
  GetRatelogLoadMoreRequest(Completer completer, int uid, int nexttime)
      : super(completer, uid, nexttime, 0);

  @override
  CreateFailure get badResponse =>
      (error) => GetRatelogLoadMoreFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetRatelogLoadMoreSuccess(this, result);
}

class GetRatelogNewSuccess extends GetRatelogSuccess {
  GetRatelogNewSuccess(request, RatelogResult result) : super(request, result);
}

class GetRatelogNewFailure extends GetRatelogFailure {
  GetRatelogNewFailure(request, String error) : super(request, error);
}

class GetRatelogRefreshSuccess extends GetRatelogSuccess with StopLoading {
  GetRatelogRefreshSuccess(request, RatelogResult result)
      : super(request, result);
}

class GetRatelogRefreshFailure extends GetRatelogFailure {
  GetRatelogRefreshFailure(request, String error) : super(request, error);
}

class GetRatelogLoadMoreSuccess extends GetRatelogSuccess {
  GetRatelogLoadMoreSuccess(request, RatelogResult result)
      : super(request, result);
}

class GetRatelogLoadMoreFailure extends GetRatelogFailure {
  GetRatelogLoadMoreFailure(request, String error) : super(request, error);
}

//--- Get my PM messages
abstract class GetPMRequest extends GetMyDataRequest {
  GetPMRequest(Completer completer, int uid, int nexttime, int current)
      : super(completer, uid, 4, nexttime, current);
}

class GetPMSuccess extends GetMyDataSuccess with StopLoading {
  final PrivateMessageResult result;

  GetPMSuccess(request, this.result) : super(request);
}

class GetPMFailure extends GetMyDataFailure {
  GetPMFailure(APIRequest request, String error) : super(request, error);
}

class GetPMNewRequest extends GetPMRequest {
  GetPMNewRequest(Completer completer, int uid, int nexttime, int current)
      : super(completer, uid, nexttime, current);

  @override
  CreateFailure get badResponse => (error) => GetPMNewFailure(this, error);

  @override
  CreateSuccess get goodResponse => (result) => GetPMNewSuccess(this, result);
}

class GetPMRefreshRequest extends GetPMRequest {
  GetPMRefreshRequest(Completer completer, int uid, int current)
      : super(completer, uid, 0, current);

  @override
  CreateFailure get badResponse => (error) => GetPMRefreshFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetPMRefreshSuccess(this, result);
}

class GetPMLoadMoreRequest extends GetPMRequest {
  GetPMLoadMoreRequest(Completer completer, int uid, int nexttime)
      : super(completer, uid, nexttime, 0);

  @override
  CreateFailure get badResponse => (error) => GetPMLoadMoreFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetPMLoadMoreSuccess(this, result);
}

class GetPMNewSuccess extends GetPMSuccess {
  GetPMNewSuccess(request, PrivateMessageResult result)
      : super(request, result);
}

class GetPMNewFailure extends GetPMFailure {
  GetPMNewFailure(request, String error) : super(request, error);
}

class GetPMRefreshSuccess extends GetPMSuccess with StopLoading {
  GetPMRefreshSuccess(request, PrivateMessageResult result)
      : super(request, result);
}

class GetPMRefreshFailure extends GetPMFailure {
  GetPMRefreshFailure(request, String error) : super(request, error);
}

class GetPMLoadMoreSuccess extends GetPMSuccess {
  GetPMLoadMoreSuccess(request, PrivateMessageResult result)
      : super(request, result);
}

class GetPMLoadMoreFailure extends GetPMFailure {
  GetPMLoadMoreFailure(request, String error) : super(request, error);
}
