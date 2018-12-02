import 'dart:async';

import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'package:meta/meta.dart';
import 'base_action.dart';
import 'api_action.dart';

class ForumListRequest extends APIRequest with StartLoading {
  ForumListRequest(Completer completer)
      : super(completer: completer, api: FORUMLIST_API, parameters: {});

  @override
  CreateFailure get badResponse => (error) => ForumListFailure(error);

  @override
  CreateSuccess get goodResponse =>
      (request, list) => ForumListSuccess(request, list);
}

class ForumListSuccess extends APISuccess with StopLoading {
  final ForumListResult list;

  ForumListSuccess(request, this.list) : super(request);
}

class ForumListFailure extends APIFailure with StopLoading {
  ForumListFailure(String error) : super(error);
}

class ForumInfoRequest extends APIRequest with StartLoading {
  final int forum;

  ForumInfoRequest(Completer completer, this.forum)
      : super(completer: completer, api: FORUM_INFO_API, parameters: {
          "id": forum,
        });

  @override
  CreateFailure get badResponse => (error) => ForumInfoFailure(error);

  @override
  CreateSuccess get goodResponse =>
      (request, info) => ForumInfoSuccess(request, info);
}

class ForumInfoSuccess extends APISuccess with StopLoading {
  final ForumInfoResult result;

  ForumInfoSuccess(request, this.result) : super(request);
}

class ForumInfoFailure extends APIFailure with StopLoading {
  ForumInfoFailure(String error) : super(error);
}

abstract class ForumStoryRequest extends APIRequest with StartLoading {
  final int forum;
  final int nexttime;
  final int current;
  final int mode;

  ForumStoryRequest(
      Completer completer, this.forum, this.mode, this.nexttime, this.current)
      : super(completer: completer, api: FORUM_THREADS_API, parameters: {
          "forumId": forum,
          "mode": mode,
          "nexttime": nexttime,
          "current": current,
        });
}

class ForumStoryNewRequest extends ForumStoryRequest {
  ForumStoryNewRequest(
      Completer completer, int forum, int mode, int nexttime, int current)
      : super(completer, forum, mode, nexttime, current);

  @override
  CreateFailure get badResponse => (error) => ForumStoryNewFailure(error);

  @override
  CreateSuccess get goodResponse =>
      (request, result) => ForumStoryNewSuccess(request, result);
}

class ForumStoryRefreshRequest extends ForumStoryRequest {
  ForumStoryRefreshRequest(
      Completer completer, int forum, int mode, int current)
      : super(completer, forum, mode, 0, current);

  @override
  CreateFailure get badResponse => (error) => ForumStoryRefreshFailure(error);

  @override
  CreateSuccess get goodResponse =>
      (request, result) => ForumStoryRefreshSuccess(request, result);
}

class ForumStoryLoadMoreRequest extends ForumStoryRequest {
  ForumStoryLoadMoreRequest(
      Completer completer, int forum, int mode, int nexttime)
      : super(completer, forum, mode, nexttime, 0);

  @override
  CreateFailure get badResponse => (error) => ForumStoryLoadMoreFailure(error);

  @override
  CreateSuccess get goodResponse =>
      (request, result) => ForumStoryLoadMoreSuccess(request, result);
}

class ForumStorySuccess extends APISuccess with StopLoading {
  final ForumStoryResult result;

  ForumStorySuccess(request, this.result) : super(request);
}

class ForumStoryFailure extends APIFailure with StopLoading {
  ForumStoryFailure(String error) : super(error);
}

class ForumStoryNewSuccess extends ForumStorySuccess {
  ForumStoryNewSuccess(request, ForumStoryResult result)
      : super(request, result);
}

class ForumStoryNewFailure extends ForumStoryFailure {
  ForumStoryNewFailure(String error) : super(error);
}

class ForumStoryRefreshSuccess extends ForumStorySuccess with StopLoading {
  ForumStoryRefreshSuccess(request, ForumStoryResult result)
      : super(request, result);
}

class ForumStoryRefreshFailure extends ForumStoryFailure {
  ForumStoryRefreshFailure(String error) : super(error);
}

class ForumStoryLoadMoreSuccess extends ForumStorySuccess {
  ForumStoryLoadMoreSuccess(request, ForumStoryResult result)
      : super(request, result);
}

class ForumStoryLoadMoreFailure extends ForumStoryFailure {
  ForumStoryLoadMoreFailure(String error) : super(error);
}

class ForumStoryCheckNewRequest extends APIRequest {
  final int forum;
  final int current;

  ForumStoryCheckNewRequest(Completer completer, this.forum, this.current)
      : super(completer: completer, api: FORUM_CHECKNEW_API, parameters: {
          "forumId": forum,
          "current": current,
        });

  @override
  CreateFailure get badResponse => (error) => ForumStoryCheckNewFailure(error);

  @override
  CreateSuccess get goodResponse =>
      (request, result) => ForumStoryCheckNewSuccess(request, result);
}

class ForumStoryCheckNewSuccess extends APISuccess {
  final int result;
  ForumStoryCheckNewSuccess(request, this.result) : super(request);
}

class ForumStoryCheckNewFailure extends APIFailure {
  ForumStoryCheckNewFailure(String error) : super(error);
}
