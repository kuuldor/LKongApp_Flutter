import 'dart:async';

import 'package:meta/meta.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/middlewares/api.dart';

import 'base_action.dart';
import 'api_action.dart';

enum ReplyType {
  Forum,
  Story,
  Comment,
  EditStory,
  EditComment,
}

class ReplyRequest extends APIRequest with StartLoading {
  final Comment comment;
  final StoryInfoResult story;
  final Forum forum;
  final String subject;
  final String content;
  final String author;
  final int authorId;
  final String dateline;
  final ReplyType replyType;

  ReplyRequest(
    Completer completer, {
    @required this.author,
    @required this.authorId,
    @required this.dateline,
    this.comment,
    this.story,
    this.forum,
    @required this.replyType,
    this.subject,
    @required this.content,
  }) : super(completer: completer, api: REPLY_API, parameters: {
          "type": replyType,
          "comment": comment,
          "subject": subject,
          "content": content,
          "story": story,
          "forum": forum,
        });

  @override
  CreateFailure get badResponse => (error) => ReplyFailure(this, error);

  @override
  CreateSuccess get goodResponse => (list) => ReplySuccess(this, list);
}

class ReplySuccess extends APISuccess with StopLoading {
  final Map result;

  ReplySuccess(request, this.result) : super(request);
}

class ReplyFailure extends APIFailure with StopLoading {
  ReplyFailure(request, String error) : super(request, error);
}
