import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/fetched_list.dart';
import 'package:lkongapp/ui/items/forum_item.dart';
import 'package:lkongapp/ui/items/user_item.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/tools/drawer_button.dart';
import 'package:lkongapp/ui/tools/menu_choice.dart';
import 'package:material_search/material_search.dart';
import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/items/story_item.dart';
import 'package:lkongapp/ui/story_screen.dart';
import 'package:lkongapp/ui/tools/icon_message.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:lkongapp/utils/async_avatar.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/ui/connected_widget.dart';
import 'package:lkongapp/ui/tools/item_handler.dart';

const searchTypeStory = 0;
const searchTypeUser = 1;
const searchTypeForum = 2;

const int normalSort = 0;
const int hotSort = 1;
const int timeSort = 2;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }
}

final allMenus = const <Choice>[
  const Choice(
      title: '按相关度排序', icon: Icons.equalizer, action: MenuAction.normal),
  const Choice(title: '按热度排序', icon: Icons.whatshot, action: MenuAction.hot),
  const Choice(
      title: '按发布时间排序', icon: Icons.schedule, action: MenuAction.timeline),
];

class SearchScreenState extends State<SearchScreen> {
  String searchString;
  int searchType;
  bool isSearching;
  int sortType;

  final _scrollController = ScrollController();
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  SearchScreenState(
      {this.searchType: searchTypeStory,
      this.searchString: "",
      this.isSearching: false,
      this.sortType: normalSort});

  void setSearchType(int newType) {
    setState(() {
      searchType = newType;
    });
  }

  void setSortType(int newType) {
    setState(() {
      sortType = newType;
    });
  }

  void setSearchString(String newSearchString) {
    setState(() {
      searchString = newSearchString;
      isSearching = false;
    });
  }

