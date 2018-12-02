import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/fetched_list.dart';
import 'package:lkongapp/ui/items/story_item.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/story_screen.dart';
import 'package:lkongapp/ui/tools/icon_message.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:redux/redux.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

import 'package:lkongapp/ui/connected_widget.dart';

abstract class StoryListModel extends FetchedListModel {
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
      dispatchAction(context)(
          UINavigationPush(context, LKongAppRoutes.story, false, (context) {
        return StoryScreen(
          storyId: int.parse(storyId),
          postId: int.parse(postId),
        );
      }));
    });
  };

  APIRequest get checkNewRequest;

  StoryFetchList get storyList;

  int get checkNewActionKey;

  @override
  int get itemCount => storyList?.stories?.length;

  @override
  void listIsReady(BuildContext context) {
    var request = checkNewRequest;

    if (request != null) {
      dispatchAction(context)(
        DelayedAction(
          key: checkNewActionKey,
          action: request,
          delayed: Duration(seconds: 60),
        ),
      );
    }
  }

  @override
  Widget createListItem(BuildContext context, int index) {
    Story story = storyList.stories[index];

    var item = StoryItem(
      story: story,
      onTap: () => onStoryTap(context, story),
    );

    return item;
  }
}
