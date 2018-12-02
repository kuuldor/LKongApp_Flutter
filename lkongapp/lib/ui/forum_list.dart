import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/ui/fetched_list.dart';
import 'package:lkongapp/ui/forum_story.dart';
import 'package:lkongapp/ui/items/forum_item.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

import 'package:lkongapp/ui/connected_widget.dart';

class ForumList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget(context, ForumListModel.fromStore, (viewModel) {
      return viewModel.buildListView(context);
    });
  }
}

class ForumListModel extends FetchedListModel {
  final ForumInfo repo;
  final bool loading;
  final String lastError;

  final Future<Null> Function(BuildContext, Forum) onForumTap;
  
  @override
  bool operator ==(other) {
    return other is ForumListModel &&
        repo == other.repo &&
        loading == other.loading &&
        lastError == other.lastError;
  }

  @override
  int get hashCode => hash3(repo, loading, lastError);

  ForumListModel({
    @required this.loading,
    @required this.lastError,
    @required this.repo,
    @required this.onForumTap,
  });

  @override
  int get itemCount => repo.forums.length;

  @override
  APIRequest get fetchFromScratchRequest => ForumListRequest(null);

  @override
  APIRequest get loadMoreRequest => null;

  @override
  APIRequest get refreshRequest => ForumListRequest(null);

  void _handleLoadInfo(BuildContext context, [int retries = 0]) async {
    if (repo.forums != null && repo.forums.length > 0) {
      var list = List<Forum>()..addAll(repo.forums);
      list.forEach((forum) =>
          dispatchAction(context)(ForumInfoRequest(null, forum.fid)));
    }
  }

  @override
  Future<Null> handleRefresh(BuildContext context) {
    final Completer<bool> completer = Completer<bool>();
    dispatchAction(context)(ForumListRequest(completer));
    return completer.future.then((success) {
      if (success) {
        _handleLoadInfo(context);
      }
    });
  }

  static ForumListModel fromStore(Store<AppState> store) {
    return ForumListModel(
      loading: store.state.isLoading,
      lastError: store.state.uiState.content.lastError,
      repo: store.state.uiState.content.forumInfo,
      onForumTap: (BuildContext context, Forum forum) {
        store.dispatch(ForumStoryNewRequest(null, forum.fid, 0, 0, 0));

        return Future(() {
          store.dispatch(UINavigationPush(
              context, LKongAppRoutes.forumStory, false, (context) {
            return ForumStory(
              forum: forum,
            );
          }));
        });
      },
    );
  }

  @override
  void listIsReady(BuildContext context) {
    int infoCount = repo.info.length;
    if (infoCount == 0) {
      if (!loading) {
        _handleLoadInfo(context);
      }
    }
  }

  @override
  Widget createListItem(BuildContext context, int index) {
    Forum forum = repo.forums[index];
    var info = repo.info[forum.fid];
    return ForumItem(
      forum: forum,
      info: info,
      onTap: () => onForumTap(context, forum),
    );
  }
}
