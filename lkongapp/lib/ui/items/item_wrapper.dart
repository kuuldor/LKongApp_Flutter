import 'package:flutter/material.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/utils.dart';

Widget wrapItemAsCard(BuildContext context, Widget item) {
  LKongAppTheme theme = LKModeledApp.modelOf(context).theme;

  return Column(children: <Widget>[
    SizedBox(height: 2.0),
    Container(
      margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        color: theme.pageColor,
        boxShadow: [
          new BoxShadow(
            color: theme.lightTextColor,
            blurRadius: 0.2,
            offset: Offset(0.0, 0.3),
          )
        ],
      ),
      child: item,
    ),
    SizedBox(height: 6.0),
  ]);
}

Widget wrapItem(BuildContext context, Widget item) {
  LKongAppTheme theme = LKModeledApp.modelOf(context).theme;

  return Column(children: <Widget>[
    SizedBox(height: 6.0),
    item,
    Divider(),
  ]);
}
