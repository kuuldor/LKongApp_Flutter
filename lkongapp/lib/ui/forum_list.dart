import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/items/forum_item.dart';
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

class ForumList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget(context, ForumListModel.fromStore, (viewModel) {
      return viewModel._buildListView(context);
    });
  }
}

class ForumListModel {
  final ForumInfo repo;
  final bool loading;

  var _scrollController = ScrollController();

  final Future<Null> Function(BuildContext, Forum) onForumTap;

  ForumListModel({
    @required this.loading,
    @required this.repo,
    @required this.onForumTap,
  });

  void showToast(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: IconMessage(
          message: message,
        ),
        duration: Duration(seconds: 3)));
  }

  void _handleLoadInfo(BuildContext context, [int retries = 0]) async {
    if (repo.forums != null && repo.forums.length > 0) {
      var list = List<Forum>()..addAll(repo.forums);
      list.forEach((forum) => StoreProvider.of<AppState>(context)
          .dispatch(ForumInfoRequest(null, forum.fid)));
    }
  }

  Future<Null> _handleRefresh(BuildContext context) {
    final Completer<bool> completer = Completer<bool>();
    StoreProvider.of<AppState>(context).dispatch(ForumListRequest(completer));
    return completer.future.then((success) {
      if (success) {
        _handleLoadInfo(context);
      }
    });
  }

  Future<Null> _handleLoadNew(BuildContext context) {
    final Completer<bool> completer = Completer<bool>();
    StoreProvider.of<AppState>(context).dispatch(ForumListRequest(completer));
    return completer.future.then((success) {});
  }

  static ForumListModel fromStore(Store<AppState> store) {
    return ForumListModel(
      loading: store.state.isLoading,
      repo: store.state.uiState.content.forumRepo,
      onForumTap: (BuildContext context, Forum forum) {
        return Future(() {});
      },
    );
  }

  Widget _buildListView(BuildContext context) {
    int forumCount = repo.forums.length;

    if (forumCount == 0) {
      if (loading) {
        return Center(child: CircularProgressIndicator());
      } else {
        _handleLoadNew(context);
        return Container();
      }
    }

    int infoCount = repo.info.length;
    if (infoCount == 0) {
      if (!loading) {
        _handleLoadInfo(context);
      }
    }

    return RefreshIndicator(
      onRefresh: () => _handleRefresh(context),
      child: ListView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: forumCount,
          itemBuilder: (BuildContext context, index) {
            Widget item;
            if (index < forumCount) {
              var forum = repo.forums[index];
              var info = repo.info[forum.fid];
              item = ForumItem(
                forum: forum,
                info: info,
                onTap: () => onForumTap(context, forum),
              );
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
