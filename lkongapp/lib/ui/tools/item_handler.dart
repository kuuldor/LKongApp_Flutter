import 'package:flutter/material.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/ui/forum_story.dart';
import 'package:lkongapp/ui/profile_screen.dart';
import 'package:lkongapp/ui/story_screen.dart';
import 'package:lkongapp/utils/utils.dart';

final Future<Null> Function(BuildContext context, Story story) onStoryTap =
    (BuildContext context, Story story) {
  return Future(() {
    String storyId = story.tid;
    String postId = "0";
    if (storyId == null) {
      storyId = parseLKTypeId(story.id);
    } else {
      postId = parseLKTypeId(story.id);
    }
    dispatchAction(context)(StoryInfoRequest(null, int.parse(storyId)));
    dispatchAction(context)(
        UINavigationPush(context, LKongAppRoutes.story, false, (context) {
      return StoryScreen(
        storyId: int.parse(storyId),
        postId: int.parse(postId),
      );
    }));
  });
};

final Future<Null> Function(BuildContext, Forum) onForumTap =
    (BuildContext context, Forum forum) {
  dispatchAction(context)(ForumStoryNewRequest(null, forum.fid, 0, 0, 0));

  return Future(() {
    dispatchAction(context)(
        UINavigationPush(context, LKongAppRoutes.forumStory, false, (context) {
      return ForumStory(
        forum: forum,
      );
    }));
  });
};

final Future<Null> Function(BuildContext, UserInfo) onUserTap =
    (BuildContext context, UserInfo user) {
  // dispatchAction(context)(UserInfoRequest(null, u));

  return Future(() {
    dispatchAction(context)(
        UINavigationPush(context, LKongAppRoutes.profile, false, (context) {
      return ProfileScreen(
        user: user,
      );
    }));
  });
};
