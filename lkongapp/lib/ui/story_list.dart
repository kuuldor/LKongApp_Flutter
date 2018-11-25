import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/items/story_item.dart';
import 'package:lkongapp/ui/story_content.dart';
import 'package:lkongapp/ui/story_screen.dart';
import 'package:lkongapp/ui/tools/icon_message.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

import 'package:lkongapp/ui/connected_widget.dart';

class StoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget(context, StoryListModel.fromStore, (viewModel) {
      return viewModel._buildListView(context);
    });
  }
}

class StoryListModel {
  final bool threadOnlyHome;
  final HomeList homeList;
  final bool loading;

  var _scrollController = ScrollController();

  final Future<Null> Function(BuildContext context, Story story) onStoryTap;

  StoryListModel(
      {@required this.loading,
      @required this.homeList,
      @required this.threadOnlyHome,
      @required this.onStoryTap});

  void showToast(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: IconMessage(
          message: message,
        ),
        duration: Duration(seconds: 3)));
  }

  Future<Null> _handleRefresh(BuildContext context) {
    final Completer<bool> completer = Completer<bool>();
    StoreProvider.of<AppState>(context).dispatch(
        HomeListRefreshRequest(completer, threadOnlyHome, homeList.current));
    return completer.future.then((success) {
      // showToast(context, success ? 'Refresh Succeed' : 'Refresh Failed');
    });
  }

  Future<Null> _handleLoadNew(BuildContext context) {
    final Completer<bool> completer = Completer<bool>();
    StoreProvider.of<AppState>(context)
        .dispatch(HomeListNewRequest(completer, threadOnlyHome, 0, 0));
    return completer.future.then((success) {});
  }

  Future<Null> _handleLoadMore(BuildContext context) {
    final Completer<bool> completer = Completer<bool>();
    StoreProvider.of<AppState>(context).dispatch(
        HomeListLoadMoreRequest(completer, threadOnlyHome, homeList.nexttime));
    return completer.future.then((success) {
      // showToast(context, success ? 'Loading Succeed' : 'Loading Failed');
    });
  }

  static StoryListModel fromStore(Store<AppState> store) {
    return StoryListModel(
      loading: store.state.isLoading,
      homeList: store.state.uiState.content.homeList,
      threadOnlyHome:
          store.state.appConfig.accountSettings.currentSetting.threadOnlyHome,
      onStoryTap: (BuildContext context, Story story) {
        return Future(() {
          String storyId = story.tid;
          String postId = "0";
          if (storyId == null) {
            storyId = parseLKTypeId(story.id);
          } else {
            postId = parseLKTypeId(story.id);
          }
          store.dispatch(
              UINavigationPush(context, LKongAppRoutes.story, false, (context) {
            return StoryScreen(
              storyId: int.parse(storyId),
              postId: int.parse(postId),
            );
          }));
        });
      },
    );
  }

  Widget _buildListView(BuildContext context) {
    int itemCount = homeList.stories.length;
    if (itemCount == 0) {
      if (loading) {
        return Center(child: CircularProgressIndicator());
      } else {
        _handleLoadNew(context);
        return Container();
      }
    }

    return RefreshIndicator(
      onRefresh: () => _handleRefresh(context),
      child: ListView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: homeList.stories.length + 1,
          itemBuilder: (BuildContext context, index) {
            Widget item;
            if (index < homeList.stories.length) {
              var story = homeList.stories[index];
              item = StoryItem(
                story: story,
                onTap: () => onStoryTap(context, story),
              );
            } else {
              if (!loading) {
                _handleLoadMore(context);
              }
              item = Container(
                  height: 84.0,
                  child: Center(child: CircularProgressIndicator()));
            }

            return Column(children: <Widget>[
              item,
              Divider(
                height: 12.0,
              ),
            ]);
          }),
    );
  }
}
