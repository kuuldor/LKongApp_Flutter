import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/fetched_list.dart';
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

enum AtMeScreenType {
  atMe,
  notif,
  rate,
  message,
}

class AtMeScreenState extends StoryListState<AtMeScreen> {
  AtMeScreenType type;
  AtMeScreenState({this.type: AtMeScreenType.atMe});

  void changeScreenType(AtMeScreenType newType) {
    setState(() {
      type = newType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget(
        context, NotifScreenModel.fromStateAndStore(this), (viewModel) {
      return viewModel.buildNotifView(context);
    });
  }
}

abstract class NotifScreenModel {
  SliverAppBar buildAppBar(BuildContext _) => SliverAppBar(
        leading: DrawerButton(),
        title: Text('通知'),
        floating: false,
        pinned: true,
      );

  static NotifScreenModel createViewModel(
      AtMeScreenState state, Store<AppState> store) {
    NotifScreenModel ret;
    switch (state.type) {
      case AtMeScreenType.atMe:
        ret = AtMeScreenModel.fromStore(store);
        break;
      default:
        break;
    }
    return ret;
  }

  static final fromStateAndStore = (AtMeScreenState state) =>
      (Store<AppState> store) => createViewModel(state, store);

  Widget buildNotifView(BuildContext context);
}

class AtMeScreenModel extends StoryListModel with NotifScreenModel {
  final StoryFetchList storyList;
  final bool loading;
  final String lastError;
  final int uid;

  AtMeScreenModel({
    @required Store<AppState> store,
    @required this.loading,
    @required this.lastError,
    @required this.storyList,
    @required this.uid,
  }) : super(store);

  @override
  SliverAppBar buildAppBar(BuildContext context) => super.buildAppBar(context);

  static final fromStore = (Store<AppState> store) => AtMeScreenModel(
        store: store,
        loading: store
            .state.uiState.content.userData[selectUID(store)]?.atMe?.loading,
        lastError: store
            .state.uiState.content.userData[selectUID(store)]?.atMe?.lastError,
        storyList: store.state.uiState.content.userData[selectUID(store)]?.atMe,
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
    if (storyList == null || storyList.current == 0) {
      return null;
    }

    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {});
    return GetMyAtsRefreshRequest(completer, uid, storyList.current);
  }

  @override
  APIRequest get checkNewRequest => null;

  @override
  Widget buildListView(BuildContext context) {
    if (uid == -1) {
      return super.buildGroupedListView(context);
    }
    return super.buildListView(context);
  }

  @override
  Widget buildNotifView(BuildContext context) {
    return buildListView(context);
  }
}
