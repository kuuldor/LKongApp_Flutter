import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:lkongapp/actions/profile_action.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/fetched_list.dart';
import 'package:lkongapp/ui/items/forum_item.dart';
import 'package:lkongapp/ui/items/user_item.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/screens.dart';
import 'package:lkongapp/ui/tools/choose_image.dart';
import 'package:lkongapp/ui/tools/drawer_button.dart';
import 'package:lkongapp/ui/tools/menu_choice.dart';
import 'package:lkongapp/ui/tools/user_icon.dart';
import 'package:lkongapp/ui/user_story.dart';
import 'package:material_search/material_search.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:lkongapp/utils/async_avatar.dart';

const fetchTypeNone = -1;
const fetchTypeStory = 0;
const fetchTypeFans = 1;
const fetchTypeFollow = 2;
const fetchTypeDigest = 3;
const fetchTypeAllStories = 4;

class ProfileScreen extends StatefulWidget {
  final UserInfo user;
  const ProfileScreen({Key key, @required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState(user: user);
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  UserInfo user;
  int fetchType;
  bool stateLoading = false;

  double offset = 0.0;

  ProfileScreenState({
    this.fetchType: fetchTypeNone,
    @required this.user,
  });

  void setFetchType(int newType) {
    setState(() {
      fetchType = newType;
    });
  }

  @override
  void initState() {
    super.initState();

    if (user.uid == 0 && user.username.length > 0) {
      stateLoading = true;
      apiDispatch(QUERY_API, {"userName": user.username}).then((result) {
        final location = result["location"];
        if (location != null) {
          int uid = parseLKTypeId(location, type: "user");
          if (uid != null) {
            setState(() {
              stateLoading = false;
              user = user.rebuild((b) => b..uid = uid);
            });
          }
        }
      });
    }
  }

  void setOffset(double value) {
    offset = value;
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

final allMenus = const <Choice>[
  const Choice(title: '加关注', icon: Icons.visibility, action: MenuAction.follow),
  const Choice(
      title: '解除关注', icon: Icons.visibility_off, action: MenuAction.unfollow),
  const Choice(title: '发消息', icon: Icons.textsms, action: MenuAction.chat),
  const Choice(title: '加入黑名单', icon: Icons.report, action: MenuAction.block),
  const Choice(
      title: '解除黑名单', icon: Icons.report_off, action: MenuAction.unblock),
  const Choice(
      title: '全部帖子', icon: Icons.library_books, action: MenuAction.showAll),
  const Choice(
      title: '管理黑名单',
      icon: Icons.recent_actors,
      action: MenuAction.manageBlackList),
  const Choice(
      title: '上传头像', icon: Icons.add_a_photo, action: MenuAction.uploadAvatar),
];

class ProfileScreenModel extends FetchedListModel implements ScrollerState {
  final Profile profile;
  final bool storeLoading;
  final String lastError;
  final int uid;
  final FollowList followList;
  final ProfileScreenState state;
  final bool showDetailTime;

  final Function(int) changeFetchType;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool get loading => state.stateLoading || storeLoading;

  ProfileScreenModel({
    @required this.profile,
    @required this.storeLoading,
    @required this.lastError,
    @required this.state,
    @required this.changeFetchType,
    @required this.uid,
    @required this.showDetailTime,
    @required this.followList,
  });

  static final fromStateAndStore = (ProfileScreenState state) =>
      (Store<AppState> store) => ProfileScreenModel(
            storeLoading:
                store.state.uiState.content.profiles[state.user.uid]?.loading ==
                    true,
            lastError:
                store.state.uiState.content.profiles[state.user.uid]?.lastError,
            profile: state.user.uid != 0
                ? store.state.uiState.content.profiles[state.user.uid]
                : null,
            state: state,
            uid: selectUID(store),
            followList: selectUserData(store)?.followList,
            showDetailTime: selectSetting(store).showDetailTime,
            changeFetchType: (int newType) => state.setFetchType(newType),
          );

  int get fetchType => state.fetchType;
  UserInfo get user => profile?.user;

  ScrollController _scrollController;
  @override
  ScrollController get scrollController =>
      _scrollController ??= ScrollController(initialScrollOffset: state.offset);

  @override
  bool operator ==(other) {
    return other is ProfileScreenModel &&
        storeLoading == other.storeLoading &&
        lastError == other.lastError &&
        state == other.state &&
        profile == other.profile &&
        uid == other.uid &&
        followList == other.followList;
  }

  @override
  int get hashCode =>
      hashObjects([state, storeLoading, lastError, profile, uid, followList]);

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
        list = profile?.stories?.data;
        break;
      case fetchTypeFans:
        list = profile?.fans?.user;
        break;
      case fetchTypeFollow:
        list = profile?.follows?.user;
        break;
      case fetchTypeDigest:
        list = profile?.digests?.data;
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

  int getFetchCount(int type) {
    var result;
    switch (type) {
      case fetchTypeStory:
        result = profile?.user?.threads;
        break;
      case fetchTypeFans:
        result = profile?.user?.fansnum;
        break;
      case fetchTypeFollow:
        result = profile?.user?.followuidnum;
        break;
      case fetchTypeDigest:
        result = profile?.user?.digestposts;
        break;
    }
    return result ?? 0;
  }

  @override
  bool get initLoaded {
    return fetchType == fetchTypeNone || getFetchResult(fetchType) != null;
  }

  List<Choice> filterMenus() {
    var menus;
    int profileUID = profile?.user?.uid;
    //Show all is the splitter of menus for others and self
    int index =
        allMenus.indexWhere((item) => item.action == MenuAction.showAll);

    if (uid == profileUID) {
      menus = allMenus.skip(index).toList();
    } else if (followList != null) {
      bool followed = followList.uid.contains("$profileUID");
      bool blocked = followList.black.contains("$profileUID");
      menus = allMenus.getRange(0, index + 1).where((item) {
        switch (item.action) {
          case MenuAction.follow:
            return !followed;
            break;
          case MenuAction.unfollow:
            return followed;
            break;
          case MenuAction.block:
            return !blocked;
            break;
          case MenuAction.unblock:
            return blocked;
            break;
          default:
            break;
        }
        return true;
      }).toList();
    } else {
      menus = const <Choice>[];
    }

    return menus;
  }

  void menuSelected(BuildContext context, Choice choice) {
    print("Menu Selcected for ${choice.title}");
    final completer = Completer<String>();

    FollowRequest req;
    switch (choice.action) {
      case MenuAction.follow:
        req = FollowRequest(
          completer,
          id: profile.user.uid,
          replyType: FollowType.user,
          unfollow: false,
        );
        break;
      case MenuAction.unfollow:
        req = FollowRequest(
          completer,
          id: profile.user.uid,
          replyType: FollowType.user,
          unfollow: true,
        );
        break;
      case MenuAction.block:
        req = FollowRequest(
          completer,
          name: user.username,
          id: profile.user.uid,
          replyType: FollowType.black,
          unfollow: false,
        );
        break;
      case MenuAction.unblock:
        req = FollowRequest(
          completer,
          id: profile.user.uid,
          replyType: FollowType.black,
          unfollow: true,
        );
        break;
      case MenuAction.showAll:
        dispatchAction(context)(
            UINavigationPush(context, LKongAppRoutes.post, false, (context) {
          if (user != null) {
            return UserStory(
              user: user,
            );
          } else {
            assert(false, "User is not ready");
          }
        }));
        break;
      case MenuAction.chat:
        dispatchAction(context)(UINavigationPush(
            context, LKongAppRoutes.pmsession, false, (context) {
          return PMSessionScreen(
            pmid: profile.user.uid,
          );
        }));
        break;
      case MenuAction.manageBlackList:
        dispatchAction(context)(UINavigationPush(
            context, LKongAppRoutes.manageBlacklist, false, (context) {
          return BlacklistManageScreen();
        }));
        break;
      case MenuAction.uploadAvatar:
        _uploadAvatar(context);
        break;
      default:
        break;
    }

    if (req != null) {
      completer.future.then((error) {
        String msg = "${choice.title}";
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

  void _uploadAvatar(BuildContext context) async {
    chooseImage(context, _scaffoldKey, onChosen: (file) {
      _uploadImage(file).then((link) {
        if (link != null) {
          showToast("上传头像成功");
        }
      });
    });
  }

  Future<String> _uploadImage(File image) async {
    // print("Image $image");
    if (image != null) {
      return apiDispatch(UPLOAD_AVATAR_API, {"file": image.path})
          .then((result) {
        final link = result["avatar"];
        final error = result["error"];
        if (link != null) {
          return link;
        }
        if (error != null) {
          showToast("上传头像失败: $error");
        }
      });
    }
    return null;
  }

  @override
  SliverAppBar buildAppBar(BuildContext context) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    String infoText = "";
    if (user?.regdate != null) {
      infoText +=
          "注册于: ${stringFromDate(dateFromString(user.regdate), format: 'yyyy-MM-dd')}";
      if (user.extcredits2 != null) {
        infoText += "   龙币: ${user.extcredits2}";
      }
      if (user.extcredits3 != null) {
        infoText += "   龙晶: ${user.extcredits3}";
      }
    }

    List<Choice> menus = filterMenus();
    var actions = <Widget>[];

    if (menus.length > 0) {
      actions.add(popupMenu(context, menus, menuSelected));
    }

    return SliverAppBar(
      expandedHeight: 320.0,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: GestureDetector(
            child: Text(user?.username ?? "",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .apply(color: Colors.white)),
            onTap: () => scrollToTop(context),
          ),
          background: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                  "assets/${theme.isNightMode ? 'black.jpg' : 'blue.jpg'}",
                  fit: BoxFit.cover),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: 48.0,
                        right: user?.verifymessage != null &&
                                user.verifymessage.length < 12
                            ? 48.0
                            : 32.0),
                    height: 144.0,
                    alignment: Alignment.bottomCenter,
                    child: user?.verifymessage != null
                        ? Text(
                            user.verifymessage,
                            style: theme.themeData.textTheme.title.copyWith(
                                fontSize: 20 -
                                    (user.verifymessage.length > 24
                                            ? (user.verifymessage.length -
                                                    24) ~/
                                                12
                                            : 0)
                                        .toDouble(),
                                color: Colors.white),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Container(),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 8.0),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Container(
                                height: 0.0,
                                width: 18.0,
                              )),
                          buildUserAvatar(context, state.user.uid, 96.0),
                          Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: verifyIcon(user, 18.0)),
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.only(top: 8.0),
                    alignment: Alignment.center,
                    child: Text(infoText,
                        style: theme.themeData.textTheme.title
                            .copyWith(color: Colors.white)),
                  ),
                ],
              )
            ],
          )),
      floating: false,
      pinned: true,
      actions: actions,
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
        showDetailTime: showDetailTime,
        scroller: this,
        onTap: () => onStoryTap(context, story),
      );
    } else if (fetchType == fetchTypeFans) {
      UserInfo fan = object as UserInfo;

      item = UserItem(
        user: fan,
        onTap: () => onUserTap(context, fan),
      );
    } else if (fetchType == fetchTypeFollow) {
      UserInfo follow = object as UserInfo;

      item = UserItem(
        user: follow,
        onTap: () => onUserTap(context, follow),
      );
    } else if (fetchType == fetchTypeDigest) {
      Story digest = object as Story;

      item = StoryItem(
        story: digest,
        showDetailTime: showDetailTime,
        scroller: this,
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
          child: GestureDetector(
            child: Text(
              "错误：$error。请稍后点击此处重试",
              style: const TextStyle(color: Colors.white),
            ),
            onTap: () => handleFetchUserInfo(context),
          )));
    }

    if (profile != null) {
      list.add(Container(
          height: 48.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              {'title': '粉丝', 'num': profile.user.fansnum, 'type': 1},
              {'title': '关注', 'num': profile.user.followuidnum, 'type': 2},
              {'title': '主题', 'num': profile.user.threads, 'type': 0},
              {'title': '精华', 'num': profile.user.digestposts, 'type': 3},
            ]
                .map(
                  (item) => Expanded(
                        child: FlatButton(
                          color: theme.pageColor,
                          shape: OutlineInputBorder(
                            borderSide: BorderSide(color: theme.textColor),
                          ),
                          disabledColor: theme.mainColor,
                          disabledTextColor: theme.lightTextColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(item['title']),
                              Text("${item['num'] ?? 0}")
                            ],
                          ),
                          onPressed: fetchType != item['type']
                              ? () => changeFetchType(item['type'])
                              : null,
                        ),
                      ),
                )
                .toList(),
          )));
    }
    return Column(
      children: list,
    );
  }

  @override
  APIRequest get fetchFromScratchRequest {
    if (getFetchCount(fetchType) == 0) {
      return null;
    }

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return ProfileNewRequest(completer, user.uid, fetchType);
  }

  @override
  APIRequest get loadMoreRequest {
    if (getFetchCount(fetchType) == 0) {
      return null;
    }

    final result = getFetchResult(fetchType);
    int nexttime = result?.nexttime;

    if (nexttime == null || nexttime == 0) {
      return null;
    }

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return ProfileLoadMoreRequest(completer, user.uid, fetchType, nexttime);
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
      return super.fillupForEmptyView(context);
    }
  }

  @override
  Widget buildListView(BuildContext context) {
    if (profile == null) {
      if (storeLoading != true && lastError == null) {
        handleFetchUserInfo(context);
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<ScrollNotification>(
        child: super.buildListView(context),
        onNotification: (notification) {
          state.setOffset(notification.metrics.pixels);
        },
      ),
    );
  }

  void handleFetchUserInfo(BuildContext context) {
    if (state.user.uid != 0) {
      dispatchAction(context)(UserInfoRequest(null, state.user.uid));
    }
  }

  void scrollToTop(context) {
    _scrollController.jumpTo(0.1); // 0.1 to avoid pull-to-refresh is triggered
    _scrollController.jumpTo(0.0); // then move to top
  }
}
