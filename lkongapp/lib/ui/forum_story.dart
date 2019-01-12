import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/items/story_item.dart';
import 'package:lkongapp/ui/story_screen.dart';
import 'package:lkongapp/ui/tools/icon_message.dart';
import 'package:lkongapp/ui/tools/menu_choice.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/ui/tools/item_handler.dart';

import 'package:lkongapp/ui/connected_widget.dart';

import 'story_list.dart';

class ForumStory extends StatefulWidget {
  final Forum forum;

  const ForumStory({Key key, @required this.forum}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ForumStoryState(forum);
  }
}

class ForumStoryState extends StoryListState<ForumStory> {
  Forum forum;
  int mode;
  bool loaded;

  void setMode(int newMode) {
    setState(() {
      mode = newMode;
      loaded = false;
    });
  }

  @override
  bool operator ==(other) {
    return other is ForumStoryState &&
        forum == other.forum &&
        mode == other.mode;
  }

  @override
  int get hashCode => hash2(forum, mode);

  ForumStoryState(this.forum, {this.mode: 0, this.loaded: false});

  @override
  Widget build(BuildContext context) {
    final fromStore = ForumStoryModel.fromStateAndStore(this);
    return buildWidgetWithVMFactory(context, fromStore);
  }
}

class ForumStoryModel extends StoryListModel {
  final StoryFetchList storyList;
  final bool loading;
  final String lastError;
  final ForumStoryState state;
  final int uid;
  final String username;

  ForumStoryModel({
    @required this.uid,
    @required this.username,
    @required Store<AppState> store,
    @required this.loading,
    @required this.lastError,
    @required this.storyList,
    @required this.state,
  }) : super(store);

  @override
  bool operator ==(other) {
    return other is ForumStoryModel &&
        storyList == other.storyList &&
        loading == other.loading &&
        lastError == other.lastError &&
        state == other.state &&
        uid == other.uid &&
        username == other.username;
  }

  @override
  int get hashCode =>
      hashObjects([storyList, loading, lastError, state, uid, username]);

  static final fromStateAndStore =
      (ForumStoryState state) => (Store<AppState> store) => ForumStoryModel(
            store: store,
            username: selectUser(store).userInfo.username,
            uid: selectUID(store),
            loading:
                store.state.uiState.content.forumRepo[state.forum.fid].loading,
            lastError: store
                .state.uiState.content.forumRepo[state.forum.fid].lastError,
            storyList: store.state.uiState.content.forumRepo[state.forum.fid],
            state: state,
          );

  @override
  bool get initLoaded => super.initLoaded && state.loaded;

  @override
  APIRequest get fetchFromScratchRequest {
    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {
      // showToast(context, success ? 'Loading Succeed' : 'Loading Failed');
    });

    state.loaded = true;

    return ForumStoryNewRequest(completer, state.forum.fid, state.mode, 0, 0);
  }

  @override
  APIRequest get loadMoreRequest {
    if (storyList.nexttime == 0) {
      return null;
    }

    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {
      // showToast(context, success ? 'Loading Succeed' : 'Loading Failed');
    });
    return ForumStoryLoadMoreRequest(
        completer, state.forum.fid, state.mode, storyList.nexttime);
  }

  @override
  APIRequest get refreshRequest {
    if (storyList.current == 0) {
      return null;
    }

    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {
      // showToast(context, success ? 'Refresh Succeed' : 'Refresh Failed');
    });
    return ForumStoryRefreshRequest(
        completer, state.forum.fid, state.mode, storyList.current);
  }

  final allMenus = const <Choice>[
    const Choice(
        title: '全部显示', icon: Icons.visibility, action: MenuAction.showAll),
    const Choice(
        title: '精华', icon: Icons.visibility_off, action: MenuAction.digest),
    const Choice(
        title: '发布时间排序', icon: Icons.textsms, action: MenuAction.timeline),
  ];

  List<Choice> filterMenus() {
    var menus = List<Choice>.from(allMenus);
    menus.removeAt(state.mode);
    return menus;
  }

  void _menuSelected(BuildContext context, Choice choice) {
    switch (choice.action) {
      case MenuAction.showAll:
        state.setMode(0);
        break;
      case MenuAction.digest:
        state.setMode(1);
        break;
      case MenuAction.timeline:
        state.setMode(2);
        break;
      default:
        break;
    }
  }

  @override
  SliverAppBar buildAppBar(BuildContext context) => SliverAppBar(
        title: Text(state.forum.name),
        floating: false,
        pinned: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.create),
            onPressed: () {
              onPostButtonTap(
                context,
                forum: state.forum,
                uid: uid,
                username: username,
              );
            },
          ),
          PopupMenuButton<Choice>(
            onSelected: (choice) => _menuSelected(context, choice),
            itemBuilder: (BuildContext context) {
              return filterMenus().map((Choice menuItem) {
                return PopupMenuItem<Choice>(
                  value: menuItem,
                  child: Text(menuItem.title),
                );
              }).toList();
            },
          )
        ],
      );

  @override
  APIRequest get checkNewRequest {
    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {
      // showToast(context, success ? 'Refresh Succeed' : 'Refresh Failed');
    });
    return ForumStoryCheckNewRequest(
        completer, state.forum.fid, storyList.current);
  }

  @override
  Widget buildStoryListView(BuildContext context, StoryListState aState) {
    var state = aState as ForumStoryState;
    return Scaffold(
      body: super.buildStoryListView(context, state),
    );
  }
}
