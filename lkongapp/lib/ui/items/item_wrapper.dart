import 'package:flutter/material.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/utils.dart';

Widget wrapItemAsCard(BuildContext context, Widget item,
    {bool clickable: true}) {
  LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
  double size = theme.captionSize;

  if (clickable) {
    //To keep the tapping ripple effect, we must wrap the item with this
    item = Material(
      color: Colors.transparent,
      child: InkWell(
        child: item,
        onTap: () {}, //onTap needs to be non-null to have the ripple effect
      ),
    );
  }

  return Column(children: <Widget>[
    SizedBox(height: size / 3),
    Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        padding: EdgeInsets.symmetric(vertical: size),
        decoration: BoxDecoration(
          color: theme.pageColor,
          boxShadow: [
            new BoxShadow(
              color: theme.lightTextColor,
              blurRadius: 2.0,
              offset: Offset(0.0, 1.0),
            )
          ],
        ),
        child: item),
    SizedBox(height: size / 3),
  ]);
}

Widget wrapItem(BuildContext context, Widget item) {
  LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
  double size = theme.captionSize;

  return Column(children: <Widget>[
    SizedBox(height: 2.0),
    item,
    Divider(
      height: size,
    ),
  ]);
}

Widget wrapItemNoDivider(BuildContext context, Widget item) {
  LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
  double size = theme.captionSize;

  return Column(children: <Widget>[
    SizedBox(height: size / 2.0),
    item,
  ]);
}
