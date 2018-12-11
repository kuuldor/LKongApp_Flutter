import 'package:flutter/material.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
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