  void setSearching(bool searching) {
    setState(() {
      isSearching = searching;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.text = searchString;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setSearching(false);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  void startSearch(String s, int type, int sort) {
    _focusNode.unfocus();
    if (s.length > 0) {
      setState(() {
        searchString = s;
        searchType = type;
        sortType = sort;
        isSearching = true;
      });
    }
  }

  List<Choice> filterMenus() {
    var menus = List<Choice>.from(allMenus);
    menus[sortType] = Choice.disable(menus[sortType]);

    if (searchType != searchTypeStory) {
      menus.removeLast();
    }

    return menus;
  }

  void menuSelected(BuildContext context, Choice choice) {
    print("Menu Selcected for ${choice.title}");

    int sort;
    switch (choice.action) {
      case MenuAction.normal:
        sort = 0;
        break;
      case MenuAction.hot:
        sort = 1;
        break;
      case MenuAction.timeline:
        sort = 2;
        break;

      default:
        break;
    }

    if (sort != null) {
      startSearch(searchString, searchType, sort);
    }
  }

  Widget buildTitleBar(BuildContext context) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      autofocus: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.pageColor,
        hintText: '搜索' + "...",
        contentPadding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0),
            borderRadius: BorderRadius.circular(6.0)),
      ),
      onChanged: (s) => setSearchString(s),
      onSubmitted: (s) {
        startSearch(s, searchTypeStory, sortType);
      },
    );
  }

  Widget buildSearchList(BuildContext context) {
    return buildConnectedWidget(
        context, SearchScreenModel.fromStateAndStore(this),
        (SearchScreenModel viewModel) {
      return viewModel.buildListView(context);
    });
  }

  Widget buildSearchPrompt(BuildContext context) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    return SliverList(
      delegate: SliverChildListDelegate(
        {searchTypeStory: '帖子', searchTypeUser: '用户', searchTypeForum: '版块'}
            .map((type, name) => MapEntry(
                name,
                Container(
                    color: theme.mainColor.withAlpha(128),
                    child: Align(
                        child: ListTile(
                      leading: Icon(Icons.search),
                      title: Text("搜索$name：$searchString"),
                      onTap: () {
                        startSearch(searchString, type, normalSort);
                      },
                    )))))
            .values
            .toList(),
      ),
    );
  }

  List<Widget> _buildSlivers(BuildContext context) {
    List<Widget> slivers = new List<Widget>();
    List<Choice> menus = filterMenus();
    var actions = <Widget>[];

    if (menus.length > 0) {
      actions.add(popupMenu(context, menus, menuSelected));
    }

    SliverAppBar bar = SliverAppBar(
      leading: DrawerButton(),
      title: buildTitleBar(context),
      actions: actions,
      floating: false,
      pinned: true,
    );
    slivers.add(bar);

    if (!isSearching) {
      if (searchString != null && searchString.length > 0) {
        slivers.add(buildSearchPrompt(context));
      }
    } else {
      slivers.add(buildSearchList(context));
    }

    return slivers;
  }

  Widget buildGroupedListView(BuildContext context) {
    return new CustomScrollView(
      controller: _scrollController,
      slivers: _buildSlivers(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    return buildGroupedListView(context);
  }
}

class SearchScreenModel extends FetchedListModel implements ScrollerState {
  final SearchResult searchResult;
  final bool loading;
  final String lastError;
  final SearchScreenState state;
  final bool showDetailTime;

  SearchScreenModel({
    @required this.searchResult,
    @required this.loading,
    @required this.lastError,
    @required this.state,
    @required this.showDetailTime,
  });

  static final fromStateAndStore =
      (SearchScreenState state) => (Store<AppState> store) => SearchScreenModel(
            loading: store.state.uiState.content.searchResult.loading,
            lastError: store.state.uiState.content.searchResult.lastError,
            searchResult: store.state.uiState.content.searchResult,
            state: state,
            showDetailTime: selectSetting(store).showDetailTime,
          );

  @override
  bool operator ==(other) {
    return other is SearchScreenModel &&
        loading == other.loading &&
        lastError == other.lastError &&
        state.searchString == other.state.searchString &&
        state.searchType == other.state.searchType &&
        state.sortType == other.state.sortType &&
        showDetailTime == other.showDetailTime &&
        searchResult == other.searchResult;
  }

  @override
  int get hashCode => hashObjects([
        loading,
        lastError,
        searchResult,
        showDetailTime,
        state.searchString,
        state.searchType,
        state.sortType
      ]);

  @override
  int get itemCount {
    int count;
    int type = searchResult.searchType;
    BuiltList list = getSearchList(type);
    count = list?.length ?? 0;

    return count;
  }

  BuiltList getSearchList(int type) {
    BuiltList list;
    switch (type) {
      case searchTypeStory:
        list = searchResult?.stories?.data;
        break;
      case searchTypeUser:
        list = searchResult?.users?.user;
        break;
      case searchTypeForum:
        list = searchResult?.forums?.forumInfo;
        break;
    }
    return list;
  }

  getSearchResult(int type) {
    var result;
    switch (type) {
      case searchTypeStory:
        result = searchResult?.stories;
        break;
      case searchTypeUser:
        result = searchResult?.users;
        break;
      case searchTypeForum:
        result = searchResult?.forums;
        break;
    }
    return result;
  }

  @override
  Widget createListItem(BuildContext context, int index) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    var item;

    final list = getSearchList(searchResult.searchType);
    final object = list[index];
    assert(object != null, "$list doesn't have ojbect at $index");

    if (searchResult.searchType == searchTypeStory) {
      Story story = object as Story;

      item = StoryItem(
        story: story,
        showDetailTime: showDetailTime,
        scroller: this,
        onTap: () => onStoryTap(context, story),
      );
    } else if (searchResult.searchType == searchTypeUser) {
      UserInfo user = object as UserInfo;

      item = UserItem(
        user: user,
        onTap: () => onUserTap(context, user),
      );
    } else if (searchResult.searchType == searchTypeForum) {
      ForumInfoResult info = object as ForumInfoResult;

      Forum forum = Forum().rebuild((b) => b
        ..fid = info.fid
        ..name = info.name);
      item = ForumItem(
        forum: forum,
        info: info,
        onTap: () => onForumTap(context, forum),
      );
    }

    return item;
  }

  @override
  Widget headerForSection(BuildContext context, {int section}) {
    String error = lastError;
    if (error != null && error != "") {
      return Container(
          color: Colors.red[500],
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "错误：$error。请稍后重试",
            style: const TextStyle(color: Colors.white),
          ));
    }
    return null;
  }

  @override
  APIRequest get fetchFromScratchRequest {
    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return SearchNewRequest(
        completer, state.searchString, state.searchType, state.sortType);
  }

  @override
  APIRequest get loadMoreRequest {
    final result = getSearchResult(state.searchType);
    int nexttime = result?.nexttime;

    if (nexttime == null || nexttime == 0) {
      return null;
    }

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return SearchLoadMoreRequest(completer, state.searchString,
        state.searchType, state.sortType, nexttime);
  }

  @override
  APIRequest get refreshRequest => null;

  @override
  void listIsReady(BuildContext context) {}

  @override
  Widget buildListView(BuildContext context) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    if (!initLoaded) {
      if (loading != true && lastError == null) {
        handleFetchFromScratch(context);
      }
    }
    final fillup = fillupForEmptyView(context);
    if (fillup != null) {
      return SliverFillRemaining(
        child: Container(
          color: theme.themeData.backgroundColor,
          child: fillup,
        ),
      );
    }

    return super.builderSection(context, 0);
  }

  @override
  bool get initLoaded {
    return state.searchString == searchResult.searchString &&
        state.searchType == searchResult.searchType &&
        state.sortType == searchResult.sortType &&
        getSearchResult(state.searchType) != null;
  }
}
