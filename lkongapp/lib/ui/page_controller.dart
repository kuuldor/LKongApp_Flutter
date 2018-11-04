import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

class PageControl extends StatelessWidget {
  PageControl({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PageModel>(
      converter: PageModel.fromStore,
      builder: (context, vm) {
        return Page(
          viewModel: vm,
        );
      },
    );
  }
}

class PageModel {
  int page;
  final Function(BuildContext, int) onPageChanged;

  PageModel({
    @required this.page,
    @required this.onPageChanged,
  });

  static PageModel fromStore(Store<AppState> store) {
    return PageModel(
        page: store.state.uiState.homePageIndex,
        onPageChanged: (BuildContext context, int value) {
          store.dispatch(UIChange((b) => b..homePageIndex = value));
        });
  }
}

class Page extends StatefulWidget {
  final PageModel viewModel;
  Page({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var viewModel = widget.viewModel;

    return Scaffold(
      body: PageView(
        children: [
          Container(
            color: Colors.white,
            child: Text('Home'),
          ),
          Container(
            color: Colors.white,
            child: Text('Searh'),
          ),
          Container(
            color: Colors.white,
            child: Text('Add'),
          ),
          Container(
            color: Colors.white,
            child: Text('Feed'),
          ),
          Container(
            color: Colors.white,
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
              icon: Icon(Icons.home, color: Colors.grey),
              title: Container(),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.grey),
              title: Container(),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle, color: Colors.grey),
              title: Container(),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.star, color: Colors.grey),
              title: Container(),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, color: Colors.grey),
              title: Container(),
              backgroundColor: Colors.white),
        ],
        onTap: navigationTapped,
        currentIndex: viewModel.page,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }
}
