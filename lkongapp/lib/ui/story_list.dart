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

abstract class StoryListState<T extends StatefulWidget> extends State<T> {
  StoryListState({this.timerPeriod: 60});

  Widget buildWidgetWithVMFactory(BuildContext context, fromStore) {
    return buildConnectedWidget(context, fromStore, (StoryListModel viewModel) {
      return viewModel.buildStoryListView(context, this);
    });
  }

  final int timerPeriod;

  Timer checkNewTimer;
  Function checkNewCallback;

  @override
  void initState() {
    super.initState();
    createTimer();
  }

  void createTimer() {
    cancelTimer();
    checkNewTimer = Timer.periodic(Duration(seconds: timerPeriod), (timer) {
      if (checkNewCallback != null) {
        checkNewCallback();
      }
    });
  }

  void cancelTimer() {
    if (checkNewTimer != null) {
      checkNewTimer.cancel();
      checkNewTimer = null;
    }
  }

  @override
  void dispose() {
    print("State $this disposed");
    super.dispose();
    cancelTimer();
  }

  void setCheckNewCallback(Function callback) {
    checkNewCallback = callback;
  }

  @override
  bool operator ==(other) {
    return other is StoryListState;
  }

  @override
  int get hashCode => 0;
}

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

  @override
  int get itemCount => storyList?.stories?.length;

  Future<Null> handleCheckNew(BuildContext context) async {
    var request = checkNewRequest;

    if (request != null) {
      dispatchAction(context)(request);
    }
  }

  @mustCallSuper
  @override
  void listIsReady(BuildContext context) {}

  @override
  Widget createListItem(BuildContext context, int index) {
    Story story = storyList.stories[index];

    var item = StoryItem(
      story: story,
      onTap: () => onStoryTap(context, story),
    );

    return item;
  }

  Widget buildStoryListView(BuildContext context, StoryListState state) {
    if (itemCount != null && itemCount > 0) {
      state.setCheckNewCallback(() {
        handleCheckNew(context);
      });
    }
    return buildListView(context);
  }
}
