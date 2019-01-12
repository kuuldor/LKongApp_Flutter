import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/fetched_list.dart';
import 'package:lkongapp/ui/forum_story.dart';
import 'package:lkongapp/ui/items/forum_item.dart';
import 'package:lkongapp/ui/tools/drawer_button.dart';
import 'package:lkongapp/ui/tools/item_handler.dart';
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
  final ForumLists repo;
  final List<int> followed;
  final bool showInfo;
  bool get loading => repo.loading;
  String get lastError => repo.lastError;

  @override
  SliverAppBar buildAppBar(BuildContext _) => SliverAppBar(
        leading: DrawerButton(),
        title: Text('版块'),
        floating: false,
        pinned: true,
      );

  @override
  bool operator ==(other) {
    return other is ForumListModel &&
        repo == other.repo &&
        followed == other.followed &&
        showInfo == other.showInfo;
  }

  @override
  int get hashCode => hash3(repo, followed, showInfo);

  ForumListModel({
    @required this.repo,
    @required this.showInfo,
    @required this.followed,
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
    final list = List<Forum>();
    if (repo.forums != null && repo.forums.length > 0) {
      list.addAll(repo.forums);
    }
    if (repo.sysplanes != null && repo.sysplanes.length > 0) {
      list.addAll(repo.sysplanes);
    }
    list.forEach(
        (forum) => dispatchAction(context)(ForumInfoRequest(null, forum.fid)));
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
    final userData = selectUserData(store);
    return ForumListModel(
      repo: store.state.uiState.content.forumInfo,
      followed: userData?.followList?.fid
          ?.where((f) => f.length > 0)
          ?.map((f) => int.parse(f))
          ?.toList(),
      showInfo: selectSetting(store).showForumInfo,
    );
  }

  @override
  void listIsReady(BuildContext context) {
    if (showInfo && repo.info.length == 0) {
      if (!loading) {
        _handleLoadInfo(context);
      }
    }
  }

  Widget createForumListItem(BuildContext context, Forum forum) {
    var info = repo.info[forum.fid];
    return ForumItem(
      forum: forum,
      info: showInfo ? info : null,
      onTap: () => onForumTap(context, forum),
    );
  }

  @override
  int get numberOfSections => 3;

  @override
  int countOfItemsInSection({int section}) {
    int count = 0;
    switch (section) {
      case 0:
        if (followed != null) {
          count = followed.length;
        }
        break;
      case 1:
        if (repo.forums != null) {
          count = repo.forums.length;
        }
        break;
      case 2:
        if (repo.sysplanes != null) {
          count = repo.sysplanes.length;
        }
        break;
    }
    return count;
  }

  @override
  Widget cellForSectionAndIndex(BuildContext context,
      {int section, int index}) {
    List<Forum> forums;
    switch (section) {
      case 0:
        if (followed != null) {
          forums = List<Forum>.from(repo.forums
              .where((forum) => followed?.contains(forum.fid) == true));
        }
        break;
      case 1:
        if (repo.forums != null) {
          forums = List<Forum>.from(repo.forums
              .where((forum) => followed?.contains(forum.fid) != true));
        }
        break;
      case 2:
        if (repo.sysplanes != null) {
          forums = repo.sysplanes.toList();
        }
        break;
    }
    if (forums != null && index >= 0 && index < forums.length) {
      Widget item = createForumListItem(context, forums[index]);

      return Column(children: <Widget>[
        item,
        Divider(
          height: 12.0,
        ),
      ]);
    }

    return null;
  }

  @override
  Widget headerForSection(BuildContext context, {int section}) {
    String headerText;

    switch (section) {
      case 0:
        if (repo.forums != null &&
            repo.forums.length > 0 &&
            followed != null &&
            followed.length > 0) {
          headerText = '我的关注';
        }
        break;
      case 1:
        if (repo.forums != null && repo.forums.length > 0) {
          headerText = '版块列表';
        }
        break;
      case 2:
        if (repo.sysplanes != null && repo.sysplanes.length > 0) {
          headerText = '系统位面';
        }
        break;
    }

    if (headerText != null) {
      return Container(
          color: Colors.grey[500].withAlpha(240),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "$headerText",
            style: const TextStyle(color: Colors.white),
          ));
    }

    return null;
  }

  @override
  Widget createListItem(BuildContext context, int index) {
    // No need to implement this. Only used by one-section list
    return null;
  }

  @override
  bool get initLoaded => repo.forums.length > 0;
}
