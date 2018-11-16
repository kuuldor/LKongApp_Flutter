import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/items/story_item.dart';
import 'package:lkongapp/ui/tools/icon_message.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

import 'package:lkongapp/ui/connected_widget.dart';

class StoryContent extends StatefulWidget {
  final int storyId;
  final int postId;
  final int page;

  const StoryContent(
      {Key key, @required this.storyId, this.postId, this.page: 1})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StoryContentState();
  }
}

class StoryContentState extends State<StoryContent> {
  bool loaded;
  bool loading;

  @override
  void initState() {
    super.initState();

    loaded = false;
    loading = false;
  }

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  void onInitialLoaded() {
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget(context, StoryContentModel.fromStore,
        (viewModel) {
      return viewModel._buildContentView(context, this);
    });
  }
}

class StoryContentModel {
  final BuiltMap<int, StoryPageList> repo;
  final bool loading;

  StoryContentModel({
    @required this.loading,
    @required this.repo,
    @required this.loadContent,
  });

  final Future<Null> Function(int story, int page) loadContent;

  static StoryContentModel fromStore(Store<AppState> store) {
    return StoryContentModel(
        loading: store.state.isLoading,
        repo: store.state.uiState.content.storyRepo,
        loadContent: (story, page) {
          store.dispatch(StoryContentRequest(null, story, page));
        });
  }

  Widget _buildContentView(BuildContext context, StoryContentState state) {
    int story = state.widget.storyId;
    int page = state.widget.page;

    BuiltList<Comment> comments;
    try {
      var pageList = repo[story];
      comments = pageList.pages[page].comments;
    } catch (_) {}

    if (comments == null) {
      if (!loading) {
        // Future(() {
        loadContent(story, page);
        // });
      } else {
        return Center(child: CircularProgressIndicator());
      }
    }
    return Container(child: Text("${comments.toString()}"));
  }
}
