import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      converter: HomeViewModel.fromStore,
      builder: (context, vm) {
        return HomeView(
          viewModel: vm,
        );
      },
    );
  }
}

class HomeViewModel {
  int page;
  AppTheme theme;
  final Function(BuildContext, int) onPageChanged;

  HomeViewModel({
    @required this.page,
    @required this.theme,
    @required this.onPageChanged,
  });

  static HomeViewModel fromStore(Store<AppState> store) {
    int themeIndex = store.state.appConfig.setting.nightMode
        ? store.state.appConfig.setting.themeSetting.night
        : store.state.appConfig.setting.themeSetting.day;

    return HomeViewModel(
        page: store.state.uiState.homePageIndex,
        theme: store.state.appConfig.setting.themeSetting.theme[themeIndex],
        onPageChanged: (BuildContext context, int value) {
          store.dispatch(UIChange((b) => b..homePageIndex = value));
        });
  }
}

class HomeView extends StatefulWidget {
  final HomeViewModel viewModel;
  HomeView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _HomeViewState createState() => new _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var viewModel = widget.viewModel;
    Color mainColor = htmlColor(viewModel.theme.colors['main']);
    Color pageColor = htmlColor(viewModel.theme.colors['paper']);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: mainColor,
      ),
      drawer: AppDrawerBuilder(),
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
        type: BottomNavigationBarType.shifting,
      ),
    );
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }
}
