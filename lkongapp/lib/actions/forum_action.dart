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
  CreateSuccess get goodResponse => (list) => ForumListSuccess(list);
}

class ForumListSuccess extends APISuccess with StopLoading {
  final ForumListResult list;

  ForumListSuccess(this.list);
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
  CreateSuccess get goodResponse => (info) => ForumInfoSuccess(info);
}

class ForumInfoSuccess extends APISuccess with StopLoading {
  final ForumInfoResult result;

  ForumInfoSuccess(this.result);
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
  CreateSuccess get goodResponse => (result) => ForumStoryNewSuccess(result);
}

class ForumStoryRefreshRequest extends ForumStoryRequest {

  ForumStoryRefreshRequest(Completer completer, int forum, int mode, int current)
      : super(completer, forum, mode, 0, current);

  @override
  CreateFailure get badResponse => (error) => ForumStoryRefreshFailure(error);

  @override
  CreateSuccess get goodResponse => (result) => ForumStoryRefreshSuccess(result);
}

class ForumStoryLoadMoreRequest extends ForumStoryRequest {
  ForumStoryLoadMoreRequest(Completer completer, int forum, int mode,  int nexttime)
      : super(completer, forum, mode, nexttime, 0);

  @override
  CreateFailure get badResponse => (error) => ForumStoryLoadMoreFailure(error);

  @override
  CreateSuccess get goodResponse => (result) => ForumStoryLoadMoreSuccess(result);
}

class ForumStorySuccess extends APISuccess with StopLoading {
  final ForumStoryResult result;

  ForumStorySuccess(this.result);
}

class ForumStoryFailure extends APIFailure with StopLoading {
  ForumStoryFailure(String error) : super(error);
}

class ForumStoryNewSuccess extends ForumStorySuccess {
  ForumStoryNewSuccess(ForumStoryResult result) : super(result);
}

class ForumStoryNewFailure extends ForumStoryFailure {
  ForumStoryNewFailure(String error) : super(error);
}

class ForumStoryRefreshSuccess extends ForumStorySuccess with StopLoading {
  ForumStoryRefreshSuccess(ForumStoryResult result) : super(result);
}

class ForumStoryRefreshFailure extends ForumStoryFailure {
  ForumStoryRefreshFailure(String error) : super(error);
}

class ForumStoryLoadMoreSuccess extends ForumStorySuccess {
  ForumStoryLoadMoreSuccess(ForumStoryResult result) : super(result);
}

class ForumStoryLoadMoreFailure extends ForumStoryFailure {
  ForumStoryLoadMoreFailure(String error) : super(error);
}
