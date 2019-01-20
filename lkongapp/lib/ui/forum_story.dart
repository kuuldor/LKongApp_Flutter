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
  bool needReload;

  void setMode(int newMode) {
    setState(() {
      mode = newMode;
      needReload = true;
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

  ForumStoryState(this.forum, {this.mode: 0, this.needReload: false});

  @override
  Widget build(BuildContext context) {
    final fromStore = ForumStoryModel.fromStateAndStore(this);
    return buildWidgetWithVMFactory(context, fromStore);
  }
}

class ForumStoryModel extends StoryListModel {
  final FetchList<Story> storyList;
  final bool loading;
  final String lastError;
  final ForumStoryState state;
  final int uid;
  final String username;
  final BuiltList<String> followList;
  final bool showDetailTime;

  ForumStoryModel({
    @required this.uid,
    @required this.username,
    @required Store<AppState> store,
    @required this.loading,
    @required this.lastError,
    @required this.storyList,
    @required this.state,
    @required this.followList,
    @required this.showDetailTime,
  }) : super(store);

  @override
  bool operator ==(other) {
    return other is ForumStoryModel &&
        storyList == other.storyList &&
        followList == other.followList &&
        loading == other.loading &&
        lastError == other.lastError &&
        state == other.state &&
        uid == other.uid &&
        showDetailTime == other.showDetailTime &&
        username == other.username;
  }

  @override
  int get hashCode => hashObjects([
        storyList,
        followList,
        loading,
        lastError,
        state,
        uid,
        username,
        showDetailTime
      ]);

  static final fromStateAndStore =
      (ForumStoryState state) => (Store<AppState> store) => ForumStoryModel(
            store: store,
            username: selectUser(store)?.userInfo?.username,
            uid: selectUID(store),
            followList: selectUserData(store)?.followList?.fid,
            showDetailTime: selectSetting(store).showDetailTime,
            loading:
                store.state.uiState.content.forumRepo[state.forum.fid].loading,
            lastError: store
                .state.uiState.content.forumRepo[state.forum.fid].lastError,
            storyList: store.state.uiState.content.forumRepo[state.forum.fid],
            state: state,
          );

  @override
  bool get initLoaded => super.initLoaded && !state.needReload;

  @override
  APIRequest get fetchFromScratchRequest {
    state.needReload = false;

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {
      // showToast(context, success ? 'Loading Succeed' : 'Loading Failed');
    });

    return ForumStoryNewRequest(completer, state.forum.fid, state.mode, 0, 0);
  }

  @override
  APIRequest get loadMoreRequest {
    if (storyList.nexttime == 0) {
      return null;
    }

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {
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

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {
      // showToast(context, success ? 'Refresh Succeed' : 'Refresh Failed');
    });
    return ForumStoryRefreshRequest(
        completer, state.forum.fid, state.mode, storyList.current);
  }

  final allMenus = const <Choice>[
    const Choice(
        title: '全部显示', icon: Icons.library_books, action: MenuAction.showAll),
    const Choice(title: '精华', icon: Icons.star, action: MenuAction.digest),
    const Choice(
        title: '发布时间排序', icon: Icons.watch_later, action: MenuAction.timeline),
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

  void followForum(BuildContext context, MenuAction action) {
    final completer = Completer<String>();
    FollowRequest req;
    switch (action) {
      case MenuAction.follow:
        req = FollowRequest(
          completer,
          id: state.forum.fid,
          replyType: FollowType.forum,
          unfollow: false,
        );
        break;
      case MenuAction.unfollow:
        req = FollowRequest(
          completer,
          id: state.forum.fid,
          replyType: FollowType.forum,
          unfollow: true,
        );
        break;

      default:
        break;
    }

    if (req != null) {
      completer.future.then((error) {
        String msg = '修改关注状态';
        if (error == null) {
          msg += '成功';
        } else {
          msg += '失败' + ": $error";
        }
        showToast(msg);
      });

      dispatchAction(context)(req);
    }
  }

  @override
  SliverAppBar buildAppBar(BuildContext context) {
    List<Choice> menus = filterMenus();
    var actions = <Widget>[];
    
    if (username != null && uid != null) {
      actions.add(IconButton(
        icon: Icon(Icons.create),
        onPressed: () {
          onPostButtonTap(
            context,
            forum: state.forum,
            uid: uid,
            username: username,
          );
        },
      ));
    }

    if (followList != null) {
      if (followList.contains("${state.forum.fid}")) {
        actions.add(IconButton(
          icon: Icon(Icons.visibility_off),
          onPressed: () {
            followForum(context, MenuAction.unfollow);
          },
        ));
      } else {
        actions.add(IconButton(
          icon: Icon(Icons.visibility),
          onPressed: () {
            followForum(context, MenuAction.follow);
          },
        ));
      }
    }
    actions.add(PopupMenuButton<Choice>(
      onSelected: (choice) => _menuSelected(context, choice),
      itemBuilder: (BuildContext context) {
        return menus.map((Choice menuItem) {
          return PopupMenuItem<Choice>(
            value: menuItem,
            child: Text(menuItem.title),
          );
        }).toList();
      },
    ));

    return SliverAppBar(
      title: GestureDetector(
        child: Text(state.forum.name,
            style:
                Theme.of(context).textTheme.title.apply(color: Colors.white)),
        onTap: () => scrollToTop(context),
      ),
      floating: false,
      pinned: true,
      actions: actions,
    );
  }

  @override
  APIRequest get checkNewRequest {
    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {
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
