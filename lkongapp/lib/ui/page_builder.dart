import 'package:flutter/material.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/story_list.dart';
import 'package:path/path.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/ui/connected_widget.dart';

const pages = [
  {
    "title": '首页',
    "icon": Icons.home,
  },
  {
    "title": '板块',
    "icon": Icons.dashboard,
  },
  {
    "title": '书签',
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

class PageBuilder extends StatelessWidget {
  PageBuilder({Key key}) : super(key: key);

  final pageController = PageController();
  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget<PageModel>(context, PageModel.fromStore,
        (viewModel) {
      User user = LKModeledApp.modelOf(context).user;
      return Scaffold(
        body: PageView(
          children: [
            Container(
              child: user != null ? StoryList() : Container(),
            ),
            Container(
              child: Text('板块'),
            ),
            Container(
              child: Text('书签'),
            ),
            Container(
              child: Text('通知'),
            ),
            Container(
              child: Text('搜索'),
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

  final Function(BuildContext, int) onPageChanged;

  PageModel({
    @required this.page,
    @required this.onPageChanged,
  });

  @override
  bool operator ==(other) {
    return other is PageModel && page == other.page;
  }

  @override
  int get hashCode {
    return page.hashCode;
  }

  static PageModel fromStore(Store<AppState> store) {
    return PageModel(
        page: store.state.uiState.homePageIndex,
        onPageChanged: (BuildContext context, int value) {
          store.dispatch(UIChange((b) => b..homePageIndex = value));
        });
  }
}
