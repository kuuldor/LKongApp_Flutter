import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/atme_screen.dart';
import 'package:lkongapp/ui/favorite_screen.dart';
import 'package:lkongapp/ui/home_list.dart';
import 'package:lkongapp/ui/hot_digest.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/search_screen.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/ui/forum_list.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/connected_widget.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

const pages = [
  {
    "title": '首页',
    "icon": Icons.home,
  },
  {
    "title": '版块',
    "icon": Icons.dashboard,
  },
  {
    "title": '热门',
    "icon": Icons.whatshot,
  },
  {
    "title": '通知',
    "icon": Icons.notifications,
  },
  {
    "title": '搜索',
    "icon": Icons.search,
  },
];

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  final pageController = PageController();
  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    final theme = LKModeledApp.modelOf(context).theme;
    return buildConnectedWidget<PageModel>(context, PageModel.fromStore,
        (viewModel) {
      if (!viewModel.isAuthed) {
        //viewModel.showLoginScreen(context);
      }

      return Scaffold(
        drawer: AppDrawerBuilder(),
        body: PageView(
          children: [
            Container(
              child: HomeList(),
            ),
            Container(
              child: ForumList(),
            ),
            Container(
              child: HotDigest(),
            ),
            Container(
              child: AtMeScreen(),
            ),
            Container(
              child: SearchScreen(),
            ),
          ],
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (page) => viewModel.onPageChanged(context, page),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: pages.map((Map page) {
            String title = page["title"];
            IconData icon = page["icon"];
            Widget iconWidget = Icon(icon);

            if (title == '通知') {
              if (viewModel.noticeCount > 0) {
                iconWidget = Stack(
                  children: <Widget>[
                    iconWidget,
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          '${viewModel.noticeCount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                );
              }
            }

            return BottomNavigationBarItem(
              icon: iconWidget,
              title: Text(title),
            );
          }).toList(),
          onTap: navigationTapped,
          currentIndex: viewModel.page,
          type: BottomNavigationBarType.fixed,
        ),
      );
    });
  }
}

class PageModel {
  final int page;
  final bool isAuthed;
  final CheckNoticeResult notice;
  final Function(BuildContext, int) onPageChanged;
  final Function(BuildContext) showLoginScreen;

  @override
  bool operator ==(other) {
    return other is PageModel &&
        page == other.page &&
        isAuthed == other.isAuthed &&
        notice == other.notice;
  }

  @override
  int get hashCode => hash3(page, isAuthed, notice);

  PageModel({
    @required this.page,
    @required this.isAuthed,
    @required this.onPageChanged,
    @required this.showLoginScreen,
    @required this.notice,
  });

  int get noticeCount => notice?.newNotice?.totalCount ?? 0;

  static PageModel fromStore(Store<AppState> store) {
    return PageModel(
      page: store.state.uiState.homePageIndex,
      isAuthed: store.state.persistState.authState.isAuthed,
      onPageChanged: (BuildContext context, int value) {
        store.dispatch(UIChange((b) => b..homePageIndex = value));
      },
      showLoginScreen: (BuildContext context) {
        Future(() {
          store.dispatch(UINavigationPush(context, LKongAppRoutes.login, true));
        });
      },
      notice: selectUserData(store)?.newNotice,
    );
  }
}
