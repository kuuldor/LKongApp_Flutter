import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:lkongapp/ui/items/item_wrapper.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/theme.dart';

class EmojiPicker extends StatefulWidget {
  final Function(BuildContext, int) onEmojiTapped;

  const EmojiPicker({Key key, @required this.onEmojiTapped})
      : assert(onEmojiTapped != null),
        super(key: key);

  @override
  EmojiPickerState createState() {
    return EmojiPickerState();
  }
}

class EmojiPickerState extends State<EmojiPicker> {
  var scrollController = ScrollController();

  static final yojimonkey = List<int>.generate(66, (i) => i + 50);
  static final onions = List<int>.generate(29, (i) => i + 218)
    ..addAll(List<int>.generate(37, (i) => i + 250))
    ..addAll(List<int>.generate(22, (i) => i + 289));

  @override
  Widget build(BuildContext context) {
    return buildGroupedListView(context);
  }

  SliverAppBar buildAppBar(BuildContext _) => SliverAppBar(
        title: Text('表情包'),
        floating: false,
        pinned: true,
      );

  int get numberOfSections => 2;

  int get numberOfColumns => 6;

  int countOfItemsInSection({int section}) {
    int count = 0;
    switch (section) {
      case 0:
        count = yojimonkey.length;
        break;
      case 1:
        count = onions.length;
        break;
    }
    return count;
  }

  Widget cellForSectionAndIndex(BuildContext context,
      {int section, int index}) {
    int emid;
    switch (section) {
      case 0:
        emid = yojimonkey[index];
        break;
      case 1:
        emid = onions[index];
        break;
    }

    if (emid != null) {
      return createImageGridItem(context, emid);
    }

    return null;
  }

  Widget headerForSection(BuildContext context, {int section}) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    final style = theme.subheadStyle;

    String headerText;

    switch (section) {
      case 0:
        headerText = '悠嘻猴';
        break;
      case 1:
        headerText = '洋葱头';
        break;
    }

    if (headerText != null) {
      return Container(
          color: Colors.grey[500].withAlpha(240),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "$headerText",
            style: style.apply(color: Colors.white),
          ));
    }

    return null;
  }

  Widget fillupForEmptyView(BuildContext context) {
    return null;
  }

  List<Widget> buildSlivers(BuildContext context) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;

    List<Widget> slivers = new List<Widget>();

    SliverAppBar bar = buildAppBar(context);
    if (bar != null) {
      slivers.add(bar);
    }

    for (int i = 0; i < numberOfSections; i++) {
      slivers.add(builderSection(context, i));
    }

    final fillup = fillupForEmptyView(context);
    if (fillup != null) {
      slivers.add(SliverFillRemaining(
        child: Container(
          color: theme.pageColor,
          child: fillup,
        ),
      ));
    }
    return slivers;
  }

  Widget builderSection(BuildContext context, int section) {
    var header = headerForSection(context, section: section);
    var list = SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: numberOfColumns,
      ),
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
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: scrollController,
      slivers: buildSlivers(context),
    );
  }

  Widget createImageGridItem(BuildContext context, int emid) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    final emoji = "em$emid.gif";
    final item = Material(
        color: theme.pageColor,
        child: Ink.image(
            image: AssetImage(
              "assets/bq/$emoji",
            ),
            fit: BoxFit.cover,
            child: InkWell(onTap: () => widget.onEmojiTapped(context, emid))));
    return item;
  }
}
