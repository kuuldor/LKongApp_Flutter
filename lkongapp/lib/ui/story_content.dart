import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/items/comment_item.dart';
import 'package:lkongapp/ui/items/story_info.dart';
import 'package:lkongapp/ui/items/story_item.dart';
import 'package:lkongapp/ui/modeled_app.dart';
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
    return StoryContentState(storyId, postId, page);
  }
}

class StoryContentState extends State<StoryContent> {
  int storyId;
  int postId;
  int page;

  bool loaded;
  bool loading;

  StoryContentState(this.storyId, this.postId, this.page);

  @override
  void initState() {
    super.initState();

    loaded = false;
    loading = false;
  }

  void prevPage() {
    setState(() {
      if (page > 0) {
        page--;
      }
    });
  }

  void nextPage() {
    setState(() {
      page++;
    });
  }

  void setPage(int newPage) {
    setState(() {
      page = newPage;
    });
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
    @required this.loadInfo,
  });

  final Future<Null> Function(int storyId, int page) loadContent;
  final Future<Null> Function(int storyId) loadInfo;

  static StoryContentModel fromStore(Store<AppState> store) {
    return StoryContentModel(
        loading: store.state.isLoading,
        repo: store.state.uiState.content.storyRepo,
        loadContent: (storyId, page) {
          store.dispatch(StoryContentRequest(null, storyId, page));
        },
        loadInfo: (storyId) {
          store.dispatch(StoryInfoRequest(null, storyId));
        });
  }

  var _scrollController = ScrollController();

  Widget _buildContentView(BuildContext context, StoryContentState state) {
    int storyId = state.storyId;
    int pageNo = state.page;
    StoryInfoResult info;

    BuiltList<Comment> comments;
    var story = repo[storyId];
    if (story != null) {
      info = story.storyInfo;
      StoryPage page = story.pages[pageNo];

      if (page != null) {
        comments = page.comments;
      }
    }

    if (loading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (info == null) {
      if (!loading) {
        // Future(() {
        loadInfo(storyId);
        // });
      }
    }
    if (comments == null) {
      if (!loading) {
        // Future(() {
        loadContent(storyId, pageNo);
        // });
      }
      return Container();
    }

    int totalPages = info == null ? 1 : info.replies ~/ 20 + 1;
    final theme = LKModeledApp.modelOf(context).theme;

    final buildCommentViews = (int count) {
      final wrapTile = (Widget tile) => Column(children: <Widget>[
            tile,
            Divider(
              height: 24.0,
            ),
          ]);
      List<Widget> tiles = List();
      tiles.add(wrapTile(Container(
          child: Center(
        child: StoryInfoItem(info: info),
      ))));
      for (int i = 0; i < count; i++) {
        var comment = comments[i];

        Widget item = CommentItem(
          comment: comment,
          // onTap: () => onStoryTap(context, story),
        );
        tiles.add(wrapTile(item));
      }

      return tiles;
    };

    return Scaffold(
      body: CustomScrollView(controller: _scrollController, slivers: <Widget>[
        SliverAppBar(
          title: Text("帖子"),
          floating: true,
          pinned: false,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            buildCommentViews(comments.length),
          ),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.arrow_back),
              onPressed: state.page > 1
                  ? () {
                      state.prevPage();
                      _scrollController.jumpTo(0.0);
                    }
                  : null,
            ),
            FlatButton(
              child: Text(
                "$pageNo / $totalPages",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .apply(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                showBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 240.0,
                        decoration: BoxDecoration(
                            color: theme.headerBG,
                            border:
                                Border.all(color: theme.mainColor, width: 2.0),
                            borderRadius: BorderRadius.circular(6.0)),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: totalPages,
                          itemBuilder: (BuildContext context, i) => ListTile(
                                leading: Icon(Icons.layers),
                                title: Text(
                                    "第${i + 1}页（${i * 20 + 1}楼 —— ${(i + 1) * 20}楼）"),
                                onTap: () {
                                  state.setPage(i + 1);
                                  Navigator.pop(context);
                                  _scrollController.jumpTo(0.0);
                                },
                              ),
                        ),
                      );
                    });
              },
            ),
            IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.arrow_forward),
              onPressed: state.page < totalPages
                  ? () {
                      state.nextPage();
                      _scrollController.jumpTo(0.0);
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
