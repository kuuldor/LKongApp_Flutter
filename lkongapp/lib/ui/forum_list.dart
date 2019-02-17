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
import 'package:lkongapp/ui/items/item_wrapper.dart';
import 'package:lkongapp/ui/modeled_app.dart';
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

  final Map<int, Forum> forums;

  final List<int> followed;
  final List<int> forumIds;
  final List<int> planeIds;

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
    @required this.forums,
    @required this.followed,
    @required this.forumIds,
    @required this.planeIds,
    @required this.showInfo,
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
    final list = Set<int>();
    if (repo.forums != null && repo.forums.length > 0) {
      list.addAll(repo.forums.map((f) => f.fid));
    }
    if (repo.sysplanes != null && repo.sysplanes.length > 0) {
      list.addAll(repo.sysplanes.map((f) => f.fid));
    }

    final fetchList = followed.where((fid) => !list.contains(fid)).toSet();

    if (showInfo) {
      fetchList.addAll(list);
    }
    fetchList
        .forEach((fid) => dispatchAction(context)(ForumInfoRequest(null, fid)));
  }

  @override
  Future<Null> handleRefresh(BuildContext context) {
    final Completer<String> completer = Completer<String>();
    dispatchAction(context)(ForumListRequest(completer));
    return completer.future.then((error) {
      if (error == null) {
        _handleLoadInfo(context);
      }
    });
  }

  static ForumListModel fromStore(Store<AppState> store) {
    final userData = selectUserData(store);
    final repo = store.state.uiState.content.forumInfo;
    final followed = userData?.followList?.fid
        ?.where((f) => f.length > 0)
        ?.map((f) => int.parse(f))
        ?.toList();

    var forumMap = Map<int, Forum>();
    List<int> forumIds;
    List<int> planeIds;

    if (repo.forums != null) {
      forumMap.addAll(Map.fromIterable(repo.forums, key: (f) => f.fid));
      forumIds = repo.forums
          .map((f) => f.fid)
          .where((fid) => followed?.contains(fid) != true)
          .toList();
    }

    if (repo.sysplanes != null) {
      forumMap.addAll(Map.fromIterable(repo.sysplanes, key: (f) => f.fid));
      planeIds = repo.sysplanes
          .map((f) => f.fid)
          .where((fid) => followed?.contains(fid) != true)
          .toList();
    }

    return ForumListModel(
      repo: repo,
      followed: followed,
      forums: forumMap,
      forumIds: forumIds,
      planeIds: planeIds,
      showInfo: selectSetting(store).showForumInfo,
    );
  }

  @override
  void listIsReady(BuildContext context) {
    // if (showInfo && repo.info.length == 0) {
    if (!loading) {
      _handleLoadInfo(context);
    }
    // }
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
        if (forumIds != null) {
          count = forumIds.length;
        }
        break;
      case 2:
        if (planeIds != null) {
          count = planeIds.length;
        }
        break;
    }
    return count;
  }

  @override
  Widget cellForSectionAndIndex(BuildContext context,
      {int section, int index}) {
    int fid;
    switch (section) {
      case 0:
        if (followed != null) {
          fid = followed[index];
        }
        break;
      case 1:
        if (forumIds != null) {
          fid = forumIds[index];
        }
        break;
      case 2:
        if (planeIds != null) {
          fid = planeIds[index];
        }
        break;
    }

    if (fid != null) {
      Forum forum = forums[fid];
      if (forum == null) {
        final info = repo.info[fid];
        if (info != null) {
          forum = Forum().rebuild((b) => b
            ..fid = info.fid
            ..name = info.name);
        }
      }
      if (forum != null) {
        Widget item = createForumListItem(context, forum);
        return wrapItem(context, item);
      }
    }

    return Container();
  }

  @override
  Widget headerForSection(BuildContext context, {int section}) {
    if (lastError != null && section == 0) {
      return Container(
          color: Colors.red[500],
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "错误：$lastError。请稍后重试",
            style: const TextStyle(color: Colors.white),
          ));
    }

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
        if (repo.forums != null && forumIds.length > 0) {
          headerText = '版块列表';
        }
        break;
      case 2:
        if (repo.sysplanes != null && planeIds.length > 0) {
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
