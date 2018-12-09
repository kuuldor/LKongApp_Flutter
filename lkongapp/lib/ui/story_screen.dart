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
import 'package:lkongapp/utils/theme.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

import 'package:lkongapp/ui/connected_widget.dart';

class StoryScreen extends StatefulWidget {
  final int storyId;
  final int postId;
  final int page;

  const StoryScreen(
      {Key key, @required this.storyId, this.postId, this.page: 1})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StoryContentState(storyId, postId, page);
  }
}

class StoryContentState extends State<StoryScreen> {
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
    return buildConnectedWidget(
        context, StoryContentModel.fromStateAndStore(this), (viewModel) {
      return viewModel._buildContentView(context, this);
    });
  }
}

class StoryContentModel {
  final StoryPageList story;
  final bool loading;
  final String lastError;

  StoryContentModel({
    @required this.loading,
    @required this.lastError,
    @required this.story,
    @required this.loadContent,
    @required this.loadInfo,
  });

  final Future<Null> Function(int storyId, int page) loadContent;
  final Future<Null> Function(int storyId) loadInfo;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static final fromStateAndStore = (StoryContentState state) =>
      (Store<AppState> store) => StoryContentModel(
          loading:
              store.state.uiState.content.storyRepo[state.storyId]?.loading ??
                  false,
          lastError:
              store.state.uiState.content.storyRepo[state.storyId]?.lastError,
          story: store.state.uiState.content.storyRepo[state.storyId],
          loadContent: (storyId, page) {
            store.dispatch(StoryContentRequest(null, storyId, page));
          },
          loadInfo: (storyId) {
            store.dispatch(StoryInfoRequest(null, storyId));
          });

  @override
  bool operator ==(other) {
    return other is StoryContentModel &&
        other.story == story &&
        other.loading == loading &&
        other.lastError == lastError;
  }

  @override
  int get hashCode => hash2(loading, story);

  var _scrollController = ScrollController();

  Widget _buildContentView(BuildContext context, StoryContentState state) {
    int storyId = state.storyId;
    int pageNo = state.page;
    StoryInfoResult info;

    BuiltList<Comment> comments;
    if (story != null) {
      info = story.storyInfo;
      StoryPage page = story.pages[pageNo];

      if (page != null) {
        comments = page.comments;
      }
    }

    if (info == null && lastError == null) {
      if (!loading) {
        loadInfo(storyId);
      }
    }
    if (comments == null && lastError == null) {
      if (!loading) {
        loadContent(storyId, pageNo);
      }
    }

    int totalPages = info == null ? 1 : info.replies ~/ 20 + 1;

    final buildCommentViews = () {
      final wrapTile = (Widget tile) => Column(children: <Widget>[
            tile,
            Divider(
              height: 24.0,
            ),
          ]);
      List<Widget> tiles = List();
      if (loading || comments == null) {
        tiles.add(Container(
          height: MediaQuery.of(context).size.height - 160,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
      } else {
        tiles.add(wrapTile(
          Container(
            child: Center(
              child: StoryInfoItem(info: info),
            ),
          ),
        ));
        if (lastError != null) {
          tiles.add(Container(
              color: Colors.red[500],
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                "错误：$lastError",
                style: const TextStyle(color: Colors.white),
              )));
        } else {
          for (int i = 0; i < comments.length; i++) {
            var comment = comments[i];

            Widget item = CommentItem(
              comment: comment,
              // onTap: () => onStoryTap(context, story),
            );
            tiles.add(wrapTile(item));
          }
        }
      }
      return tiles;
    };

    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(controller: _scrollController, slivers: <Widget>[
        SliverAppBar(
          title: Text("帖子"),
          floating: true,
          pinned: false,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            buildCommentViews(),
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
                if (totalPages > 1) {
                  showPageSelector(context, totalPages, pageNo, state);
                }
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

  void showPageSelector(BuildContext context, int totalPages, int pageNo,
      StoryContentState state) {
    final theme = LKModeledApp.modelOf(context).theme;
    final rowHeight = 40.0;
    final maxHeight = 320.0;
    final maxRows = maxHeight / rowHeight;
    _scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
        height: totalPages > maxRows ? maxHeight : totalPages * rowHeight + 20,
        decoration: BoxDecoration(
            border: Border.all(color: theme.mainColor, width: 2.0),
            borderRadius: BorderRadius.circular(6.0)),
        child: ListView.builder(
            controller:
                ScrollController(initialScrollOffset: (pageNo - 4) * rowHeight),
            shrinkWrap: true,
            itemCount: totalPages,
            itemBuilder: (BuildContext context, i) {
              final turnPage = (int i) {
                state.setPage(i + 1);
                Navigator.pop(context);
                _scrollController.jumpTo(0.0);
              };
              return Container(
                height: rowHeight,
                child: ListTile(
                  leading: Radio<int>(
                    value: i,
                    groupValue: pageNo - 1,
                    onChanged: turnPage,
                  ),
                  title: Text("第${i + 1}页（${i * 20 + 1}楼 —— ${(i + 1) * 20}楼）"),
                  onTap: () => turnPage(i),
                ),
              );
            }),
      );
    });
  }
}
