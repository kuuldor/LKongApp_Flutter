import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/fetched_list.dart';
import 'package:lkongapp/ui/items/forum_item.dart';
import 'package:lkongapp/ui/items/user_item.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/tools/drawer_button.dart';
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

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/ui/connected_widget.dart';
import 'package:lkongapp/ui/tools/item_handler.dart';

const searchTypeStory = 0;
const searchTypeUser = 1;
const searchTypeForum = 2;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
  String searchString;
  int searchType;
  bool isSearching;

  final _scrollController = ScrollController();
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  SearchScreenState(
      {this.searchType: searchTypeStory,
      this.searchString: "",
      this.isSearching: false});

  void setSearchType(int newType) {
    setState(() {
      searchType = newType;
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

  void startSearch(String s, int type) {
    _focusNode.unfocus();
    if (s.length > 0) {
      setState(() {
        searchString = s;
        searchType = type;
        isSearching = true;
      });
    }
  }

  Widget buildTitleBar(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      style: TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.search, color: Colors.white),
          hintText: '搜索' + "...",
          hintStyle: TextStyle(color: Colors.white70)),
      onChanged: (s) => setSearchString(s),
      onSubmitted: (s) {
        startSearch(s, searchTypeStory);
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
                        startSearch(searchString, type);
                      },
                    )))))
            .values
            .toList(),
      ),
    );
  }

  List<Widget> _buildSlivers(BuildContext context) {
    List<Widget> slivers = new List<Widget>();

    SliverAppBar bar = SliverAppBar(
      leading: DrawerButton(),
      title: buildTitleBar(context),
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

class SearchScreenModel extends FetchedListModel {
  final SearchResult searchResult;
  final bool loading;
  final String lastError;
  final String searchString;
  final int searchType;

  SearchScreenModel({
    @required this.searchResult,
    @required this.loading,
    @required this.lastError,
    @required this.searchString,
    @required this.searchType,
  });

  static final fromStateAndStore =
      (SearchScreenState state) => (Store<AppState> store) => SearchScreenModel(
            loading: store.state.uiState.content.searchResult.loading,
            lastError: store.state.uiState.content.searchResult.lastError,
            searchResult: store.state.uiState.content.searchResult,
            searchString: state.searchString,
            searchType: state.searchType,
          );

  @override
  bool operator ==(other) {
    return other is SearchScreenModel &&
        loading == other.loading &&
        lastError == other.lastError &&
        searchResult == other.searchResult;
  }

  @override
  int get hashCode => hash3(loading, lastError, searchResult);

  @override
  int get itemCount {
    int count;
    BuiltList list;
    switch (searchResult.searchType) {
      case searchTypeStory:
        list = searchResult?.stories?.stories;
        break;
      case searchTypeUser:
        list = searchResult?.users?.user;
        break;
      case searchTypeForum:
        list = searchResult?.forums?.forumInfo;
        break;
    }
    count = list?.length ?? 0;

    return count;
  }

  @override
  Widget createListItem(BuildContext context, int index) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    var item;

    if (searchResult.searchType == searchTypeStory) {
      Story story = searchResult.stories.stories[index];

      item = StoryItem(
        story: story,
        onTap: () => onStoryTap(context, story),
      );
    } else if (searchResult.searchType == searchTypeUser) {
      UserInfo user = searchResult.users.user[index];

      item = UserItem(
        user: user,
        onTap: () => onUserTap(context, user),
      );
    } else if (searchResult.searchType == searchTypeForum) {
      ForumInfoResult info = searchResult.forums.forumInfo[index];

      Forum forum = Forum().rebuild((b) => b
        ..fid = info.fid
        ..name = stripHtmlTag(info.name));
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
            "网络错误：$error。请稍后重试",
            style: const TextStyle(color: Colors.white),
          ));
    }
    return null;
  }

  @override
  APIRequest get fetchFromScratchRequest {
    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {});
    return SearchNewRequest(completer, searchString, searchType);
  }

  @override
  APIRequest get loadMoreRequest {
    int nexttime;
    switch (searchType) {
      case searchTypeStory:
        nexttime = searchResult.stories?.nexttime;
        break;
      case searchTypeUser:
        nexttime = searchResult.users?.nexttime;
        break;
      case searchTypeForum:
        nexttime = searchResult.forums?.nexttime;
        break;
    }

    if (nexttime == null || nexttime == 0) {
      return null;
    }

    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {});
    return SearchLoadMoreRequest(completer, searchString, searchType, nexttime);
  }

  @override
  APIRequest get refreshRequest => null;

  @override
  void listIsReady(BuildContext context) {}

  @override
  Widget buildListView(BuildContext context) {
    var placeHolder;
    if (searchString != searchResult.searchString ||
        searchType != searchResult.searchType) {
      if (loading != true && lastError == null) {
        handleFetchFromScratch(context);
      }
      placeHolder = Center(child: CircularProgressIndicator());
    }

    if (placeHolder != null) {
      return SliverList(
        delegate: SliverChildListDelegate(
          [placeHolder],
        ),
      );
    }

    return super.builderSection(context, 0);
  }
}
