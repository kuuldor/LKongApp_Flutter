import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/items/story_item.dart';
import 'package:lkongapp/ui/story_screen.dart';
import 'package:lkongapp/ui/tools/drawer_button.dart';
import 'package:lkongapp/ui/tools/icon_message.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/ui/connected_widget.dart';

import 'story_list.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FavoriteScreenState();
  }
}

class FavoriteScreenState extends StoryListState<FavoriteScreen> {
  FavoriteScreenState();
  @override
  Widget build(BuildContext context) {
    return buildWidgetWithVMFactory(
      context,
      FavoriteScreenModel.fromStateAndStore(this),
    );
  }
}

class FavoriteScreenModel extends StoryListModel {
  final StoryFetchList storyList;
  final bool loading;
  final String lastError;
  final int uid;

  FavoriteScreenModel({
    @required this.loading,
    @required this.lastError,
    @required this.storyList,
    @required this.uid,
  });

  @override
  SliverAppBar get appBar => SliverAppBar(
        leading: DrawerButton(),
        title: Text('收藏'),
        floating: false,
        pinned: true,
      );

  static final fromStateAndStore = (FavoriteScreenState state) =>
      (Store<AppState> store) => FavoriteScreenModel(
            loading: store.state.uiState.content.userData[selectUID(store)]
                .favorites?.loading,
            lastError: store.state.uiState.content.userData[selectUID(store)]
                .favorites?.lastError,
            storyList: store
                .state.uiState.content.userData[selectUID(store)].favorites,
            uid: selectUID(store),
          );

  @override
  APIRequest get fetchFromScratchRequest {
    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {});
    return GetMyFavoritesNewRequest(completer, uid, 0, 0);
  }

  @override
  APIRequest get loadMoreRequest {
    if (storyList.nexttime == 0) {
      return null;
    }

    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {});
    return GetMyFavoritesLoadMoreRequest(completer, uid, storyList.nexttime);
  }

  @override
  APIRequest get refreshRequest {
    if (storyList.current == 0) {
      return null;
    }

    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {});
    return GetMyFavoritesRefreshRequest(completer, uid, storyList.current);
  }

  @override
  APIRequest get checkNewRequest => null;

  @override
  Widget buildStoryListView(BuildContext context, StoryListState aState) {
    var state = aState as FavoriteScreenState;
    return super.buildStoryListView(context, state);
  }
}
