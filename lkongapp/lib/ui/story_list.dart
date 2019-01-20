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
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/ui/tools/item_handler.dart';
import 'package:lkongapp/ui/connected_widget.dart';

abstract class StoryListState<T extends StatefulWidget> extends State<T> {
  final int timerPeriod;

  @override
  bool operator ==(other) {
    return other is StoryListState && timerPeriod == other.timerPeriod;
  }

  @override
  int get hashCode => timerPeriod.hashCode;

  Timer checkNewTimer;
  Function checkNewCallback;

  StoryListState({this.timerPeriod: 60});

  Widget buildWidgetWithVMFactory(BuildContext context, fromStore) {
    return buildConnectedWidget(context, fromStore, (StoryListModel viewModel) {
      return viewModel.buildStoryListView(context, this);
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
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
    super.dispose();
    cancelTimer();
  }

  void setCheckNewCallback(Function callback) {
    checkNewCallback = callback;
  }
}

abstract class StoryListModel extends FetchedListModel {
  StoryListModel(Store<AppState> store) {
    if (store != null) {
      if (store.state.persistState.appConfig.setting.hideBlacklisterPost) {
        blackList = selectUserData(store)?.followList?.black?.toList();
      }
    }
  }

  APIRequest get checkNewRequest;

  FetchList<Story> get storyList;

  List<String> blackList;

  List<Story> _stories;
  List<Story> get stories {
    if (_stories == null) {
      if (storyList?.data != null) {
        _stories = storyList.data.toList();
        if (blackList != null) {
          _stories = _stories
              .where((story) => !blackList.contains("${story.uid}"))
              .toList();
        }
      }
    }
    return _stories;
  }

  bool get showDetailTime;

  @override
  int get itemCount => stories?.length ?? 0;

  Future<Null> handleCheckNew(BuildContext context) async {
    var request = checkNewRequest;

    if (request != null) {
      dispatchAction(context)(request);
    }
  }

  @mustCallSuper
  @override
  void listIsReady(BuildContext context) {
    if (startTimer != null) {
      startTimer();
    }
  }

  Function startTimer;

  @override
  bool get initLoaded =>
      storyList != null &&
      (storyList.current != 0 || storyList.data.length > 0);

  @override
  Widget createListItem(BuildContext context, int index) {
    Story story = stories[index];

    var item = StoryItem(
      story: story,
      onTap: () => onStoryTap(context, story),
      showDetailTime: showDetailTime,
    );

    return item;
  }

  Widget buildStoryListView(BuildContext context, StoryListState state) {
    // if (itemCount > 0) {
    //   if (startTimer == null) {
    //     startTimer = () {
    //       state.startTimer();
    //     };
    //   }
    //   state.setCheckNewCallback(() {
    //     handleCheckNew(context);
    //   });
    // }
    return buildListView(context);
  }

  @override
  Widget headerForSection(BuildContext context, {int section}) {
    int newCount = storyList?.newcount ?? 0;
    String error = storyList?.lastError;
    if (error != null && error != "") {
      return Container(
          color: Colors.red[500],
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "错误：$error。请稍后重试",
            style: const TextStyle(color: Colors.white),
          ));
    } else if (newCount > 0) {
      return GestureDetector(
          onTap: () {
            scrollController.jumpTo(0.0);
            handleRefresh(context);
          },
          child: Container(
              color: Colors.blue[500],
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                "$newCount条新信息",
                style: const TextStyle(color: Colors.white),
              )));
    }
    return null;
  }
}
