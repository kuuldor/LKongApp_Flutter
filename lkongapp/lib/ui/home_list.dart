import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/items/story_item.dart';
import 'package:lkongapp/ui/story_screen.dart';
import 'package:lkongapp/ui/tools/icon_message.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

import 'package:lkongapp/ui/connected_widget.dart';

import 'story_list.dart';

class HomeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeListState();
  }
}

class HomeListState extends StoryListState<HomeList> {
  @override
  Widget build(BuildContext context) {
    return buildWidgetWithVMFactory(context, HomeListModel.fromStore);
  }
}

class HomeListModel extends StoryListModel {
  final bool threadOnlyHome;
  final StoryFetchList storyList;
  final bool loading;
  final String lastError;

  HomeListModel({
    @required this.loading,
    @required this.lastError,
    @required this.storyList,
    @required this.threadOnlyHome,
  });

  static HomeListModel fromStore(Store<AppState> store) {
    return HomeListModel(
      loading: store.state.uiState.content.homeList.loading,
      lastError: store.state.uiState.content.homeList.lastError,
      storyList: store.state.uiState.content.homeList,
      threadOnlyHome: store.state.persistState.appConfig.accountSettings
          .currentSetting.threadOnlyHome,
    );
  }

  @override
  APIRequest get fetchFromScratchRequest {
    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {
      // showToast(context, success ? 'Loading Succeed' : 'Loading Failed');
    });
    return HomeListNewRequest(completer, threadOnlyHome, 0, 0);
  }

  @override
  APIRequest get loadMoreRequest {
    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {
      // showToast(context, success ? 'Loading Succeed' : 'Loading Failed');
    });
    return HomeListLoadMoreRequest(
        completer, threadOnlyHome, storyList.nexttime);
  }

  @override
  APIRequest get refreshRequest {
    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {
      // showToast(context, success ? 'Refresh Succeed' : 'Refresh Failed');
    });
    return HomeListRefreshRequest(completer, threadOnlyHome, storyList.current);
  }

  @override
  APIRequest get checkNewRequest =>
      HomeListCheckNewRequest(null, storyList.current);
}
