import 'dart:async';

import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'package:meta/meta.dart';
import 'base_action.dart';
import 'api_action.dart';

abstract class GetMyDataRequest {
  int get uid;
  int get nexttime;
  int get current;
}

abstract class GetMyDataSuccess {
  APIRequest get request;
  dynamic get result;
}

abstract class GetMyDataFailure {
  APIRequest get request;
  String get error;
}

// --- Base classes for all get my data requests/responses
abstract class GetPersonalDataRequest extends APIRequest
    with GetMyDataRequest, StartLoading {
  final int uid;
  final int nexttime;
  final int current;
  final int mode;

  GetPersonalDataRequest(
      Completer completer, this.uid, this.mode, this.nexttime, this.current)
      : super(completer: completer, api: MYDATA_API, parameters: {
          "uid": uid,
          "mode": mode,
          "nexttime": nexttime,
          "current": current,
        });
}

abstract class GetPersonalDataSuccess extends APISuccess
    with StopLoading, GetMyDataSuccess {
  dynamic get result;
  GetPersonalDataSuccess(APIRequest request) : super(request);
}

abstract class GetPersonalDataFailure extends APIFailure
    with StopLoading, GetMyDataFailure {
  GetPersonalDataFailure(APIRequest request, String error)
      : super(request, error);
}

//---- Get my favorites
abstract class GetMyFavoritesRequest extends GetPersonalDataRequest {
  GetMyFavoritesRequest(Completer completer, int uid, int nexttime, int current)
      : super(completer, uid, 0, nexttime, current);
}

class GetMyFavoritesSuccess extends GetPersonalDataSuccess with StopLoading {
  final StoryListResult result;

  GetMyFavoritesSuccess(request, this.result) : super(request);
}

class GetMyFavoritesFailure extends GetPersonalDataFailure {
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
abstract class GetMyAtsRequest extends GetPersonalDataRequest {
  GetMyAtsRequest(Completer completer, int uid, int nexttime, int current)
      : super(completer, uid, 1, nexttime, current);
}

class GetMyAtsSuccess extends GetPersonalDataSuccess with StopLoading {
  final StoryListResult result;

  GetMyAtsSuccess(request, this.result) : super(request);
}

class GetMyAtsFailure extends GetPersonalDataFailure {
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
abstract class GetNoticeRequest extends GetPersonalDataRequest {
  GetNoticeRequest(Completer completer, int uid, int nexttime, int current)
      : super(completer, uid, 2, nexttime, current);
}

class GetNoticeSuccess extends GetPersonalDataSuccess with StopLoading {
  final NoticeResult result;

  GetNoticeSuccess(request, this.result) : super(request);
}

class GetNoticeFailure extends GetPersonalDataFailure {
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
abstract class GetRatelogRequest extends GetPersonalDataRequest {
  GetRatelogRequest(Completer completer, int uid, int nexttime, int current)
      : super(completer, uid, 3, nexttime, current);
}

class GetRatelogSuccess extends GetPersonalDataSuccess with StopLoading {
  final RatelogResult result;

  GetRatelogSuccess(request, this.result) : super(request);
}

class GetRatelogFailure extends GetPersonalDataFailure {
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
abstract class GetPMRequest extends GetPersonalDataRequest {
  GetPMRequest(Completer completer, int uid, int nexttime, int current)
      : super(completer, uid, 4, nexttime, current);
}

class GetPMSuccess extends GetPersonalDataSuccess with StopLoading {
  final PrivateMessageResult result;

  GetPMSuccess(request, this.result) : super(request);
}

class GetPMFailure extends GetPersonalDataFailure {
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

//--- Get my PMSession messages
abstract class GetPMSessionRequest extends APIRequest
    with StartLoading, GetMyDataRequest {
  final int uid;
  final int pmid;
  final int nexttime;
  final int current;

  GetPMSessionRequest(
      Completer completer, this.uid, this.pmid, this.nexttime, this.current)
      : super(completer: completer, api: PMSESSION_API, parameters: {
          "uid": uid,
          "pmid": pmid,
          "nexttime": nexttime,
          "current": current,
        });
}

abstract class GetPMSessionSuccess extends APISuccess
    with StopLoading, GetMyDataSuccess {
  final PMSession result;
  GetPMSessionSuccess(APIRequest request, this.result) : super(request);
}

abstract class GetPMSessionFailure extends APIFailure
    with StopLoading, GetMyDataFailure {
  GetPMSessionFailure(APIRequest request, String error) : super(request, error);
}

class GetPMSessionNewRequest extends GetPMSessionRequest {
  GetPMSessionNewRequest(
      Completer completer, int uid, int pmid, int nexttime, int current)
      : super(completer, uid, pmid, nexttime, current);

  @override
  CreateFailure get badResponse =>
      (error) => GetPMSessionNewFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetPMSessionNewSuccess(this, result);
}

class GetPMSessionRefreshRequest extends GetPMSessionRequest {
  GetPMSessionRefreshRequest(
      Completer completer, int uid, int pmid, int current)
      : super(completer, uid, pmid, 0, current);

  @override
  CreateFailure get badResponse =>
      (error) => GetPMSessionRefreshFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetPMSessionRefreshSuccess(this, result);
}

class GetPMSessionLoadMoreRequest extends GetPMSessionRequest {
  GetPMSessionLoadMoreRequest(
      Completer completer, int uid, int pmid, int nexttime)
      : super(completer, uid, pmid, nexttime, 0);

  @override
  CreateFailure get badResponse =>
      (error) => GetPMSessionLoadMoreFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => GetPMSessionLoadMoreSuccess(this, result);
}

class GetPMSessionNewSuccess extends GetPMSessionSuccess {
  GetPMSessionNewSuccess(request, PMSession result) : super(request, result);
}

class GetPMSessionNewFailure extends GetPMSessionFailure {
  GetPMSessionNewFailure(request, String error) : super(request, error);
}

class GetPMSessionRefreshSuccess extends GetPMSessionSuccess with StopLoading {
  GetPMSessionRefreshSuccess(request, PMSession result)
      : super(request, result);
}

class GetPMSessionRefreshFailure extends GetPMSessionFailure {
  GetPMSessionRefreshFailure(request, String error) : super(request, error);
}

class GetPMSessionLoadMoreSuccess extends GetPMSessionSuccess {
  GetPMSessionLoadMoreSuccess(request, PMSession result)
      : super(request, result);
}

class GetPMSessionLoadMoreFailure extends GetPMSessionFailure {
  GetPMSessionLoadMoreFailure(request, String error) : super(request, error);
}

class SendPMRequest extends APIRequest with StartLoading, GetMyDataRequest {
  final int uid;
  final int pmid;
  final String message;

  SendPMRequest(Completer completer, this.uid, this.pmid, this.message)
      : super(completer: completer, api: SENDPM_API, parameters: {
          "uid": uid,
          "pmid": pmid,
          "message": message,
        });

  @override
  CreateFailure get badResponse => (error) => SendPMFailure(this, error);

  @override
  CreateSuccess get goodResponse => (result) => SendPMSuccess(this, result);

  @override
  int get current => null;

  @override
  int get nexttime => null;
}

class SendPMSuccess extends APISuccess with StopLoading, GetMyDataSuccess {
  final Map result;
  SendPMSuccess(APIRequest request, this.result) : super(request);
}

class SendPMFailure extends APIFailure with StopLoading, GetMyDataFailure {
  SendPMFailure(APIRequest request, String error) : super(request, error);
}
