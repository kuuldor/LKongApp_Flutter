import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/utils.dart';

import 'package:lkongapp/ui/tools/item_handler.dart';

enum CommentAction {
  Reply,
  Edit,
  UpVote,
}

class CommentItem extends StatelessWidget {
  final Function(CommentAction) onTap;
  final Comment comment;
  final int uid;

  static final commentItemKey = (int id) => Key('__comment_item_${id}__');

  CommentItem({
    @required this.onTap,
    @required this.comment,
    @required this.uid,
  });

  Widget buildRateLog(BuildContext context, BuiltList<Ratelog> ratelog) {
    if (ratelog == null || ratelog.length == 0) {
      return Container();
    }

    LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
    TextStyle style = TextStyle(fontSize: 14.0, color: theme.mediumTextColor);

    var list = <Widget>[];
    final creditName = {2: '龙币', 3: '龙晶'};
    var coins = 0, crystals = 0;
    for (int i = 0; i < ratelog.length; i++) {
      final rate = ratelog[i];
      if (rate.extcredits == 2) {
        coins += rate.score;
      } else if (rate.extcredits == 3) {
        crystals += rate.score;
      }

      Color color = (i % 2) == 0 ? theme.pageColor : theme.quoteBG;

      list.add(Container(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
          color: color,
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Container(
                    height: 24.0,
                    child: Image(
                      image: CachedNetworkImageProvider(
                          avatarForUserID(rate.uid),
                          imageOnError: "assets/noavatar.png"),
                    )),
                Container(
                  width: 4.0,
                ),
                Text(
                  rate.username,
                  style: style.apply(color: theme.linkColor),
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("${rate.dateline}", style: style)),
                ),
              ]),
              Row(
                children: <Widget>[
                  Container(
                    width: 120.0,
                    child: Text(
                        "评分：${rate.score} ${creditName[rate.extcredits]}",
                        style: style.apply(color: Colors.lightGreen)),
                  ),
                  Expanded(
                    child: Text(
                      "${rate.reason}",
                      style: style,
                    ),
                  ),
                ],
              ),
              // Divider()
            ],
          )));
    }
    var credits = "";
    if (coins > 0) {
      credits += "龙币+$coins";
    }
    if (crystals > 0) {
      credits += "   龙晶+$crystals";
    }
    list.insert(
        0,
        Container(
          padding: EdgeInsets.all(4.0),
          margin: EdgeInsets.symmetric(vertical: 4.0),
          child: Column(children: <Widget>[
            Row(children: <Widget>[
              Container(
                  width: 120,
                  child: Text(
                    "已有${ratelog.length}次评分",
                    style: style.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  )),
              Text("评分总额：$credits",
                  style: style.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.orange)),
            ]),
            // Divider()
          ]),
        ));

    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(3.0)),
        child: Column(
          children: list,
        ));
  }

  @override
  Widget build(BuildContext context) {
    var messages = List<Widget>();
    if (comment.warning) {
      messages.add(Container(
          color: Colors.redAccent,
          child: Row(
            children: <Widget>[
              Icon(Icons.warning),
              Text(
                comment.warningReason,
              ),
            ],
          )));
    }

    var actionButtons = <Widget>[
      IconButton(
        icon: Icon(Icons.thumb_up),
        onPressed: () {
          onTap(CommentAction.UpVote);
        },
      ),
      IconButton(
        icon: Icon(Icons.message),
        onPressed: () {
          onTap(CommentAction.Reply);
        },
      ),
    ];

    if (comment.authorid == uid) {
      actionButtons.insert(
          0,
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              onTap(CommentAction.Edit);
            },
          ));
    }

    return Container(
      key: commentItemKey(comment.id),
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            buildUserAvatar(context, comment.authorid, 36.0, clickable: true),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(comment.author),
                    Text(timeAgoSinceDate(parseDatetime(comment.dateline))),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Icon(Icons.layers),
                Text("${comment.lou}楼"),
              ],
            ),
          ],
        ),
        Container(
          height: 12.0,
        ),
        comment.warning
            ? Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(6.0)),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.warning),
                    Container(width: 8.0),
                    Text(
                      "此帖被警告。理由：${comment.warningReason}",
                    ),
                  ],
                ))
            : Container(),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: comment2Widget(
                  context,
                  comment.message,
                  style: Theme.of(context),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 12.0,
        ),
        buildRateLog(context, comment.ratelog),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: actionButtons,
          ),
        ),
      ]),
    );
  }
}
