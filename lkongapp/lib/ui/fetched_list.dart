import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lkongapp/ui/grouped_list.dart';

import 'package:lkongapp/ui/modeled_app.dart';

import 'package:lkongapp/utils/utils.dart';
import 'package:lkongapp/actions/actions.dart';

abstract class FetchedListModel extends GroupedListModel {
  var _scrollController = ScrollController();

  APIRequest get refreshRequest;
  APIRequest get fetchFromScratchRequest;
  APIRequest get loadMoreRequest;

  bool get loading;
  String get lastError;

  // Total count of items, including different sections
  int get itemCount;

  //Override this if you has more than 1 sections.
  int get sectionCount => 1;

  @override
  int get numberOfSections {
    return sectionCount;
  }

  @override
  int countOfItemsInSection({int section}) {
    //By default values for only 1 data section
    if (sectionCount == 1) {
      int extraCell = loadMoreRequest == null ? 0 : 1;
      if (section == 0) {
        return itemCount + extraCell;
      }

      assert(true, "Section $section is not defined");
      return 0;
    }

    assert(true, "Should Override countOfItemsInSection");

    return null;
  }

  @override
  Widget cellForSectionAndIndex(BuildContext context,
      {int section, int index}) {
    if (sectionCount == 1) {
      Widget item;

      if (section == 0) {
        if (index < itemCount) {
          item = createListItem(context, index);
        } else {
          if (!loading && lastError == null) {
            handleLoadMore(context);
          }
          item = Container(
              height: 84.0,
              child: Center(
                  child: lastError == null
                      ? CircularProgressIndicator()
                      : RaisedButton(
                          child: const Text('点击重试'),
                          onPressed: () {
                            handleLoadMore(context);
                          },
                        )));
        }
      } else {
        assert(item == null, "Section $section is not defined");
      }

      return Column(children: <Widget>[
        item,
        Divider(
          height: 12.0,
        ),
      ]);
    }

    assert(true, "Should Override cellForSectionAndIndex");
    return null;
  }

  @override
  Widget headerForSection(BuildContext context, {int section}) {
    return null;
  }

  @override
  SliverAppBar get appBar => null;

  Future<Null> handleRefresh(BuildContext context) async {
    dispatchAction(context)(refreshRequest);
  }

  Future<Null> handleFetchFromScratch(BuildContext context) async {
    dispatchAction(context)(fetchFromScratchRequest);
  }

  Future<Null> handleLoadMore(BuildContext context) async {
    var request = loadMoreRequest;
    if (request != null) {
      dispatchAction(context)(request);
    }
  }

  //To be overriden
  void listIsReady(BuildContext context);
  Widget createListItem(BuildContext context, int index);

  Widget buildListView(BuildContext context) {
    if (itemCount == null || itemCount == 0) {
      if (loading == true) {
        return Center(child: CircularProgressIndicator());
      } else if (lastError == null) {
        handleFetchFromScratch(context);
        return Container();
      }
    }

    listIsReady(context);

    Widget listView;
    // if (lastError == null) {
    listView = super.buildGroupedListView(context);
    // } else {
    //   final theme = LKModeledApp.modelOf(context).theme;

    //   listView = SingleChildScrollView(
    //     controller: _scrollController,
    //     child: Container(
    //       height: MediaQuery.of(context).size.height,
    //       child: Text(
    //         "网络错误：\n$lastError\n\n请稍后下拉更新重试",
    //         style: theme.themeData.textTheme.subhead
    //             .copyWith(color: Colors.red, fontSize: 24.0),
    //       ),
    //     ),
    //   );
    // }
    return RefreshIndicator(
        onRefresh: () => handleRefresh(context), child: listView);
  }
}
