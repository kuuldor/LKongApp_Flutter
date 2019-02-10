import 'dart:async';

import 'package:meta/meta.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/middlewares/api.dart';

import 'base_action.dart';
import 'api_action.dart';

enum FollowType {
  forum,
  story,
  user,
  black,
}

class FollowRequest extends APIRequest with StartLoading {
  final int id;
  final FollowType replyType;
  final bool unfollow;
  final String name;

  static final typeName = {
    FollowType.user: "uid",
    FollowType.forum: "fid",
    FollowType.story: "tid",
    FollowType.black: "black",
  };

  FollowRequest(
    Completer completer, {
    @required this.id,
    @required this.replyType,
    @required this.unfollow,
    this.name,
  }) : super(completer: completer, api: FOLLOW_API, parameters: {
          "type": typeName[replyType],
          "id": id,
          "unfollow": unfollow,
        });

  @override
  CreateFailure get badResponse => (error) => FollowFailure(this, error);

  @override
  CreateSuccess get goodResponse => (list) => FollowSuccess(this, list);
}

class FollowSuccess extends APISuccess with StopLoading {
  final Map result;

  FollowSuccess(request, this.result) : super(request);
}

class FollowFailure extends APIFailure with StopLoading {
  FollowFailure(request, String error) : super(request, error);
}

class UpvoteRequest extends APIRequest with StartLoading {
  final StoryInfoResult story;
  final Comment voted;
  final int coins;
  final String reason;

  UpvoteRequest(
    Completer completer, {
    @required this.story,
    @required this.voted,
    @required this.coins,
    @required this.reason,
  }) : super(completer: completer, api: UPVOTE_API, parameters: {
          "id": voted.id,
          "coins": coins,
          "reason": reason,
        });

  @override
  CreateFailure get badResponse => (error) => UpvoteFailure(this, error);

  @override
  CreateSuccess get goodResponse => (result) => UpvoteSuccess(this, result);
}

class UpvoteSuccess extends APISuccess with StopLoading {
  final UpvoteResult result;

  UpvoteSuccess(request, this.result) : super(request);
}

class UpvoteFailure extends APIFailure with StopLoading {
  UpvoteFailure(request, String error) : super(request, error);
}
