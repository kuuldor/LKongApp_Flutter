import 'package:flutter/material.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/ui/compose_screen.dart';
import 'package:lkongapp/ui/forum_story.dart';
import 'package:lkongapp/ui/screens.dart';
import 'package:lkongapp/utils/utils.dart';

Future<Null> onStoryTap(BuildContext context, Story story,
    {bool favorite: false}) {
  int storyId;
  int postId;
  if (story.tid == null) {
    storyId = parseLKTypeId(story.id, type: "thread");
  } else {
    storyId = parseLKTypeId(story.tid);
    postId = parseLKTypeId(story.id, type: "post");
  }
  return Future(() {
    openThreadView(context, storyId, postId: postId, favorite: favorite);
  });
}

void openThreadView(BuildContext context, int storyId,
    {int postId, int page: 1, bool favorite: false}) {
  if (storyId != null) {
    dispatchAction(context)(StoryInfoRequest(null, storyId));
  }
  dispatchAction(context)(
      UINavigationPush(context, LKongAppRoutes.story, builder: (context) {
    return StoryScreen(
      storyId: storyId,
      page: page,
      postId: postId,
      favorite: favorite,
    );
  }));
}

Future<Null> onForumTap(BuildContext context, Forum forum) {
  if (forum.name == null) {
    dispatchAction(context)(ForumInfoRequest(null, forum.fid));
  }
  dispatchAction(context)(ForumStoryNewRequest(null, forum.fid, 0, 0, 0));

  return Future(() {
    dispatchAction(context)(UINavigationPush(context, LKongAppRoutes.forumStory,
        builder: (context) {
      return ForumStory(
        forum: forum,
      );
    }));
  });
}

Future<Null> onUserTap(BuildContext context, UserInfo user) {
  // dispatchAction(context)(UserInfoRequest(null, user.uid));

  return Future(() {
    dispatchAction(context)(
        UINavigationPush(context, LKongAppRoutes.profile, builder: (context) {
      return ProfileScreen(
        user: user,
      );
    }));
  });
}

Future<Null> onPMTap(BuildContext context, int pmid) {
  return Future(() {
    dispatchAction(context)(
        UINavigationPush(context, LKongAppRoutes.pmsession, builder: (context) {
      return PMSessionScreen(
        pmid: pmid,
      );
    }));
  });
}

Future<Null> openUserView(BuildContext context, String userName) {
  UserInfo user = UserInfo().rebuild((b) => b..username = userName);

  return Future(() {
    dispatchAction(context)(
        UINavigationPush(context, LKongAppRoutes.profile, builder: (context) {
      return ProfileScreen(
        user: user,
      );
    }));
  });
}

onReplyButtonTap(
  BuildContext context, {
  Comment comment,
  @required StoryInfoResult story,
  @required int uid,
  @required String username,
}) =>
    Future(() => dispatchAction(context)(
            UINavigationPush(context, LKongAppRoutes.reply, builder: (context) {
          ReplyType replyType;
          if (story != null) {
            if (comment != null) {
              replyType = ReplyType.Comment;
            } else {
              replyType = ReplyType.Story;
            }
          } else {
            assert(false, "Must Specify story");
          }
          return ComposeScreen(
            comment: comment,
            story: story,
            replyType: replyType,
            uid: uid,
            username: username,
          );
        })));

onEditButtonTap(
  BuildContext context, {
  Comment comment,
  @required StoryInfoResult story,
  @required int uid,
  @required String username,
}) =>
    Future(() => dispatchAction(context)(
            UINavigationPush(context, LKongAppRoutes.reply, builder: (context) {
          ReplyType replyType;
          if (story != null && comment != null) {
            if (comment.lou == 1) {
              replyType = ReplyType.EditStory;
            } else {
              replyType = ReplyType.EditComment;
            }
          } else {
            assert(false, "Must Specify story");
          }
          return ComposeScreen(
            comment: comment,
            story: story,
            replyType: replyType,
            uid: uid,
            username: username,
          );
        })));

onPostButtonTap(
  BuildContext context, {
  @required Forum forum,
  @required int uid,
  @required String username,
}) =>
    Future(() => dispatchAction(context)(
            UINavigationPush(context, LKongAppRoutes.post, builder: (context) {
          ReplyType replyType;
          if (forum != null) {
            replyType = ReplyType.Forum;
          } else {
            assert(false, "Must Specify forum to post to");
          }
          return ComposeScreen(
            forum: forum,
            replyType: replyType,
            uid: uid,
            username: username,
          );
        })));
