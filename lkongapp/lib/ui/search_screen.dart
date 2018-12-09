import 'package:lkongapp/ui/app_drawer.dart';
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

  final TextEditingController _controller = TextEditingController();

  SearchScreenState({this.searchType, this.searchString});

  void setSearchType(SearchType newType) {
    setState(() {
      searchType = newType;
    });
  }

  void setSearchString(String newSearchString) {
    setState(() {
      searchString = newSearchString;
    });
  }

  Widget buildTitleBar(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: FocusNode(),
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.search, color: Colors.white),
          hintText: '搜索' + "...",
          hintStyle: TextStyle(color: Colors.white)),
      onChanged: (s) => print(s),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: buildTitleBar(context),
        ),
        drawer: AppDrawerBuilder(),
        body: Container());
  }
}
