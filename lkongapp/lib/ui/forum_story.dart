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
import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

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

class ForumStoryState extends State<ForumStory> {
  Forum forum;
  int mode;

  void setMode(int newMode) {
    setState(() {
      mode = newMode;
    });
  }

  ForumStoryState(this.forum, {this.mode: 0});
  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget(
        context, ForumStoryModel.fromStateAndStore(this), (viewModel) {
      return viewModel._buildStoryListView(context, this);
    });
  }
}

class ForumStoryModel extends StoryListModel {
  final StoryFetchList storyList;
  final bool loading;
  final String lastError;
  final int forumId;
  final int mode;

  ForumStoryModel({
    @required this.loading,
    @required this.lastError,
    @required this.storyList,
    @required this.forumId,
    @required this.mode,
  });

  static final fromStateAndStore =
      (ForumStoryState state) => (Store<AppState> store) => ForumStoryModel(
            loading: store.state.isLoading,
            lastError: store.state.uiState.content.lastError,
            storyList: store.state.uiState.content.forumRepo[state.forum.fid],
            forumId: state.forum.fid,
            mode: state.mode,
          );

  @override
  APIRequest get fetchFromScratchRequest {
    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {
      // showToast(context, success ? 'Loading Succeed' : 'Loading Failed');
    });
    return ForumStoryNewRequest(completer, forumId, mode, 0, 0);
  }

  @override
  APIRequest get loadMoreRequest {
    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {
      // showToast(context, success ? 'Loading Succeed' : 'Loading Failed');
    });
    return ForumStoryLoadMoreRequest(
        completer, forumId, mode, storyList.nexttime);
  }

  @override
  APIRequest get refreshRequest {
    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {
      // showToast(context, success ? 'Refresh Succeed' : 'Refresh Failed');
    });
    return ForumStoryRefreshRequest(
        completer, forumId, mode, storyList.current);
  }

  @override
  APIRequest get checkNewRequest {
    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {
      // showToast(context, success ? 'Refresh Succeed' : 'Refresh Failed');
    });
    return ForumStoryCheckNewRequest(completer, forumId, storyList.current);
  }

  Widget _buildStoryListView(BuildContext context, ForumStoryState state) {
    return Scaffold(
      appBar: AppBar(title: Text(state.forum.name)),
      body: buildListView(context),
    );
  }

  @override
  Widget headerForSection(BuildContext context, {int section}) {
    int newCount = storyList.newcount;
    if (newCount > 0) {
      return Container(
          height: 36.0,
          color: Colors.blue[500],
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "$newCount条新信息",
            style: const TextStyle(color: Colors.white),
          ));
    }
    return null;
  }

  @override
  int get checkNewActionKey => "Key-CheckNew-Forum-$forumId".hashCode;
}
