import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/fetched_list.dart';
import 'package:lkongapp/ui/items/forum_item.dart';
import 'package:lkongapp/ui/items/user_item.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/tools/drawer_button.dart';
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

const fetchTypeStory = 0;
const fetchTypeFans = 1;
const fetchTypeFollow = 2;
const fetchTypeDigest = 2;

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
    this.fetchType: fetchTypeStory,
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
  // final Profile profile;
  final bool loading;
  final String lastError;
  final int fetchType;

  ProfileScreenModel({
    @required this.user,
    @required this.loading,
    @required this.lastError,
    @required this.fetchType,
  });

  static final fromStateAndStore = (ProfileScreenState state) =>
      (Store<AppState> store) => ProfileScreenModel(
            loading: store.state.uiState.content.searchResult.loading,
            lastError: store.state.uiState.content.searchResult.lastError,
            // profile: store.state.uiState.content.profile,
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
    BuiltList list;
    switch (fetchType) {
      case fetchTypeStory:
        // list = profile?.stories?.stories;
        break;
      case fetchTypeFans:
        // list = profile?.fans?.user;
        break;
      case fetchTypeFollow:
        // list = profile?.follows?.user;
        break;
      case fetchTypeDigest:
        // list = profile?.digests?.stories;
        break;
    }
    count = list?.length ?? 0;

    return count;
  }

  @override
  SliverAppBar buildAppBar(BuildContext context) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    return SliverAppBar(
      expandedHeight: 240.0,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(stripHtmlTag(user.username)),
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
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: CachedNetworkImageProvider(
                            avatarForUserID(user.uid),
                            imageOnError: "assets/noavatar.png"),
                        radius: 48.0,
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

    if (fetchType == fetchTypeStory) {
      Story story;

      item = StoryItem(
        story: story,
        onTap: () => onStoryTap(context, story),
      );
    } else if (fetchType == fetchTypeFans) {
      UserInfo fan;

      item = UserItem(
        user: fan,
        onTap: () {},
      );
    } else if (fetchType == fetchTypeFollow) {
      UserInfo follow;

      item = UserItem(
        user: follow,
        onTap: () {},
      );
    } else if (fetchType == fetchTypeDigest) {
      Story digest;

      item = StoryItem(
        story: digest,
        onTap: () => onStoryTap(context, digest),
      );
    }

    return item;
  }

  @override
  Widget headerForSection(BuildContext context, {int section}) {
    String error = lastError;
    if (error != null && error != "") {
      return Container(
          color: Colors.red[500],
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "网络错误：$error。请稍后重试",
            style: const TextStyle(color: Colors.white),
          ));
    }
    return null;
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
    int nexttime;
    switch (fetchType) {
      case fetchTypeStory:
        // nexttime = profile.stories?.nexttime;
        break;
      case fetchTypeFans:
        // nexttime = profile.fans?.nexttime;
        break;
      case fetchTypeFollow:
        // nexttime = profile.follows?.nexttime;
        break;
      case fetchTypeDigest:
        // nexttime = profile.digests?.nexttime;
        break;
    }

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
  Widget buildListView(BuildContext context) {
    var placeHolder;
    // if (profile == null) {
    //   if (loading != true && lastError == null) {
    //     handleFetchFromScratch(context);
    //   }
    //   placeHolder = Center(child: CircularProgressIndicator());
    // }

    if (placeHolder != null) {
      return SliverList(
        delegate: SliverChildListDelegate(
          [placeHolder],
        ),
      );
    }

    return super.buildGroupedListView(context);
  }

  @override
  List<Widget> buildSlivers(BuildContext context) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    List<Widget> slivers = new List<Widget>();

    SliverAppBar bar = buildAppBar(context);
    if (bar != null) {
      slivers.add(bar);
    }

    for (int i = 0; i < numberOfSections; i++) {
      slivers.add(builderSection(context, i));
    }

    slivers.add(SliverFillRemaining(
      child: Container(
        color: theme.themeData.backgroundColor,
      ),
    ));
    return slivers;
  }
}
