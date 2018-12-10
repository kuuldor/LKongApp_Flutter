import 'package:flutter/material.dart';
import 'package:lkongapp/ui/atme_screen.dart';
import 'package:lkongapp/ui/favorite_screen.dart';
import 'package:lkongapp/ui/home_list.dart';
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
    "title": '收藏',
    "icon": Icons.bookmark,
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
              child: FavoriteScreen(),
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

            return BottomNavigationBarItem(
              icon: Icon(
                icon,
              ),
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
  final Function(BuildContext, int) onPageChanged;
  final Function(BuildContext) showLoginScreen;

  @override
  bool operator ==(other) {
    return other is PageModel &&
        page == other.page &&
        isAuthed == other.isAuthed;
  }

  @override
  int get hashCode => hash2(page, isAuthed);

  PageModel({
    @required this.page,
    @required this.isAuthed,
    @required this.onPageChanged,
    @required this.showLoginScreen,
  });

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
    );
  }
}
