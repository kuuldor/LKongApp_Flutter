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
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/ui/connected_widget.dart';

import 'story_list.dart';

class UserStory extends StatefulWidget {
  final UserInfo user;

  const UserStory({Key key, @required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserStoryState(user);
  }
}

class UserStoryState extends StoryListState<UserStory> {
  UserInfo user;

  @override
  bool operator ==(other) {
    return other is UserStoryState && user == other.user;
  }

  @override
  int get hashCode => user.hashCode;

  UserStoryState(this.user);

  @override
  Widget build(BuildContext context) {
    return buildWidgetWithVMFactory(
        context, UserStoryModel.fromStateAndStore(this));
  }
}

class UserStoryModel extends StoryListModel {
  final StoryFetchList storyList;
  final bool loading;
  final String lastError;
  final UserInfo user;
  final bool showDetailTime;

  UserStoryModel({
    @required Store<AppState> store,
    @required this.loading,
    @required this.lastError,
    @required this.storyList,
    @required this.user,
    @required this.showDetailTime,
  }) : super(store);

  static final fromStateAndStore =
      (UserStoryState state) => (Store<AppState> store) => UserStoryModel(
            store: store,
            loading:
                store.state.uiState.content.profiles[state.user.uid]?.loading,
            lastError:
                store.state.uiState.content.profiles[state.user.uid]?.lastError,
            storyList:
                store.state.uiState.content.profiles[state.user.uid]?.allPosts,
            showDetailTime: selectSetting(store).showDetailTime,
            user: state.user,
          );

  @override
  APIRequest get fetchFromScratchRequest {
    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {
      // showToast(context, success ? 'Loading Succeed' : 'Loading Failed');
    });
    return ProfileNewRequest(completer, user.uid, 4);
  }

  @override
  APIRequest get loadMoreRequest {
    if (storyList == null || storyList.nexttime == 0) {
      return null;
    }

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {
      // showToast(context, success ? 'Loading Succeed' : 'Loading Failed');
    });
    return ProfileLoadMoreRequest(completer, user.uid, 4, storyList.nexttime);
  }

  @override
  APIRequest get refreshRequest => null;

  @override
  SliverAppBar buildAppBar(BuildContext context) => SliverAppBar(
        title: Text("${user.username}(全部帖子)"),
        floating: false,
        pinned: true,
      );

  @override
  APIRequest get checkNewRequest => null;

  @override
  Widget buildStoryListView(BuildContext context, StoryListState aState) {
    var state = aState as UserStoryState;
    return Scaffold(
      body: super.buildStoryListView(context, state),
    );
  }
}
