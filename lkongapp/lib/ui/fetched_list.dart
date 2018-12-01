import 'dart:async';

import 'package:flutter/material.dart';

import 'package:lkongapp/ui/modeled_app.dart';

import 'package:lkongapp/utils/utils.dart';
import 'package:lkongapp/actions/actions.dart';

abstract class FetchedListModel<T> {
  var _scrollController = ScrollController();

  APIRequest get refreshRequest;
  APIRequest get fetchFromScratchRequest;
  APIRequest get loadMoreRequest;

  bool get loading;
  String get lastError;
  List<T> get list;

  Future<Null> _handleRefresh(BuildContext context) async {
    if (lastError == null) {
      dispatchAction(context)(refreshRequest);
    } else {
      dispatchAction(context)(fetchFromScratchRequest);
    }
  }

  Future<Null> _handleFetchFromScratch(BuildContext context) async {
    dispatchAction(context)(fetchFromScratchRequest);
  }

  Future<Null> _handleLoadMore(BuildContext context) async {
    var request = loadMoreRequest;
    if (request != null) {
      dispatchAction(context)(request);
    }
  }

  //To be overriden
  void listIsReady(BuildContext context);
  Widget createListItem(BuildContext context, T item);

  Widget buildListView(BuildContext context) {
    int itemCount = list?.length;
    if (itemCount == null || itemCount == 0) {
      if (loading) {
        return Center(child: CircularProgressIndicator());
      } else if (lastError == null) {
        _handleFetchFromScratch(context);
        return Container();
      }
    }

    listIsReady(context);

    final theme = LKModeledApp.modelOf(context).theme;

    int extraLoadMore = loadMoreRequest == null ? 0 : 1;

    Widget listView;
    if (lastError == null) {
      listView = ListView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: itemCount + extraLoadMore,
          itemBuilder: (BuildContext context, index) {
            Widget item;
            if (index < itemCount) {
              var obj = list[index];
              item = createListItem(context, obj);
            } else {
              if (!loading && lastError == null) {
                _handleLoadMore(context);
              }
              item = Container(
                  height: 84.0,
                  child: Center(child: CircularProgressIndicator()));
            }

            return Column(children: <Widget>[
              item,
              Divider(
                height: 12.0,
              ),
            ]);
          });
    } else {
      listView = SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Text(
            "网络错误：\n$lastError\n\n请稍后下拉更新重试",
            style: theme.themeData.textTheme.subhead
                .copyWith(color: Colors.red, fontSize: 24.0),
          ),
        ),
      );
    }
    return RefreshIndicator(
        onRefresh: () => _handleRefresh(context), child: listView);
  }
}
