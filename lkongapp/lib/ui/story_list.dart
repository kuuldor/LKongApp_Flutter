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

abstract class StoryListModel {
  var _scrollController = ScrollController();

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
      StoreProvider.of<AppState>(context).dispatch(
          UINavigationPush(context, LKongAppRoutes.story, false, (context) {
        return StoryScreen(
          storyId: int.parse(storyId),
          postId: int.parse(postId),
        );
      }));
    });
  };

  void showToast(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: IconMessage(
          message: message,
        ),
        duration: Duration(seconds: 3)));
  }

  APIRequest get refreshRequest;
  APIRequest get fetchNewRequest;
  APIRequest get loadMoreRequest;

  bool get loading;
  StoryFetchList get storyList;

  Future<Null> _handleRefresh(BuildContext context) async {
    StoreProvider.of<AppState>(context).dispatch(refreshRequest);
  }

  Future<Null> _handleLoadNew(BuildContext context) async {
    StoreProvider.of<AppState>(context).dispatch(fetchNewRequest);
  }

  Future<Null> _handleLoadMore(BuildContext context) async {
    StoreProvider.of<AppState>(context).dispatch(loadMoreRequest);
  }

  Widget buildListView(BuildContext context) {
    int itemCount = storyList.stories.length;
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
          itemCount: itemCount + 1,
          itemBuilder: (BuildContext context, index) {
            Widget item;
            if (index < itemCount) {
              var story = storyList.stories[index];
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
