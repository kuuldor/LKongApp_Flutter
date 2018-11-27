import 'dart:async';

import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/middlewares/api.dart';
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
