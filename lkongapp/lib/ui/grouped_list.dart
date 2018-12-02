import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:lkongapp/ui/modeled_app.dart';

import 'package:lkongapp/utils/utils.dart';
import 'package:lkongapp/actions/actions.dart';

abstract class GroupedListModel {
  var scrollController = ScrollController();

  SliverAppBar get appBar;

  int get numberOfSections;

  int countOfItemsInSection({@required int section});

  Widget headerForSection(BuildContext context, {@required int section});

  Widget cellForSectionAndIndex(BuildContext context,
      {@required int section, @required int index});

  List<Widget> _buildSlivers(BuildContext context) {
    List<Widget> slivers = new List<Widget>();

    SliverAppBar bar = appBar;
    if (bar != null) {
      slivers.add(bar);
    }

    for (int i = 0; i < numberOfSections; i++) {
      slivers.add(_builderSection(context, i));
    }

    return slivers;
  }

  Widget _builderSection(BuildContext context, int section) {
    var header = headerForSection(context, section: section);
    var list = SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) =>
            cellForSectionAndIndex(context, section: section, index: i),
        childCount: countOfItemsInSection(section: section),
      ),
    );

    return header == null
        ? list
        : SliverStickyHeader(
            header: header,
            sliver: list,
          );
  }

  Widget buildGroupedListView(BuildContext context) {
    return new CustomScrollView(
      controller: scrollController,
      slivers: _buildSlivers(context),
    );
  }
}
