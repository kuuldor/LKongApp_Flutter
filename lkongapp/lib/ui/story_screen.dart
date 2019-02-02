import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/middlewares/api.dart' as api;
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/items/comment_item.dart';
import 'package:lkongapp/ui/items/item_wrapper.dart';
import 'package:lkongapp/ui/items/story_info.dart';
import 'package:lkongapp/ui/items/story_item.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/tools/icon_message.dart';
import 'package:lkongapp/ui/tools/menu_choice.dart';
import 'package:lkongapp/utils/theme.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:lkongapp/utils/indexed_controller.dart';
import 'package:lkongapp/selectors/selectors.dart';
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

const readingModeAll = 0;
const readingModeAuthor = 1;
const readingModeNovel = 2;

class StoryContentState extends State<StoryScreen> {
  int storyId;
  int postId;
  int page;
  int floor;

  int readingMode;

  bool loaded = false;
  bool loading = false;

  StoryContentState(this.storyId, this.postId, this.page) {
    this.readingMode = readingModeAll;

    if (this.postId == null) {
      if (this.page == null) {
        this.page = 1;
      }
    } else {
      loading = true;
      api.queryMetaData({"postId": this.postId}).then((result) {
        String location = result["location"];
        int lou = result["lou"];
        int page;
        int tid = storyId;

        if (lou != null && location != null) {
          final locArray = location.split("_");
          if (locArray.length > 2) {
            page = int.parse(locArray[2]);
          } else {
            page = 1;
          }
          if (locArray.length > 1) {
            tid = int.parse(locArray[1]);
          }
        }
        setState(() {
          this.loading = false;
          this.page = page;
          this.floor = lou;
          this.storyId = tid;
        });
      });
    }
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

  void setReadingMode(int newMode) {
    setState(() {
      readingMode = newMode;
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
  final String username;
  final StoryPageList story;
  final bool loading;
  final String lastError;
  final BuiltList<String> blackList;
  final BuiltList<String> followList;
  final bool showDetailTime;
  final bool detectLink;
  final StoryContentState state;

  StoryContentModel({
    @required this.username,
    @required this.uid,
    @required this.loading,
    @required this.lastError,
    @required this.story,
    @required this.loadContent,
    @required this.loadInfo,
    @required this.blackList,
    @required this.followList,
    @required this.showDetailTime,
    @required this.detectLink,
    @required this.state,
  });

  final Future<Null> Function(int storyId, int page) loadContent;
  final Future<Null> Function(int storyId) loadInfo;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static final fromStateAndStore = (StoryContentState state) =>
      (Store<AppState> store) => StoryContentModel(
          username: selectUser(store)?.userInfo?.username,
          uid: selectUID(store),
          loading:
              store.state.uiState.content.storyRepo[state.storyId]?.loading ??
                  false,
          lastError:
              store.state.uiState.content.storyRepo[state.storyId]?.lastError,
          story: store.state.uiState.content.storyRepo[state.storyId],
          blackList:
              store.state.persistState.appConfig.setting.hideBlacklisterPost
                  ? selectUserData(store)?.followList?.black
                  : null,
          followList: selectUserData(store)?.followList?.tid,
          showDetailTime: selectSetting(store).showDetailTime,
          detectLink: selectSetting(store).detectLink,
          state: state,
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
        other.uid == uid &&
        other.username == username &&
        other.blackList == blackList &&
        other.followList == followList &&
        other.showDetailTime == showDetailTime &&
        other.loading == loading &&
        other.lastError == lastError;
  }

  @override
  int get hashCode => hashObjects([
        loading,
        story,
        lastError,
        uid,
        username,
        blackList,
        followList,
        showDetailTime
      ]);

  final actionMenus = const <Choice>[
    const Choice(
        title: '关注', icon: Icons.visibility, action: MenuAction.follow),
    const Choice(
        title: '取消关注', icon: Icons.visibility_off, action: MenuAction.unfollow),
    const Choice(
        title: '收藏', icon: Icons.favorite, action: MenuAction.favorite),
    const Choice(
        title: '取消收藏', icon: Icons.delete_sweep, action: MenuAction.unfavorite),
  ];

  List<Choice> filterActionMenus() {
    var menus = <Choice>[];
    if (followList != null && story?.storyInfo?.tid != null) {
      if (followList.contains("${story.storyInfo.tid}")) {
        menus.add(actionMenus[1]);
      } else {
        menus.add(actionMenus[0]);
      }
    }

    if (story?.pages != null &&
        story?.pages[1] != null &&
        story.pages[1].comments != null &&
        story.pages[1].comments.length > 0) {
      if (story.pages[1].comments.first.favorite == true) {
        menus.add(actionMenus[3]);
      } else {
        menus.add(actionMenus[2]);
      }
    }
    return menus;
  }

  final modeMenus = const <Choice>[
    const Choice(title: '全部显示', icon: Icons.toc, action: MenuAction.normal),
    const Choice(
        title: '只看楼主', icon: Icons.face, action: MenuAction.authorOnly),
    const Choice(
        title: '小说连载', icon: Icons.receipt, action: MenuAction.novelReading),
  ];

  List<Choice> filterModeMenus() {
    var menus = modeMenus.map((item) => Choice.copy(item)).toList();
    menus[state.readingMode] = Choice.disable(menus[state.readingMode]);
    return menus;
  }

  void _menuSelected(BuildContext context, Choice choice) {
    switch (choice.action) {
      case MenuAction.follow:
      case MenuAction.unfollow:
        followStory(context, choice.action);
        break;
      case MenuAction.favorite:
      case MenuAction.unfavorite:
        favoriteStory(context, choice.action);
        break;
      case MenuAction.normal:
        state.setReadingMode(readingModeAll);
        break;
      case MenuAction.authorOnly:
        state.setReadingMode(readingModeAuthor);
        break;
      case MenuAction.novelReading:
        state.setReadingMode(readingModeNovel);
        break;
      default:
        break;
    }
  }

  void followStory(BuildContext context, MenuAction action) {
    final completer = Completer<String>();
    FollowRequest req;
    switch (action) {
      case MenuAction.follow:
        req = FollowRequest(
          completer,
          id: story.storyInfo.tid,
          replyType: FollowType.story,
          unfollow: false,
        );
        break;
      case MenuAction.unfollow:
        req = FollowRequest(
          completer,
          id: story.storyInfo.tid,
          replyType: FollowType.story,
          unfollow: true,
        );
        break;

      default:
        break;
    }

    if (req != null) {
      completer.future.then((error) {
        String msg = '修改关注状态';
        if (error == null) {
          msg += '成功';
        } else {
          msg += '失败' + ": $error";
        }
        showToast(msg);
      });

      dispatchAction(context)(req);
    }
  }

  void favoriteStory(BuildContext context, MenuAction action) {
    bool unfavorite;
    switch (action) {
      case MenuAction.favorite:
        unfavorite = false;
        break;
      case MenuAction.unfavorite:
        unfavorite = true;
        break;

      default:
        break;
    }

    if (unfavorite != null) {
      final storyId = story.storyInfo.tid;
      api.favoriteThread({"threadId": storyId, "unfavorite": unfavorite}).then(
          (result) {
        // Load the first page to refresh the favorite status
        loadContent(storyId, 1);
      });
    }
  }

  AppBar buildAppBar(BuildContext context) {
    List<Choice> actionChoices = filterActionMenus();
    List<Choice> modeChoices = filterModeMenus();

    var actions = <Widget>[];

    if (username != null && uid != null) {
      actionChoices.forEach((menu) => actions.add(IconButton(
            icon: Icon(menu.icon),
            onPressed: () {
              _menuSelected(context, menu);
            },
          )));
    }

    if (modeChoices.length > 0) {
      actions.add(popupMenu(context, modeChoices, _menuSelected));
    }

    return AppBar(
      title: GestureDetector(
        child: Text("帖子",
            style:
                Theme.of(context).textTheme.title.apply(color: Colors.white)),
        onTap: () => scrollToTop(context),
      ),
      actions: actions,
    );
  }

  static ScrollController _scrollController;

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
        appBar: buildAppBar(context),
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
      if (!loading && storyId != null) {
        loadInfo(storyId);
      }
    }
    if (comments == null && lastError == null) {
      if (!loading && storyId != null) {
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
    final theme = LKModeledApp.modelOf(context).theme;
    final subheadStyle = theme.subheadStyle;
    final size = theme.captionSize;

    final buildCommentViews = (BuildContext context, int index) {
      var wrapTile;
      if (state.readingMode == readingModeNovel) {
        wrapTile = (Widget tile) => wrapItem(context, tile);
      } else {
        wrapTile =
            (Widget tile) => wrapItemAsCard(context, tile, clickable: false);
      }

      Widget tile;
      if (loading || (comments == null && lastError == null)) {
        tile = spinner;
      } else {
        if (index == 0) {
          if (info?.subject != null) {
            tile = wrapTile(Container(
              child: Center(
                child: StoryInfoItem(info: info),
              ),
            ));
          } else {
            tile = Container();
          }
        } else if (lastError != null) {
          if (index == 1) {
            tile = Container(
                color: Colors.red[500],
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  "错误：$lastError",
                  style: subheadStyle.apply(color: Colors.white),
                ));
          }
        } else {
          var i = index - 1;
          if (i >= 0 && i < comments.length) {
            var comment = comments[i];
            bool visible = true;
            if (blackList != null &&
                blackList.contains("${comment.authorid}")) {
              visible = false;
            }

            if (state.readingMode == readingModeAuthor) {
              if (comment.authorid != info?.authorid) {
                visible = false;
              }
            }

            if (state.readingMode == readingModeNovel) {
              if (comment.authorid != info?.authorid) {
                visible = false;
              }

              //Assume the novel's chapter will be longer than 1K
              if (comment.message.length < 1024) {
                visible = false;
              }
            }

            if (visible) {
              Widget item = CommentItem(
                uid: uid,
                comment: comment,
                showDetailTime: showDetailTime,
                detectLink: detectLink,
                onTap: (action) => onCommentAction(context, comment, action),
                author: story?.storyInfo?.authorid,
                concise: (state.readingMode == readingModeNovel),
              );
              tile = wrapTile(item);
            } else {
              tile = Container();
            }
          }
        }
      }
      return tile;
    };

    Widget listView;

    if (lastError == null && state.floor != null && (state.floor % 20) != 1) {
      _scrollController = IndexedScrollController();
      listView = IndexedListView.builder(
        controller: _scrollController,
        itemBuilder: buildCommentViews,
        itemCount: itemCount,
      );
      Future(() {
        showFloor(context, state.floor);
      });
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
      appBar: buildAppBar(context),
      body: listView,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 12.0,
            ),
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
            Expanded(
                child: Container(
              height: 0.0,
            )),
            IconButton(
              icon: Icon(Icons.add_comment),
              onPressed: () {
                onReplyButtonTap(
                  context,
                  story: story.storyInfo,
                  uid: uid,
                  username: username,
                );
              },
            ),
            SizedBox(
              width: 12.0,
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
          uid: uid,
          username: username,
        );
        break;
      case CommentAction.Edit:
        onEditButtonTap(
          context,
          comment: comment,
          story: story.storyInfo,
          uid: uid,
          username: username,
        );
        break;
      case CommentAction.UpVote:
        onUpvoteButtonTap(context, comment);
        break;
    }
  }

  onUpvoteButtonTap(BuildContext context, Comment voted) {
    final coinsController = TextEditingController();
    final reasonController = TextEditingController();
    final ValueKey _coinsKey = Key('__upvote__coins__${voted.id}');
    final ValueKey _reasonKey = Key('__upvote__reason__${voted.id}');

    final coinNumFld = TextFormField(
      key: _coinsKey,
      controller: coinsController,
      autofocus: true,
      keyboardType: TextInputType.number,
      validator: (val) {
        String msg;
        if (val.isEmpty || val.trim().length == 0) {
          msg = '请输入龙币数';
        } else {
          int n = 0;
          try {
            n = int.parse(val);
          } catch (e) {}
          if (n < 1) {
            msg = '龙币数需大于1';
          }
        }

        return msg;
      },
      decoration: InputDecoration(
        hintText: '',
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
    );

    final reasonFld = TextFormField(
      key: _reasonKey,
      controller: reasonController,
      autocorrect: false,
      keyboardType: TextInputType.multiline,
      maxLines: 2,
      maxLength: 20,
      autofocus: false,
      decoration: InputDecoration(
        hintText: '',
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
    );

    final form = Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('龙币数'),
            SizedBox(height: 4.0),
            coinNumFld,
            SizedBox(height: 8.0),
            Text('评分原因'),
            SizedBox(height: 4.0),
            reasonFld,
            SizedBox(height: 18.0),
          ],
        ),
      ),
    );

    final completer = Completer<String>();

    showDialog<void>(
      context: _scaffoldKey.currentContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('评分'),
          content: form,
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('确定'),
              onPressed: () {
                int coins = int.parse(coinsController.text);
                String reason = reasonController.text.trim();
                dispatchAction(context)(UpvoteRequest(
                  completer,
                  story: story.storyInfo,
                  coins: coins,
                  voted: voted,
                  reason: reason,
                ));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    completer.future.then((error) {
      String msg = '评分';
      if (error == null) {
        msg += '成功';
      } else {
        msg += '失败' + ": $error";
      }
      showToast(msg);
    });
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
            border: Border.all(color: theme.mainColor, width: 1.0),
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

  void scrollToTop(BuildContext context) {
    if (_scrollController is IndexedScrollController) {
      showFloor(context, 1);
    } else {
      _scrollController.jumpTo(0.1);
    }
  }

  void showFloor(BuildContext context, int floor) {
    if (_scrollController is IndexedScrollController) {
      var index = floor % 20;
      if (index == 0) {
        index = 20;
      }
      final controller = _scrollController as IndexedScrollController;
      controller.jumpToIndex(index);
    }
  }
}
