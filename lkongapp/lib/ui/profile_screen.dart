import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/fetched_list.dart';
import 'package:lkongapp/ui/items/forum_item.dart';
import 'package:lkongapp/ui/items/user_item.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/tools/drawer_button.dart';
import 'package:lkongapp/ui/tools/user_icon.dart';
import 'package:material_search/material_search.dart';
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
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/ui/connected_widget.dart';
import 'package:lkongapp/ui/tools/item_handler.dart';

const fetchTypeNone = -1;
const fetchTypeStory = 0;
const fetchTypeFans = 1;
const fetchTypeFollow = 2;
const fetchTypeDigest = 3;

class ProfileScreen extends StatefulWidget {
  final UserInfo user;
  const ProfileScreen({Key key, @required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState(user: user);
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  final UserInfo user;
  int fetchType;

  final _scrollController = ScrollController();

  ProfileScreenState({
    this.fetchType: fetchTypeNone,
    @required this.user,
  });

  void setProfileType(int newType) {
    setState(() {
      fetchType = newType;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget(
        context, ProfileScreenModel.fromStateAndStore(this),
        (ProfileScreenModel viewModel) {
      return viewModel.buildListView(context);
    });
  }
}

class ProfileScreenModel extends FetchedListModel {
  final UserInfo user;
  final Profile profile;
  final bool loading;
  final String lastError;
  final int fetchType;

  ProfileScreenModel({
    @required this.user,
    @required this.profile,
    @required this.loading,
    @required this.lastError,
    @required this.fetchType,
  });

  static final fromStateAndStore = (ProfileScreenState state) =>
      (Store<AppState> store) => ProfileScreenModel(
            loading:
                store.state.uiState.content.profiles[state.user.uid]?.loading,
            lastError:
                store.state.uiState.content.profiles[state.user.uid]?.lastError,
            profile: store.state.uiState.content.profiles[state.user.uid],
            fetchType: state.fetchType,
            user: state.user,
          );

  @override
  bool operator ==(other) {
    return other is ProfileScreenModel &&
        loading == other.loading &&
        lastError == other.lastError &&
        user.uid == other.user.uid;
  }

  @override
  int get hashCode => hash3(user.uid, loading, lastError);

  @override
  int get itemCount {
    int count;
    BuiltList list = getFetchList(fetchType);
    count = list?.length ?? 0;

    return count;
  }

  BuiltList getFetchList(int type) {
    BuiltList list;
    switch (type) {
      case fetchTypeStory:
        list = profile?.stories?.stories;
        break;
      case fetchTypeFans:
        list = profile?.fans?.user;
        break;
      case fetchTypeFollow:
        list = profile?.follows?.user;
        break;
      case fetchTypeDigest:
        list = profile?.digests?.stories;
        break;
    }
    return list;
  }

  getFetchResult(int type) {
    var result;
    switch (type) {
      case fetchTypeStory:
        result = profile?.stories;
        break;
      case fetchTypeFans:
        result = profile?.fans;
        break;
      case fetchTypeFollow:
        result = profile?.follows;
        break;
      case fetchTypeDigest:
        result = profile?.digests;
        break;
    }
    return result;
  }

  @override
  bool get initLoaded {
    final result = getFetchResult(fetchType);

    return result != null;
  }

  @override
  SliverAppBar buildAppBar(BuildContext context) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    return SliverAppBar(
      expandedHeight: 240.0,
      flexibleSpace: FlexibleSpaceBar(
          title: Row(
            children: <Widget>[
              Text(stripHtmlTag(user.username)),
              Padding(
                  padding: EdgeInsets.only(left: 8.0), child: verifyIcon(user)),
            ],
          ),
          background: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                  "assets/${theme.isNightMode ? 'black.jpg' : 'blue.jpg'}",
                  fit: BoxFit.cover),
              Column(
                children: <Widget>[
                  Container(
                    height: 80.0,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 24.0, top: 8.0),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: CachedNetworkImageProvider(
                                avatarForUserID(user.uid),
                                imageOnError: "assets/noavatar.png"),
                            radius: 48.0,
                          ),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: user.verifymessage != null
                                    ? Text(
                                        stripHtmlTag(user.verifymessage),
                                        style: theme.themeData.textTheme.title
                                            .copyWith(
                                                fontSize: 22,
                                                color: Colors.white),
                                      )
                                    : Container()),
                          ),
                        ],
                      ))
                ],
              )
            ],
          )),
      floating: false,
      pinned: true,
    );
  }

  @override
  Widget createListItem(BuildContext context, int index) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    var item;

    final list = getFetchList(fetchType);
    final object = list[index];
    assert(object != null, "$list doesn't have item at index $index");

    if (fetchType == fetchTypeStory) {
      Story story = object as Story;

      item = StoryItem(
        story: story,
        onTap: () => onStoryTap(context, story),
      );
    } else if (fetchType == fetchTypeFans) {
      UserInfo fan = object as UserInfo;

      item = UserItem(
        user: fan,
        onTap: () {},
      );
    } else if (fetchType == fetchTypeFollow) {
      UserInfo follow = object as UserInfo;

      item = UserItem(
        user: follow,
        onTap: () {},
      );
    } else if (fetchType == fetchTypeDigest) {
      Story digest = object as Story;

      item = StoryItem(
        story: digest,
        onTap: () => onStoryTap(context, digest),
      );
    }

    return item;
  }

  @override
  Widget headerForSection(BuildContext context, {int section}) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    var list = <Widget>[];
    String error = lastError;
    if (error != null && error.length > 0) {
      list.add(Container(
          color: Colors.red[500],
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "网络错误：$error。请稍后重试",
            style: const TextStyle(color: Colors.white),
          )));
    }

    if (profile != null) {
      list.add(Container(
          height: 48.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: OutlineButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('主题'),
                    Text("${profile.user.threads}")
                  ],
                ),
                onPressed: () {},
              )),
              Expanded(
                  child: OutlineButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('粉丝'),
                    Text("${profile.user.fansnum}")
                  ],
                ),
                onPressed: () {},
              )),
              Expanded(
                  child: OutlineButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('关注'),
                    Text("${profile.user.followuidnum}")
                  ],
                ),
                onPressed: () {},
              )),
              Expanded(
                  child: OutlineButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('精华'),
                    Text("${profile.user.digestposts}")
                  ],
                ),
                onPressed: () {},
              )),
            ],
          )));
    }
    return Column(
      children: list,
    );
  }

  @override
  APIRequest get fetchFromScratchRequest {
    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {});
    // return ProfileNewRequest(completer, searchString, fetchType);
    return null;
  }

  @override
  APIRequest get loadMoreRequest {
    final result = getFetchResult(fetchType);
    int nexttime = result?.nexttime;

    if (nexttime == null || nexttime == 0) {
      return null;
    }

    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {});
    // return ProfileLoadMoreRequest(completer, searchString, fetchType, nexttime);
    return null;
  }

  @override
  APIRequest get refreshRequest => null;

  @override
  void listIsReady(BuildContext context) {}

  @override
  Widget fillupForEmptyView(BuildContext context) {
    if (profile == null && lastError == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return null;
    }
  }

  @override
  Widget buildListView(BuildContext context) {
    if (profile == null) {
      if (loading != true && lastError == null) {
        handleFetchUserInfo(context);
      }
    }

    return Scaffold(body: super.buildListView(context));
  }

  void handleFetchUserInfo(BuildContext context) {
    dispatchAction(context)(UserInfoRequest(null, user.uid));
  }
}
