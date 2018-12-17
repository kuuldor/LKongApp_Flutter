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

  bool get initLoaded;

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

      assert(false, "Section $section is not defined");
      return 0;
    }

    assert(false, "Should Override countOfItemsInSection");

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

    assert(false, "Should Override cellForSectionAndIndex");
    return null;
  }

  @override
  Widget headerForSection(BuildContext context, {int section}) {
    return null;
  }

  @override
  SliverAppBar buildAppBar(BuildContext context) => null;

  Future<Null> handleRefresh(BuildContext context) async {
    var request = refreshRequest;
    if (request != null) {
      dispatchAction(context)(request);
    }
  }

  Future<Null> handleFetchFromScratch(BuildContext context) async {
    var request = fetchFromScratchRequest;
    if (request != null) {
      dispatchAction(context)(request);
    }
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

  @override
  Widget fillupForEmptyView(BuildContext context) {
    if (!initLoaded && loading == true) {
      return Center(child: CircularProgressIndicator());
    } else {
      return null;
    }
  }

  Widget buildListView(BuildContext context) {
    if (!initLoaded && loading != true && lastError == null) {
      handleFetchFromScratch(context);
    }

    listIsReady(context);

    Widget listView;
    listView = super.buildGroupedListView(context);

    if (refreshRequest == null) {
      return listView;
    } else {
      return RefreshIndicator(
        backgroundColor: Colors.white70,
          onRefresh: () => handleRefresh(context), child: listView);
    }
  }
}
