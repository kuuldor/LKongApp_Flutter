import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/utils.dart';

import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/ui/tools/item_handler.dart';
import 'package:redux/redux.dart';

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
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UserHeader extends StatelessWidget {
  final UserMessage message;

  const UserHeader({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final theme = LKModeledApp.modelOf(context).theme;
    TextStyle subheadStyle = theme.subheadStyle;

    final timestamp = parseDatetime(message.dateline);
    final datetime = showDetailTime(store)
        ? stringFromDate(timestamp)
        : timeAgoSinceDate(timestamp);

    return Row(children: <Widget>[
      buildUserAvatar(context, message.uid, theme.subheadSize * 2 + 4,
          clickable: true),
      Container(
        width: 4.0,
      ),
      GestureDetector(
          child: Text(
            message.username,
            style: subheadStyle.apply(color: theme.linkColor),
          ),
          onTap: () {
            onUserTap(
                context,
                UserInfo().rebuild((b) => b
                  ..uid = message.uid
                  ..username = message.username));
          }),
      Expanded(
        child: Align(
            alignment: Alignment.centerRight,
            child: Text(datetime, style: subheadStyle)),
      ),
    ]);
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
    final theme = LKModeledApp.modelOf(context).theme;
    TextStyle titleStyle = theme.titleStyle;
    TextStyle subtitleStyle = theme.subtitleStyle;

    return ListTile(
        onTap: () {
          openThreadView(context, null, postId: ratelog.pid);
        },
        title: Container(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
            child: Column(
              children: <Widget>[
                UserHeader(
                  message: ratelog,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("${ratelog.message}", style: titleStyle),
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
                  style: subtitleStyle.apply(color: Colors.lightGreen)),
            ),
            Expanded(
              child: Text(
                "${ratelog.reason}",
                style: subtitleStyle,
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
    final theme = LKModeledApp.modelOf(context).theme;
    TextStyle style = theme.titleStyle;

    return ListTile(
      onTap: () {
        onPMTap(context, pm.uid);
      },
      title: Container(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
          child: Column(
            children: <Widget>[
              UserHeader(
                message: pm,
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text("${stripHtmlTag(pm.message)}", style: style),
                  ),
                ],
              ),
              // Divider()
            ],
          )),
    );
  }
}

class PMConciseItem extends StatelessWidget {
  final PrivateMessage pm;

  static final pmItemKey = (int id) => Key('__pm_item_${id}__');

  PMConciseItem(this.pm);

  @override
  Widget build(BuildContext context) {
    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    TextStyle subheadStyle = theme.subheadStyle;
    TextStyle subtitleStyle = theme.subtitleStyle;

    final datetime = dateStringToLocal(pm.dateline);

    Color bgColor;
    MainAxisAlignment align;
    CrossAxisAlignment colAlign;

    if (pm.msgfromid == 0) {
      bgColor = Colors.green[600];
      align = MainAxisAlignment.end;
      colAlign = CrossAxisAlignment.end;
    } else {
      bgColor = Colors.lightBlue[600];
      align = MainAxisAlignment.start;
      colAlign = CrossAxisAlignment.start;
    }

    final content = Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      width: MediaQuery.of(context).size.width - 80,
      child: Column(
        crossAxisAlignment: colAlign,
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(4.0, 0, 0, 0),
              child: Text(datetime, style: subtitleStyle)),
          SizedBox(
            height: 2.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0), color: bgColor),
            child: Text(pm.message, style: subheadStyle),
          ),
        ],
      ),
    );

    final imageDim = theme.subheadSize * 2;
    final avatar = Column(
      crossAxisAlignment: colAlign,
      children: <Widget>[
        Container(
            padding: EdgeInsets.fromLTRB(4.0, 0, 0, 0),
            child: Text(" ", style: subheadStyle)),
        SizedBox(
          height: 2.0,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: Image(
            width: imageDim,
            image: pm.uid != null && pm.uid > 0
                ? CachedNetworkImageProvider(avatarForUserID(pm.uid),
                    imageOnError: "assets/noavatar.png")
                : AssetImage("assets/noavatar.png"),
          ),
        ),
      ],
    );

    var items = <Widget>[avatar, content];
    if (pm.msgfromid == 0) {
      items = items.reversed.toList();
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: Row(
        mainAxisAlignment: align,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items,
      ),
    );
  }
}
