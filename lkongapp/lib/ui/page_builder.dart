import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/ui/theme_widget.dart';

class PageBuilder extends StatelessWidget {
  PageBuilder({Key key}) : super(key: key);

  final pageController = PageController();
  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return buildThemeWidget(context, PageModel.fromStore, (vm) {
      var viewModel = vm as PageModel;
      Color mainColor = htmlColor(viewModel.theme.colors['main']);
      Color pageColor = htmlColor(viewModel.theme.colors['paper']);

      return Scaffold(
        body: PageView(
          children: [
            Container(
              color: pageColor,
              child: Text('Home'),
            ),
            Container(
              color: pageColor,
              child: Text('Searh'),
            ),
            Container(
              color: pageColor,
              child: Text('Add'),
            ),
            Container(
              color: pageColor,
              child: Text('Feed'),
            ),
            Container(
              color: pageColor,
              child: Text('User'),
            ),
          ],
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (page) => viewModel.onPageChanged(context, page),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: mainColor),
                title: Container(),
                backgroundColor: pageColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, color: mainColor),
                title: Container(),
                backgroundColor: pageColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle, color: mainColor),
                title: Container(),
                backgroundColor: pageColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.star, color: mainColor),
                title: Container(),
                backgroundColor: pageColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, color: mainColor),
                title: Container(),
                backgroundColor: pageColor),
          ],
          onTap: navigationTapped,
          currentIndex: viewModel.page,
          type: BottomNavigationBarType.fixed,
        ),
      );
    });
  }
}

class PageModel extends ThemeWidgetModel {
  int page;
  final Function(BuildContext, int) onPageChanged;

  PageModel({
    @required this.page,
    @required AppTheme theme,
    @required this.onPageChanged,
  }) : super(theme: theme);

  static PageModel fromStore(Store<AppState> store) {
    return PageModel(
        page: store.state.uiState.homePageIndex,
        theme: ThemeWidgetModel.selectTheme(store),
        onPageChanged: (BuildContext context, int value) {
          store.dispatch(UIChange((b) => b..homePageIndex = value));
        });
  }
}
