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
  CreateFailure get badResponse => (error) => ForumListFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (list) => ForumListSuccess(this, list);
}

class ForumListSuccess extends APISuccess with StopLoading {
  final ForumListResult list;

  ForumListSuccess(request, this.list) : super(request);
}

class ForumListFailure extends APIFailure with StopLoading {
  ForumListFailure(request, String error) : super(request, error);
}

class ForumInfoRequest extends APIRequest with StartLoading {
  final int forum;

  ForumInfoRequest(Completer completer, this.forum)
      : super(completer: completer, api: FORUM_INFO_API, parameters: {
          "id": forum,
        });

  @override
  CreateFailure get badResponse => (error) => ForumInfoFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (info) => ForumInfoSuccess(this, info);
}

class ForumInfoSuccess extends APISuccess with StopLoading {
  final ForumInfoResult result;

  ForumInfoSuccess(request, this.result) : super(request);
}

class ForumInfoFailure extends APIFailure with StopLoading {
  ForumInfoFailure(request, String error) : super(request, error);
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
  CreateFailure get badResponse => (error) => ForumStoryNewFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => ForumStoryNewSuccess(this, result);
}

class ForumStoryRefreshRequest extends ForumStoryRequest {
  ForumStoryRefreshRequest(
      Completer completer, int forum, int mode, int current)
      : super(completer, forum, mode, 0, current);

  @override
  CreateFailure get badResponse => (error) => ForumStoryRefreshFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => ForumStoryRefreshSuccess(this, result);
}

class ForumStoryLoadMoreRequest extends ForumStoryRequest {
  ForumStoryLoadMoreRequest(
      Completer completer, int forum, int mode, int nexttime)
      : super(completer, forum, mode, nexttime, 0);

  @override
  CreateFailure get badResponse => (error) => ForumStoryLoadMoreFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => ForumStoryLoadMoreSuccess(this, result);
}

class ForumStorySuccess extends APISuccess with StopLoading {
  final StoryListResult result;

  ForumStorySuccess(request, this.result) : super(request);
}

class ForumStoryFailure extends APIFailure with StopLoading {
  ForumStoryFailure(request, String error) : super(request, error);
}

class ForumStoryNewSuccess extends ForumStorySuccess {
  ForumStoryNewSuccess(request, StoryListResult result)
      : super(request, result);
}

class ForumStoryNewFailure extends ForumStoryFailure {
  ForumStoryNewFailure(request, String error) : super(request, error);
}

class ForumStoryRefreshSuccess extends ForumStorySuccess with StopLoading {
  ForumStoryRefreshSuccess(request, StoryListResult result)
      : super(request, result);
}

class ForumStoryRefreshFailure extends ForumStoryFailure {
  ForumStoryRefreshFailure(request, String error) : super(request, error);
}

class ForumStoryLoadMoreSuccess extends ForumStorySuccess {
  ForumStoryLoadMoreSuccess(request, StoryListResult result)
      : super(request, result);
}

class ForumStoryLoadMoreFailure extends ForumStoryFailure {
  ForumStoryLoadMoreFailure(request, String error) : super(request, error);
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
  CreateFailure get badResponse => (error) => ForumStoryCheckNewFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => ForumStoryCheckNewSuccess(this, result);
}

class ForumStoryCheckNewSuccess extends APISuccess {
  final int result;
  ForumStoryCheckNewSuccess(request, this.result) : super(request);
}

class ForumStoryCheckNewFailure extends APIFailure {
  ForumStoryCheckNewFailure(request, String error) : super(request, error);
}
