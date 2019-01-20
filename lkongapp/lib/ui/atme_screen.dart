import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/fetched_list.dart';
import 'package:lkongapp/ui/items/message_items.dart';
import 'package:lkongapp/ui/items/story_item.dart';
import 'package:lkongapp/ui/story_screen.dart';
import 'package:lkongapp/ui/tools/drawer_button.dart';
import 'package:lkongapp/ui/tools/icon_message.dart';
import 'package:lkongapp/ui/tools/menu_choice.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/ui/items/item_wrapper.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/ui/connected_widget.dart';

import 'story_list.dart';

class AtMeScreen extends StatefulWidget {
  const AtMeScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AtMeScreenState();
  }
}

const int atMeScreenType = 0;
const int notifScreenType = 1;
const int rateScreenType = 2;
const int messageScreenType = 3;

class AtMeScreenState extends StoryListState<AtMeScreen> {
  int type;
  AtMeScreenState();

  void changeScreenType(int newType) {
    setState(() {
      type = newType;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (type == null) {
      int screenType =
          StoreProvider.of<AppState>(context).state.uiState.atMeScreenType;
      changeScreenType(screenType);
    }
    return buildConnectedWidget<NotifScreenModel>(
        context, NotifScreenModel.fromStateAndStore(this),
        (NotifScreenModel viewModel) {
      return viewModel.buildNotifView(context);
    });
  }
}

final allMenus = const <Choice>[
  const Choice(
      title: '@我', icon: Icons.alternate_email, action: MenuAction.atMe),
  const Choice(
      title: '通知', icon: Icons.notifications, action: MenuAction.notice),
  const Choice(title: '评分', icon: Icons.thumb_up, action: MenuAction.ratelog),
  const Choice(title: '私信', icon: Icons.mail, action: MenuAction.pm),
];

abstract class NotifScreenModel extends StoryListModel {
  final FetchList<Story> storyList;
  final FetchList<Notice> noticeList;
  final FetchList<Ratelog> ratelogList;
  final FetchList<PrivateMessage> pmList;

  final bool loading;
  final String lastError;
  final int uid;
  final bool showDetailTime;
  final AtMeScreenState state;

  NotifScreenModel({
    @required Store<AppState> store,
    @required this.state,
    @required this.loading,
    @required this.lastError,
    @required this.uid,
    this.showDetailTime,
    this.storyList,
    this.noticeList,
    this.ratelogList,
    this.pmList,
  }) : super(store);

  List<Choice> filterMenus() {
    var menus = List<Choice>.from(allMenus);
    menus.removeAt(state.type);
    return menus;
  }

  void menuSelected(BuildContext context, Choice choice) {
    print("Menu Selcected for ${choice.title}");

    int newType;
    switch (choice.action) {
      case MenuAction.atMe:
        newType = 0;
        break;
      case MenuAction.notice:
        newType = 1;
        break;
      case MenuAction.ratelog:
        newType = 2;
        break;
      case MenuAction.pm:
        newType = 3;
        break;

      default:
        break;
    }

    if (newType != null) {
      state.changeScreenType(newType);
      dispatchAction(context)(UIChange((b) => b..atMeScreenType = newType));
    }
  }

  SliverAppBar buildAppBar(BuildContext context) {
    List<Choice> menus = filterMenus();
    var actions = <Widget>[];

    if (menus.length > 0) {
      actions.add(
        PopupMenuButton<Choice>(
          onSelected: (choice) => menuSelected(context, choice),
          itemBuilder: (BuildContext context) {
            return menus.map((Choice menuItem) {
              return PopupMenuItem<Choice>(
                value: menuItem,
                child: Text(menuItem.title),
              );
            }).toList();
          },
        ),
      );
    }
    return SliverAppBar(
      leading: DrawerButton(),
      title: getTitle(context),
      actions: actions,
      floating: false,
      pinned: true,
    );
  }

  static fromStateAndStore(AtMeScreenState state) {
    NotifScreenModel Function(Store<AppState> store) modelCreator;
    modelCreator = (Store<AppState> store) {
      NotifScreenModel model;
      switch (state.type) {
        case atMeScreenType:
          model = AtMeScreenModel.fromStateAndStore(state)(store);
          break;
        case notifScreenType:
          model = NoticeScreenModel.fromStateAndStore(state)(store);
          break;
        case rateScreenType:
          model = RatelogScreenModel.fromStateAndStore(state)(store);
          break;
        case messageScreenType:
          model = PMScreenModel.fromStateAndStore(state)(store);
          break;
        default:
          break;
      }
      return model;
    };
    return modelCreator;
  }

  Widget buildNotifView(BuildContext context) {
    return buildListView(context);
  }

  Widget getTitle(BuildContext context);
}

class AtMeScreenModel extends NotifScreenModel {
  AtMeScreenModel({
    @required Store<AppState> store,
    @required bool loading,
    @required String lastError,
    @required int uid,
    @required bool showDetailTime,
    @required AtMeScreenState state,
    @required FetchList<Story> storyList,
  }) : super(
          store: store,
          loading: loading,
          lastError: lastError,
          uid: uid,
          showDetailTime: showDetailTime,
          state: state,
          storyList: storyList,
        );

  @override
  Widget Function(BuildContext, Widget) get wrapCell => wrapItemAsCard;

  Widget getTitle(BuildContext context) => GestureDetector(
        child: Text("@我        ",
            style:
                Theme.of(context).textTheme.title.apply(color: Colors.white)),
        onTap: () => scrollToTop(context),
      );

  static final fromStateAndStore =
      (AtMeScreenState state) => (Store<AppState> store) => AtMeScreenModel(
            store: store,
            loading: store.state.uiState.content.userData[selectUID(store)]
                ?.atMe?.loading,
            lastError: store.state.uiState.content.userData[selectUID(store)]
                ?.atMe?.lastError,
            storyList:
                store.state.uiState.content.userData[selectUID(store)]?.atMe,
            uid: selectUID(store),
            state: state,
            showDetailTime: selectSetting(store).showDetailTime,
          );

  @override
  APIRequest get fetchFromScratchRequest {
    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return GetMyAtsNewRequest(completer, uid, 0, 0);
  }

  @override
  APIRequest get loadMoreRequest {
    if (storyList == null || storyList.nexttime == 0) {
      return null;
    }

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return GetMyAtsLoadMoreRequest(completer, uid, storyList.nexttime);
  }

  @override
  APIRequest get refreshRequest {
    if (storyList == null || storyList.current == 0) {
      return null;
    }

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return GetMyAtsRefreshRequest(completer, uid, storyList.current);
  }

  @override
  APIRequest get checkNewRequest => null;

  @override
  Widget buildListView(BuildContext context) {
    if (uid == -1) {
      return super.buildGroupedListView(context);
    }
    return super.buildListView(context);
  }
}

class NoticeScreenModel extends NotifScreenModel {
  NoticeScreenModel({
    @required Store<AppState> store,
    @required bool loading,
    @required String lastError,
    @required int uid,
    @required AtMeScreenState state,
    @required FetchList<Notice> noticeList,
  }) : super(
          store: store,
          loading: loading,
          lastError: lastError,
          uid: uid,
          state: state,
          noticeList: noticeList,
        );

  @override
  Widget Function(BuildContext, Widget) get wrapCell => wrapItem;

  Widget getTitle(BuildContext context) => GestureDetector(
        child: Text("通知        ",
            style:
                Theme.of(context).textTheme.title.apply(color: Colors.white)),
        onTap: () => scrollToTop(context),
      );

  static final fromStateAndStore =
      (AtMeScreenState state) => (Store<AppState> store) => NoticeScreenModel(
            store: store,
            loading: store.state.uiState.content.userData[selectUID(store)]
                ?.notice?.loading,
            lastError: store.state.uiState.content.userData[selectUID(store)]
                ?.notice?.lastError,
            noticeList:
                store.state.uiState.content.userData[selectUID(store)]?.notice,
            uid: selectUID(store),
            state: state,
          );

  @override
  APIRequest get fetchFromScratchRequest {
    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return GetNoticeNewRequest(completer, uid, 0, 0);
  }

  @override
  APIRequest get loadMoreRequest {
    if (noticeList == null || noticeList.nexttime == 0) {
      return null;
    }

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return GetNoticeLoadMoreRequest(completer, uid, noticeList.nexttime);
  }

  @override
  APIRequest get refreshRequest {
    if (noticeList == null || noticeList.current == 0) {
      return null;
    }

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return GetNoticeRefreshRequest(completer, uid, noticeList.current);
  }

  @override
  Widget createListItem(BuildContext context, int index) {
    Notice notice = noticeList.data[index];

    var item = NoticeItem(notice: notice);

    return item;
  }

  @override
  bool get initLoaded =>
      noticeList != null &&
      (noticeList.current != 0 || noticeList.data.length > 0);

  @override
  int get itemCount => noticeList?.data?.length ?? 0;

  @override
  APIRequest get checkNewRequest => null;
}

class RatelogScreenModel extends NotifScreenModel {
  RatelogScreenModel({
    @required Store<AppState> store,
    @required bool loading,
    @required String lastError,
    @required int uid,
    @required AtMeScreenState state,
    @required FetchList<Ratelog> ratelogList,
  }) : super(
          store: store,
          loading: loading,
          lastError: lastError,
          uid: uid,
          state: state,
          ratelogList: ratelogList,
        );

  @override
  Widget Function(BuildContext, Widget) get wrapCell => wrapItem;

  Widget getTitle(BuildContext context) => GestureDetector(
        child: Text("评分        ",
            style:
                Theme.of(context).textTheme.title.apply(color: Colors.white)),
        onTap: () => scrollToTop(context),
      );

  static final fromStateAndStore =
      (AtMeScreenState state) => (Store<AppState> store) => RatelogScreenModel(
            store: store,
            loading: store.state.uiState.content.userData[selectUID(store)]
                ?.ratelog?.loading,
            lastError: store.state.uiState.content.userData[selectUID(store)]
                ?.ratelog?.lastError,
            ratelogList:
                store.state.uiState.content.userData[selectUID(store)]?.ratelog,
            uid: selectUID(store),
            state: state,
          );

  @override
  APIRequest get fetchFromScratchRequest {
    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return GetRatelogNewRequest(completer, uid, 0, 0);
  }

  @override
  APIRequest get loadMoreRequest {
    if (ratelogList == null || ratelogList.nexttime == 0) {
      return null;
    }

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return GetRatelogLoadMoreRequest(completer, uid, ratelogList.nexttime);
  }

  @override
  APIRequest get refreshRequest {
    if (ratelogList == null || ratelogList.current == 0) {
      return null;
    }

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return GetRatelogRefreshRequest(completer, uid, ratelogList.current);
  }

  @override
  Widget createListItem(BuildContext context, int index) {
    Ratelog ratelog = ratelogList.data[index];

    var item = RatelogItem(ratelog: ratelog);

    return item;
  }

  @override
  bool get initLoaded =>
      ratelogList != null &&
      (ratelogList.current != 0 || ratelogList.data.length > 0);

  @override
  int get itemCount => ratelogList?.data?.length ?? 0;

  @override
  APIRequest get checkNewRequest => null;
}

class PMScreenModel extends NotifScreenModel {
  PMScreenModel({
    @required Store<AppState> store,
    @required bool loading,
    @required String lastError,
    @required int uid,
    @required AtMeScreenState state,
    @required FetchList<PrivateMessage> pmList,
  }) : super(
          store: store,
          loading: loading,
          lastError: lastError,
          uid: uid,
          state: state,
          pmList: pmList,
        );

  @override
  Widget Function(BuildContext, Widget) get wrapCell => wrapItem;

  Widget getTitle(BuildContext context) => GestureDetector(
        child: Text("私信        ",
            style:
                Theme.of(context).textTheme.title.apply(color: Colors.white)),
        onTap: () => scrollToTop(context),
      );

  static final fromStateAndStore =
      (AtMeScreenState state) => (Store<AppState> store) => PMScreenModel(
            store: store,
            loading: store
                .state.uiState.content.userData[selectUID(store)]?.pm?.loading,
            lastError: store.state.uiState.content.userData[selectUID(store)]
                ?.pm?.lastError,
            pmList: store.state.uiState.content.userData[selectUID(store)]?.pm,
            uid: selectUID(store),
            state: state,
          );

  @override
  APIRequest get fetchFromScratchRequest {
    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return GetPMNewRequest(completer, uid, 0, 0);
  }

  @override
  APIRequest get loadMoreRequest {
    if (pmList == null || pmList.nexttime == 0) {
      return null;
    }

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return GetPMLoadMoreRequest(completer, uid, pmList.nexttime);
  }

  @override
  APIRequest get refreshRequest {
    if (pmList == null || pmList.current == 0) {
      return null;
    }

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return GetPMRefreshRequest(completer, uid, pmList.current);
  }

  @override
  Widget createListItem(BuildContext context, int index) {
    PrivateMessage pm = pmList.data[index];

    var item = PMItem(pm: pm);

    return item;
  }

  @override
  bool get initLoaded =>
      pmList != null && (pmList.current != 0 || pmList.data.length > 0);

  @override
  int get itemCount => pmList?.data?.length ?? 0;

  @override
  APIRequest get checkNewRequest => null;
}
