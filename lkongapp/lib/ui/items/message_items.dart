import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/utils.dart';

import 'package:lkongapp/ui/tools/item_handler.dart';

class NoticeItem extends StatelessWidget {
  final Notice notice;

  static final noticeItemKey = (int id) => Key('__notice_item_${id}__');

  NoticeItem({
    @required this.notice,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: comment2Widget(
                context,
                notice.note,
                style: Theme.of(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RatelogItem extends StatelessWidget {
  final Ratelog ratelog;

  static final ratelogItemKey = (int id) => Key('__ratelog_item_${id}__');

  RatelogItem({
    @required this.ratelog,
  });

  @override
  Widget build(BuildContext context) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    TextStyle style = theme.themeData.primaryTextTheme.headline;

    return ListTile(
        title: Container(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  buildUserAvatar(context, ratelog.uid, 36.0, clickable: true),
                  Container(
                    width: 4.0,
                  ),
                  Text(
                    ratelog.username,
                    style:
                        style.copyWith(color: theme.linkColor, fontSize: 18.0),
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(dateStringToLocal(ratelog.dateline), style: style)),
                  ),
                ]),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("${ratelog.message}",
                          style: style.copyWith(fontSize: 20.0)),
                    ),
                  ],
                ),
                // Divider()
              ],
            )),
        subtitle: Row(
          children: <Widget>[
            Container(
              width: 120.0,
              child: Text("评分：${ratelog.score} ${ratelog.extcredits}",
                  style: style.apply(color: Colors.lightGreen)),
            ),
            Expanded(
              child: Text(
                "${ratelog.reason}",
              ),
            ),
          ],
        ));
  }
}

class PMItem extends StatelessWidget {
  final PrivateMessage pm;

  static final pmItemKey = (int id) => Key('__pm_item_${id}__');

  PMItem({
    @required this.pm,
  });

  @override
  Widget build(BuildContext context) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    TextStyle style = theme.themeData.primaryTextTheme.headline;

    return ListTile(
      title: Container(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                buildUserAvatar(context, pm.uid, 36.0, clickable: true),
                Container(
                  width: 4.0,
                ),
                Text(
                  pm.username,
                  style: style.copyWith(color: theme.linkColor, fontSize: 18.0),
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(dateStringToLocal(pm.dateline), style: style)),
                ),
              ]),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text("${stripHtmlTag(pm.message)}",
                        style: style.copyWith(fontSize: 20.0)),
                  ),
                ],
              ),
              // Divider()
            ],
          )),
    );
  }
}