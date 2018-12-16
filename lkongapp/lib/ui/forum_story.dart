import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/items/story_item.dart';
import 'package:lkongapp/ui/story_screen.dart';
import 'package:lkongapp/ui/tools/icon_message.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
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

  void setMode(int newMode) {
    setState(() {
      mode = newMode;
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

  ForumStoryState(this.forum, {this.mode: 0});
  @override
  Widget build(BuildContext context) {
    return buildWidgetWithVMFactory(
        context, ForumStoryModel.fromStateAndStore(this));
  }
}

class ForumStoryModel extends StoryListModel {
  final StoryFetchList storyList;
  final bool loading;
  final String lastError;
  final Forum forum;
  final int mode;

  ForumStoryModel({
    @required this.loading,
    @required this.lastError,
    @required this.storyList,
    @required this.forum,
    @required this.mode,
  });

  static final fromStateAndStore =
      (ForumStoryState state) => (Store<AppState> store) => ForumStoryModel(
            loading:
                store.state.uiState.content.forumRepo[state.forum.fid].loading,
            lastError: store
                .state.uiState.content.forumRepo[state.forum.fid].lastError,
            storyList: store.state.uiState.content.forumRepo[state.forum.fid],
            forum: state.forum,
            mode: state.mode,
          );

  @override
  APIRequest get fetchFromScratchRequest {
    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {
      // showToast(context, success ? 'Loading Succeed' : 'Loading Failed');
    });
    return ForumStoryNewRequest(completer, forum.fid, mode, 0, 0);
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
        completer, forum.fid, mode, storyList.nexttime);
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
        completer, forum.fid, mode, storyList.current);
  }

  @override
  SliverAppBar buildAppBar(BuildContext context) => SliverAppBar(
        title: Text(forum.name),
        floating: false,
        pinned: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.create),
            onPressed: () {
              onPostButtonTap(context, forum);
            },
          ),
        ],
      );

  @override
  APIRequest get checkNewRequest {
    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {
      // showToast(context, success ? 'Refresh Succeed' : 'Refresh Failed');
    });
    return ForumStoryCheckNewRequest(completer, forum.fid, storyList.current);
  }

  @override
  Widget buildStoryListView(BuildContext context, StoryListState aState) {
    var state = aState as ForumStoryState;
    return Scaffold(
      body: super.buildStoryListView(context, state),
    );
  }
}
