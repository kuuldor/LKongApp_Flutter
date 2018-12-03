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
  HomeListNewRequest(
      Completer completer, bool threadOnly, int nexttime, int current)
      : super(completer, threadOnly, nexttime, current);

  @override
  CreateFailure get badResponse => (error) => HomeListNewFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (list) => HomeListNewSuccess(this, list);
}

class HomeListRefreshRequest extends HomeListRequest {
  final bool threadOnly;
  final int current;

  HomeListRefreshRequest(Completer completer, this.threadOnly, this.current)
      : super(completer, threadOnly, 0, current);

  @override
  CreateFailure get badResponse => (error) => HomeListRefreshFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (list) => HomeListRefreshSuccess(this, list);
}

class HomeListLoadMoreRequest extends HomeListRequest {
  final bool threadOnly;
  final int nexttime;

  HomeListLoadMoreRequest(Completer completer, this.threadOnly, this.nexttime)
      : super(completer, threadOnly, nexttime, 0);

  @override
  CreateFailure get badResponse => (error) => HomeListLoadMoreFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (list) => HomeListLoadMoreSuccess(this, list);
}

class HomeListSuccess extends APISuccess with StopLoading {
  final HomeListResult list;

  HomeListSuccess(request, this.list) : super(request);
}

class HomeListFailure extends APIFailure with StopLoading {
  HomeListFailure(request, String error) : super(request, error);
}

class HomeListNewSuccess extends HomeListSuccess {
  HomeListNewSuccess(request, HomeListResult list) : super(request, list);
}

class HomeListNewFailure extends HomeListFailure {
  HomeListNewFailure(request, String error) : super(request, error);
}

class HomeListRefreshSuccess extends HomeListSuccess with StopLoading {
  HomeListRefreshSuccess(request, HomeListResult list) : super(request, list);
}

class HomeListRefreshFailure extends HomeListFailure {
  HomeListRefreshFailure(request, String error) : super(request, error);
}

class HomeListLoadMoreSuccess extends HomeListSuccess {
  HomeListLoadMoreSuccess(request, HomeListResult list) : super(request, list);
}

class HomeListLoadMoreFailure extends HomeListFailure {
  HomeListLoadMoreFailure(request, String error) : super(request, error);
}

class HomeListCheckNewRequest extends APIRequest {
  final int current;

  HomeListCheckNewRequest(Completer completer, this.current)
      : super(completer: completer, api: FORUM_CHECKNEW_API, parameters: {
          "current": current,
        });

  @override
  CreateFailure get badResponse => (error) => HomeListCheckNewFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (result) => HomeListCheckNewSuccess(this, result);
}

class HomeListCheckNewSuccess extends APISuccess {
  final int result;
  HomeListCheckNewSuccess(request, this.result) : super(request);
}

class HomeListCheckNewFailure extends APIFailure {
  HomeListCheckNewFailure(request, String error) : super(request, error);
}

class StoryContentRequest extends APIRequest with StartLoading {
  final int story;
  final int page;

  StoryContentRequest(Completer completer, this.story, this.page)
      : super(completer: completer, api: STORY_CONTENT_API, parameters: {
          "story": story,
          "page": page,
        });

  @override
  CreateFailure get badResponse => (error) => StoryContentFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (list) => StoryContentSuccess(this, list);
}

class StoryContentSuccess extends APISuccess with StopLoading {
  final StoryContentResult result;

  StoryContentSuccess(request, this.result) : super(request);
}

class StoryContentFailure extends APIFailure with StopLoading {
  StoryContentFailure(request, String error) : super(request, error);
}

class StoryInfoRequest extends APIRequest with StartLoading {
  final int story;

  StoryInfoRequest(Completer completer, this.story)
      : super(completer: completer, api: STORY_INFO_API, parameters: {
          "story": story,
        });

  @override
  CreateFailure get badResponse => (error) => StoryInfoFailure(this, error);

  @override
  CreateSuccess get goodResponse =>
      (list) => StoryInfoSuccess(this, list);
}

class StoryInfoSuccess extends APISuccess with StopLoading {
  final StoryInfoResult result;

  StoryInfoSuccess(request, this.result) : super(request);
}

class StoryInfoFailure extends APIFailure with StopLoading {
  StoryInfoFailure(request, String error) : super(request, error);
}
