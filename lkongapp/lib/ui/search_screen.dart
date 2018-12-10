import 'package:lkongapp/ui/app_drawer.dart';
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

import 'story_list.dart';

enum SearchType {
  Story,
  User,
  Forum,
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends StoryListState<SearchScreen> {
  String searchString;
  SearchType searchType;
  bool isSearching;

  final _scrollController = ScrollController();
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  SearchScreenState(
      {this.searchType: SearchType.Story,
      this.searchString: "",
      this.isSearching: false});

  void setSearchType(SearchType newType) {
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
  }

  void startSearch(String searchString, SearchType type) {
    _focusNode.unfocus();
    setSearching(true);
    setSearchType(type);
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
        startSearch(s, searchType);
      },
    );
  }

  Widget buildSearchList(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Text("搜索类型：${searchType.toString()}\n搜索内容：${searchString.toString()}")
        ],
      ),
    );
  }

  Widget buildSearchPrompt(BuildContext context) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    return SliverList(
      delegate: SliverChildListDelegate(
        {SearchType.Story: '帖子', SearchType.User: '用户', SearchType.Forum: '版块'}
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

    if (!isSearching && searchString != null && searchString.length > 0) {
      slivers.add(buildSearchPrompt(context));
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
