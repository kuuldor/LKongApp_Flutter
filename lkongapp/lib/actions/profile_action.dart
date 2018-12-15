import 'dart:async';

import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'base_action.dart';
import 'api_action.dart';

abstract class ProfileRequest extends APIRequest with StartLoading {
  final int fetchType;
  final int uid;
  final int nexttime;

  ProfileRequest(
      Completer completer, this.uid, this.fetchType, this.nexttime)
      : super(completer: completer, api: USER_PROFILE_API, parameters: {
          "nexttime": nexttime,
          "uid": uid,
          "type": fetchType
        });
}

class ProfileNewRequest extends ProfileRequest {
  ProfileNewRequest(Completer completer, int uid, int searchType)
      : super(completer, uid, searchType, 0);

  @override
  CreateFailure get badResponse => (error) => ProfileNewFailure(this, error);

  @override
  CreateSuccess get goodResponse => (result) => ProfileNewSuccess(this, result);
}

class ProfileLoadMoreRequest extends ProfileRequest {
  final int fetchType;
  final int uid;
  final int nexttime;

  ProfileLoadMoreRequest(
      Completer completer, this.uid, this.fetchType, this.nexttime)
      : super(completer, uid, fetchType, nexttime);

  @override
  CreateFailure get badResponse =>
      (error) => ProfileLoadMoreFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => ProfileLoadMoreSuccess(this, result);
}

class ProfileSuccess extends APISuccess with StopLoading {
  final result;

  ProfileSuccess(request, this.result) : super(request);
}

class ProfileFailure extends APIFailure with StopLoading {
  ProfileFailure(request, String error) : super(request, error);
}

class ProfileNewSuccess extends ProfileSuccess {
  ProfileNewSuccess(request, result) : super(request, result);
}

class ProfileNewFailure extends ProfileFailure {
  ProfileNewFailure(request, String error) : super(request, error);
}

class ProfileLoadMoreSuccess extends ProfileSuccess {
  ProfileLoadMoreSuccess(request, result) : super(request, result);
}

class ProfileLoadMoreFailure extends ProfileFailure {
  ProfileLoadMoreFailure(request, String error) : super(request, error);
}
