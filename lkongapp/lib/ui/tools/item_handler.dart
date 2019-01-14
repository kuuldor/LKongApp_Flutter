import 'package:flutter/material.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/ui/compose_screen.dart';
import 'package:lkongapp/ui/forum_story.dart';
import 'package:lkongapp/ui/profile_screen.dart';
import 'package:lkongapp/ui/story_screen.dart';
import 'package:lkongapp/utils/utils.dart';

Future<Null> onStoryTap(BuildContext context, Story story) {
  int storyId;
  int postId;
  if (story.tid == null) {
    storyId = parseLKTypeId(story.id, type: "thread");
  } else {
    storyId = parseLKTypeId(story.tid);
    postId = parseLKTypeId(story.id, type: "post");
  }
  return Future(() {
    openThreadView(context, storyId, postId);
  });
}

void openThreadView(BuildContext context, int storyId, [int postId]) {
  if (storyId != null) {
    dispatchAction(context)(StoryInfoRequest(null, storyId));
  }
  dispatchAction(context)(
      UINavigationPush(context, LKongAppRoutes.story, false, (context) {
    return StoryScreen(
      storyId: storyId,
      postId: postId,
    );
  }));
}

Future<Null> onForumTap(BuildContext context, Forum forum) {
  dispatchAction(context)(ForumStoryNewRequest(null, forum.fid, 0, 0, 0));

  return Future(() {
    dispatchAction(context)(
        UINavigationPush(context, LKongAppRoutes.forumStory, false, (context) {
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
        UINavigationPush(context, LKongAppRoutes.profile, false, (context) {
      return ProfileScreen(
        user: user,
      );
    }));
  });
}

Future<Null> openUserView(BuildContext context, String userName) {
  UserInfo user = UserInfo().rebuild((b) => b..username = userName);

  return Future(() {
    dispatchAction(context)(
        UINavigationPush(context, LKongAppRoutes.profile, false, (context) {
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
            UINavigationPush(context, LKongAppRoutes.reply, false, (context) {
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
            UINavigationPush(context, LKongAppRoutes.reply, false, (context) {
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
            UINavigationPush(context, LKongAppRoutes.post, false, (context) {
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
