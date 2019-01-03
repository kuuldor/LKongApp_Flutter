import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/items/comment_item.dart';
import 'package:lkongapp/ui/items/story_info.dart';
import 'package:lkongapp/ui/items/story_item.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/tools/icon_message.dart';
import 'package:lkongapp/utils/theme.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:lkongapp/utils/indexed_controller.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/ui/tools/item_handler.dart';
import 'package:lkongapp/ui/connected_widget.dart';

class StoryScreen extends StatefulWidget {
  final int storyId;
  final int postId;
  final int page;
  final int floor;

  const StoryScreen(
      {Key key, @required this.storyId, this.postId, this.page, this.floor})
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
  int floor;

  bool loaded;
  bool loading;

  StoryContentState(this.storyId, this.postId, this.page) {
    if (this.postId == null) {
      if (this.page == null) {
        this.page = 1;
      }
    } else {
      getQuoteLocation({"postId": this.postId}).then((result) {
        String location = result["location"];
        int lou = result["lou"];
        int page;

        if (lou != null && location != null) {
          final locArray = location.split("_");
          if (locArray.length > 2) {
            page = int.parse(locArray[2]);
          } else {
            page = 1;
          }
        }
        setState(() {
          this.page = page;
          this.floor = lou;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();

    loaded = false;
    loading = false;
  }

  void prevPage() {
    setState(() {
      if (page != null && page > 0) {
        page--;
        floor = null;
      }
    });
  }

  void nextPage() {
    setState(() {
      if (page != null) {
        page++;
        floor = null;
      }
    });
  }

  void setPage(int newPage) {
    setState(() {
      page = newPage;
      floor = null;
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
  final int uid;
  final StoryPageList story;
  final bool loading;
  final String lastError;

  StoryContentModel({
    @required this.uid,
    @required this.loading,
    @required this.lastError,
    @required this.story,
    @required this.loadContent,
    @required this.loadInfo,
  });

  final Future<Null> Function(int storyId, int page) loadContent;
  final Future<Null> Function(int storyId) loadInfo;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static final fromStateAndStore = (StoryContentState state) =>
      (Store<AppState> store) => StoryContentModel(
          uid: store.state.persistState.authState.currentUser,
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

  List<Widget> get actions => <Widget>[];
  AppBar get appBar => AppBar(
        title: Text("帖子"),
        actions: actions,
      );

  ScrollController _scrollController;

  Widget _buildContentView(BuildContext context, StoryContentState state) {
    final spinner = Container(
      height: MediaQuery.of(context).size.height - 160,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );

    int pageNo = state.page;
    if (pageNo == null) {
      _scrollController = ScrollController();
      return Scaffold(
        key: _scaffoldKey,
        appBar: appBar,
        body: ListView.builder(
            controller: _scrollController,
            itemCount: 1,
            itemBuilder: (context, int) => spinner),
      );
    }

    int storyId = state.storyId;

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

    int itemCount = 1;

    if (lastError != null) {
      itemCount++;
    } else if (comments != null) {
      itemCount += comments.length;
    }

    int totalPages = info == null ? 1 : info.replies ~/ 20 + 1;

    final buildCommentViews = (BuildContext context, int index) {
      final wrapTile = (Widget tile) => Column(children: <Widget>[
            tile,
            Divider(
              height: 24.0,
            ),
          ]);
      Widget tile;
      if (loading || comments == null) {
        tile = spinner;
      } else {
        if (index == 0) {
          tile = wrapTile(Container(
            child: Center(
              child: StoryInfoItem(info: info),
            ),
          ));
        } else if (lastError != null) {
          if (index == 1) {
            tile = Container(
                color: Colors.red[500],
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  "错误：$lastError",
                  style: const TextStyle(color: Colors.white),
                ));
          }
        } else {
          var i = index - 1;
          if (i >= 0 && i < comments.length) {
            var comment = comments[i];

            Widget item = CommentItem(
              uid: uid,
              comment: comment,
              onTap: (action) => onCommentAction(context, comment, action),
            );
            tile = wrapTile(item);
          }
        }
      }
      return tile;
    };

    Widget listView;

    if (state.floor != null) {
      Future(() {
        showFloor(context, state.floor);
      });
      _scrollController = IndexedScrollController();
      listView = IndexedListView.builder(
        controller: _scrollController,
        itemBuilder: buildCommentViews,
        itemCount: itemCount,
      );
    } else {
      _scrollController = ScrollController();
      listView = ListView.builder(
        controller: _scrollController,
        itemBuilder: buildCommentViews,
        itemCount: itemCount,
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      body: listView,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          onReplyButtonTap(context, story: story.storyInfo);
        },
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

  void onCommentAction(
      BuildContext context, Comment comment, CommentAction action) {
    switch (action) {
      case CommentAction.Reply:
        onReplyButtonTap(
          context,
          comment: comment,
          story: story.storyInfo,
        );
        break;
      case CommentAction.Edit:
        onEditButtonTap(
          context,
          comment: comment,
          story: story.storyInfo,
        );
        break;
      case CommentAction.UpVote:
        break;
    }
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
                child: Row(
                  children: <Widget>[
                    Radio<int>(
                      value: i,
                      groupValue: pageNo - 1,
                      onChanged: turnPage,
                    ),
                    FlatButton(
                      child: Text(
                          "第${i + 1}页（${i * 20 + 1}楼 —— ${(i + 1) * 20}楼）"),
                      onPressed: () => turnPage(i),
                    )
                  ],
                ),
              );
            }),
      );
    });
  }

  void showFloor(BuildContext context, int floor) {
    var index = floor % 20;
    final controller = _scrollController as IndexedScrollController;
    controller.jumpToIndex(index);
  }
}
