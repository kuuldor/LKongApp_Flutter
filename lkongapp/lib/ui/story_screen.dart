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
import 'package:lkongapp/utils/async_avatar.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
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

  int loading;

  double offset = 0.0;

  StoryContentState(this.storyId, this.postId, this.page) {
    this.readingMode = readingModeAll;

    if (this.postId == null) {
      if (this.page == null) {
        this.page = 1;
      }
    } else {
      api.apiDispatch(api.QUERY_API, {"postId": this.postId}).then((result) {
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
      offset = 0.0;
    });
  }

  void setFloor(int value) {
    setState(() {
      floor = value;
    });
  }

  void setLoading(int value) {
    loading = value;
  }

  void setOffset(double value) {
    offset = value;
  }

  @override
  void initState() {
    super.initState();
    offset = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget(
        context, StoryContentModel.fromStateAndStore(this), (viewModel) {
      return viewModel._buildContentView(context);
    });
  }
}

class StoryContentModel implements ScrollerState {
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

  int displayedFloor;
  bool get novelMode => state.readingMode == readingModeNovel;

  bool scrolling = false;

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
            state.setLoading(page);
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
        other.detectLink == detectLink &&
        other.loading == loading &&
        other.lastError == lastError &&
        other.state == state;
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
        showDetailTime,
        detectLink,
        state,
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
      api.apiDispatch(api.FAVORITE_API,
          {"threadId": storyId, "unfavorite": unfavorite}).then((result) {
        // Load the first page to refresh the favorite status
        loadContent(storyId, 1);
      });
    }
  }

  Widget buildAppBar(BuildContext context, bool forSliver) {
    final theme = LKModeledApp.modelOf(context).theme;
    final titleStyle = theme.titleStyle;

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

    final titleBar = GestureDetector(
      child: Text("帖子", style: titleStyle.apply(color: Colors.white)),
      onTap: () => scrollToTop(context),
    );

    if (forSliver) {
      return SliverAppBar(
        title: titleBar,
        actions: actions,
        pinned: false,
        floating: true,
      );
    } else {
      return AppBar(
        title: titleBar,
        actions: actions,
      );
    }
  }

  List<Widget> buildSlivers(BuildContext context, int count,
      Widget Function(BuildContext, int) builder) {
    List<Widget> slivers = new List<Widget>();

    SliverAppBar bar = buildAppBar(context, true);
    if (bar != null) {
      slivers.add(bar);
    }

    slivers.add(SliverList(
      delegate: SliverChildBuilderDelegate(
        builder,
        childCount: count,
      ),
    ));

    return slivers;
  }

  Widget get spinner => Container(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );

  ScrollController _scrollController;

  Widget _buildContentView(BuildContext context) {
    int storyId = state.storyId;
    int pageNo = state.page;

    if (lastError == null && (pageNo == null || story?.storyInfo == null)) {
      if (!loading && storyId != null) {
        loadInfo(storyId);
      }
      _scrollController =
          ScrollController(initialScrollOffset: 0.0, keepScrollOffset: false);
      return Scaffold(
          key: _scaffoldKey,
          body: Container(
            height: MediaQuery.of(context).size.height - 160,
            child: Center(child: spinner),
          ));
    } else {
      return _buildStoryView(context);
    }
  }

  List buildListItems(int totalPages, List<int> availablePages) {
    List items = List();
    int storyId = state.storyId;
    int pageNo = state.page;

    if (story != null) {
      StoryPage page;

      if (novelMode) {
        for (int i = 1; i <= totalPages; i++) {
          page = story.pages[i];

          if (page != null && page.comments.length > 0) {
            items.addAll(page.comments);
            availablePages.add(i);
          } else {
            break;
          }
        }
      } else {
        page = story.pages[pageNo];

        if (page != null && page.comments.length > 0) {
          items.addAll(page.comments);
          availablePages.add(pageNo);
        } else if (lastError == null) {
          if (!loading && storyId != null) {
            loadContent(storyId, pageNo);
          }

          if (pageNo == state.loading) {
            items.add(spinner);
          }
        }
      }
    }

    return items;
  }

  Widget _buildStoryView(BuildContext context) {
    int storyId = state.storyId;
    int pageNo = state.page ?? 1;

    final theme = LKModeledApp.modelOf(context).theme;
    final subheadStyle = theme.subheadStyle;
    final titleStyle = theme.titleStyle;
    final size = theme.captionSize;
    final screenHeight = MediaQuery.of(context).size.height;

    StoryInfoResult info;

    List items = List();
    if (story != null) {
      info = story.storyInfo;

      if (info != null) {
        items.add(info);
      }
    }

    if (lastError != null) {
      items.add(Container(
          color: Colors.red[500],
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "错误：$lastError",
            style: subheadStyle.apply(color: Colors.white),
          )));
    }

    displayedFloor = (pageNo - 1) * 20;
    int maxFloor = pageNo * 20;
    if (info != null && maxFloor > info.replies) {
      maxFloor = info.replies + 1;
    }

    int totalPages = info == null ? 1 : info.replies ~/ 20 + 1;
    int lastAvailPage = 0;
    final availPages = <int>[];

    items.addAll(buildListItems(totalPages, availPages));

    if (availPages.length > 0) {
      lastAvailPage = availPages.last;
    }

    int itemCount = items.length + (novelMode ? 1 : 0);

    final buildCommentViews = (BuildContext context, int index) {
      var wrapTile;
      if (state.readingMode == readingModeNovel) {
        wrapTile = (Widget tile) => wrapItem(context, tile);
      } else {
        wrapTile =
            (Widget tile) => wrapItemAsCard(context, tile, clickable: false);
      }

      Widget tile;
      if (index >= items.length) {
        if (lastAvailPage < totalPages) {
          if (lastError == null) {
            if (!loading && storyId != null) {
              loadContent(storyId, lastAvailPage + 1);
            }
            return spinner;
          }
        }
        return Container();
      }

      var item = items[index];

      if (item is Widget) {
        tile = item;
      } else if (item is StoryInfoResult) {
        if (info?.subject != null) {
          tile = wrapTile(Container(
            child: Center(
              child: StoryInfoItem(info: info),
            ),
          ));
        }
      } else if (item is Comment) {
        var comment = item;

        displayedFloor = comment.lou;

        bool visible = true;
        if (blackList != null && blackList.contains("${comment.authorid}")) {
          visible = false;
        }

        if (state.readingMode == readingModeAuthor) {
          if (comment.authorid != info?.authorid) {
            visible = false;
          }
        } else if (state.readingMode == readingModeNovel) {
          if (comment.authorid != info?.authorid ||
              comment.message.length < 1024) {
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
            scroller: this,
          );
          tile = wrapTile(item);
        } else {
          tile = Container();
        }
      } else {
        tile = Container();
      }

      return tile;
    };

    Widget bottomBar;

    if (novelMode) {
      _scrollController = ScrollController(initialScrollOffset: state.offset);

      bottomBar = BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 12.0,
            ),
            IconButton(
              color: theme.barIconColor,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _scrollController.animateTo(state.offset - screenHeight + 100,
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeOut);
              },
            ),
            SizedBox(
              width: 64,
            ),
            IconButton(
              color: theme.barIconColor,
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                _scrollController.animateTo(state.offset + screenHeight - 100,
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeOut);
              },
            ),
            Expanded(
                child: Container(
              height: 0.0,
            )),
            // IconButton(
            //   icon: Icon(Icons.add_comment),
            //   onPressed: () {
            //     onReplyButtonTap(
            //       context,
            //       story: story.storyInfo,
            //       uid: uid,
            //       username: username,
            //     );
            //   },
            // ),
            SizedBox(
              width: 12.0,
            ),
          ],
        ),
      );
    } else {
      bottomBar = BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 12.0,
            ),
            IconButton(
              color: theme.barIconColor,
              icon: Icon(Icons.arrow_back),
              onPressed: state.page > 1
                  ? () {
                      Future(() {
                        if (!novelMode || state.page == 2) {
                          scrollToTop(context);
                        }
                        state.prevPage();
                      });
                    }
                  : null,
            ),
            FlatButton(
              child: Text(
                "$pageNo / $totalPages",
                style: titleStyle.apply(color: theme.barIconColor),
              ),
              onPressed: () {
                if (totalPages > 1) {
                  showPageSelector(context, totalPages, pageNo, state);
                }
              },
            ),
            IconButton(
              color: theme.barIconColor,
              icon: Icon(Icons.arrow_forward),
              onPressed: state.page < totalPages
                  ? () {
                      Future(() {
                        state.nextPage();
                        if (!novelMode) {
                          scrollToTop(context);
                        }
                      });
                    }
                  : null,
            ),
            Expanded(
                child: Container(
              height: 0.0,
            )),
            IconButton(
              color: theme.barIconColor,
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
              width: 32.0,
            ),
          ],
        ),
      );

      _scrollController =
          ScrollController(initialScrollOffset: 0.0, keepScrollOffset: false);

      if (lastError == null &&
          lastAvailPage > 0 &&
          state.floor != null &&
          (state.floor % 20) != 1) {
        Future.delayed(Duration(milliseconds: 10), () {
          showFloor(context, state.floor, maxFloor);
        });
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<ScrollNotification>(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: buildSlivers(context, itemCount, buildCommentViews),
        ),
        onNotification: (notification) {
          state.setOffset(notification.metrics.pixels);
          if (notification is ScrollStartNotification) {
            scrolling = true;
          } else if (notification is ScrollEndNotification) {
            scrolling = false;
          }
        },
      ),
      bottomNavigationBar: bottomBar,
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
                Future(() {
                  state.setPage(i + 1);
                  if (!novelMode) {
                    scrollToTop(context);
                  }
                });
                Navigator.pop(context);
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
    _scrollController.jumpTo(0.1);
    _scrollController.jumpTo(0.0);
  }

  void showFloor(BuildContext context, int floor, int max) async {
    var dest;
    dest = floor;

    int step = dest - (displayedFloor ?? ((state.page - 1) * 20));

    double offset = state.offset;
    scrollToDest(context, dest, step, offset, max);
  }

  Future scrollToDest(
      BuildContext context, int dest, int step, double offset, int max) async {
    if (dest > displayedFloor && displayedFloor < max) {
      offset += step * 20;
      try {
        _scrollController.jumpTo(offset);
        Future.delayed(
            Duration(milliseconds: 10),
            () => scrollToDest(
                context, dest, dest - displayedFloor, offset, max));
      } catch (e) {
        print(e.toString());
      }
    } else {
      final height = MediaQuery.of(context).size.height;
      double lastMove = (step >= 0 ? 1 : -1) * height;
      offset += lastMove;
      try {
        _scrollController.animateTo(offset,
            duration: Duration(milliseconds: 400), curve: Curves.easeOut);
        // _scrollController.jumpTo(offset);
      } catch (e) {
        print(e.toString());
      }
      state.floor = null;
    }
  }
}
