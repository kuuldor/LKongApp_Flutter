import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/fetched_list.dart';
import 'package:lkongapp/ui/forum_story.dart';
import 'package:lkongapp/ui/items/forum_item.dart';
import 'package:lkongapp/ui/items/item_wrapper.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/tools/drawer_button.dart';
import 'package:lkongapp/ui/tools/item_handler.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

import 'package:lkongapp/ui/connected_widget.dart';

class HotDigest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget(context, HotDigestModel.fromStore, (viewModel) {
      return viewModel.buildListView(context);
    });
  }
}

class HotDigestModel extends FetchedListModel {
  final BuiltList<HotDigestResult> repo;
  final List<Forum> followedForums;
  final bool loading;
  final String lastError;

  @override
  SliverAppBar buildAppBar(BuildContext context) => SliverAppBar(
        leading: DrawerButton(),
        title: GestureDetector(
          child: Text("热门",
              style:
                  Theme.of(context).textTheme.title.apply(color: Colors.white)),
          onTap: () => scrollToTop(context),
        ),
        floating: false,
        pinned: true,
      );

  @override
  bool operator ==(other) {
    return other is HotDigestModel &&
        repo == other.repo &&
        followedForums == other.followedForums &&
        loading == other.loading &&
        lastError == other.lastError;
  }

  @override
  int get hashCode => hashObjects([repo, followedForums, loading, lastError]);

  HotDigestModel({
    @required this.repo,
    @required this.followedForums,
    @required this.loading,
    @required this.lastError,
  });

  @override
  int get itemCount {
    int cnt = 0;
    repo.forEach((result) => cnt += result.thread.length);
    return cnt;
  }

  @override
  APIRequest get fetchFromScratchRequest =>
      HotDigestRequest(null, followedForums);

  @override
  APIRequest get loadMoreRequest => null;

  @override
  APIRequest get refreshRequest => HotDigestRequest(null, followedForums);

  @override
  Future<Null> handleRefresh(BuildContext context) {
    final Completer<String> completer = Completer<String>();
    dispatchAction(context)(HotDigestRequest(completer, followedForums));
    return completer.future.then((_) {});
  }

  static HotDigestModel fromStore(Store<AppState> store) {
    final userData = selectUserData(store);
    final forumInfo = store.state.uiState.content.forumInfo;
    final followed = userData?.followList?.fid;

    return HotDigestModel(
      repo: store.state.uiState.content.hotDigest,
      followedForums: List<Forum>.from(forumInfo.forums
          .where((forum) => followed?.contains("${forum.fid}") == true)),
      loading: store.state.uiState.content.loading,
      lastError: store.state.uiState.content.lastError,
    );
  }

  Widget createHotDigestItem(BuildContext context, Thread thread) {
    final theme = LKModeledApp.modelOf(context).theme;
    TextStyle titleStyle = theme.titleStyle;

    return ListTile(
      title: Text(
        thread.subject,
        style: titleStyle,
      ),
      onTap: () => openThreadView(context, thread.tid),
    );
  }

  @override
  int get numberOfSections => repo.length;

  @override
  int countOfItemsInSection({int section}) {
    int count = repo.elementAt(section).thread.length;
    return count;
  }

  @override
  Widget cellForSectionAndIndex(BuildContext context,
      {int section, int index}) {
    BuiltList<Thread> threads = repo.elementAt(section).thread;

    if (threads != null && index >= 0 && index < threads.length) {
      Widget item = createHotDigestItem(context, threads[index]);

      return wrapItem(context, item);
    }

    return null;
  }

  @override
  Widget headerForSection(BuildContext context, {int section}) {
    String headerText = repo.elementAt(section).title;

    if (headerText != null) {
      return Container(
          color: Colors.grey[500].withAlpha(240),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "$headerText",
            style: const TextStyle(color: Colors.white),
          ));
    }

    return null;
  }

  @override
  Widget createListItem(BuildContext context, int index) {
    // No need to implement this. Only used by one-section list
    return null;
  }

  @override
  bool get initLoaded => repo.length == followedForums.length + 2;

  @override
  void listIsReady(BuildContext context) {}
}
