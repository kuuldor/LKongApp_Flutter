import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/items/story_item.dart';
import 'package:lkongapp/ui/story_screen.dart';
import 'package:lkongapp/ui/tools/drawer_button.dart';
import 'package:lkongapp/ui/tools/icon_message.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/ui/connected_widget.dart';

import 'story_list.dart';

class AtMeScreen extends StatefulWidget {
  const AtMeScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AtMeScreenState();
  }
}

class AtMeScreenState extends StoryListState<AtMeScreen> {
  AtMeScreenState();
  @override
  Widget build(BuildContext context) {
    return buildWidgetWithVMFactory(
        context, AtMeScreenModel.fromStateAndStore(this));
  }
}

class AtMeScreenModel extends StoryListModel {
  final StoryFetchList storyList;
  final bool loading;
  final String lastError;
  final int uid;

  AtMeScreenModel({
    @required this.loading,
    @required this.lastError,
    @required this.storyList,
    @required this.uid,
  });

  @override
  SliverAppBar buildAppBar(BuildContext _) => SliverAppBar(
        leading: DrawerButton(),
        title: Text('通知'),
        floating: false,
        pinned: true,
      );

  static final fromStateAndStore =
      (AtMeScreenState state) => (Store<AppState> store) => AtMeScreenModel(
            loading: store.state.uiState.content.userData[selectUID(store)]
                ?.atMe?.loading,
            lastError: store.state.uiState.content.userData[selectUID(store)]
                ?.atMe?.lastError,
            storyList:
                store.state.uiState.content.userData[selectUID(store)]?.atMe,
            uid: selectUID(store),
          );

  @override
  APIRequest get fetchFromScratchRequest {
    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {});
    return GetMyAtsNewRequest(completer, uid, 0, 0);
  }

  @override
  APIRequest get loadMoreRequest {
    if (storyList == null || storyList.nexttime == 0) {
      return null;
    }

    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {});
    return GetMyAtsLoadMoreRequest(completer, uid, storyList.nexttime);
  }

  @override
  APIRequest get refreshRequest {
    if (storyList.current == 0) {
      return null;
    }

    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {});
    return GetMyAtsRefreshRequest(completer, uid, storyList.current);
  }

  @override
  APIRequest get checkNewRequest => null;

  @override
  Widget buildStoryListView(BuildContext context, StoryListState aState) {
    var state = aState as AtMeScreenState;
    if (uid == -1) {
      return super.buildGroupedListView(context);
    }
    return super.buildStoryListView(context, state);
  }
}
