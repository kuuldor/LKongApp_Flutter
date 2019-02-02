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
  final int author;
  final bool showDetailTime;
  final bool detectLink;
  final bool concise;

  static final commentItemKey = (int id) => Key('__comment_item_${id}__');

  CommentItem({
    @required this.onTap,
    @required this.comment,
    @required this.uid,
    @required this.author,
    @required this.showDetailTime,
    @required this.detectLink,
    this.concise: false,
  });

  Widget buildRateLog(BuildContext context, BuiltList<Ratelog> ratelog) {
    if (ratelog == null || ratelog.length == 0) {
      return Container();
    }

    final theme = LKModeledApp.modelOf(context).theme;
    TextStyle style = theme.subheadStyle.apply(color: theme.mediumTextColor);

    var list = <Widget>[];
    final creditName = {"2": '龙币', "3": '龙晶'};
    var coins = 0, crystals = 0;
    for (int i = 0; i < ratelog.length; i++) {
      final rate = ratelog[i];
      if (rate.extcredits == "2") {
        coins += rate.score;
      } else if (rate.extcredits == "3") {
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
                    height: theme.titleSize,
                    child: Image(
                      image: CachedNetworkImageProvider(
                          avatarForUserID(rate.uid),
                          imageOnError: "assets/noavatar.png"),
                    )),
                Container(
                  width: 4.0,
                ),
                Text(
                  rate.username ?? '',
                  style: style.apply(color: theme.linkColor),
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child:
                          Text(dateStringToLocal(rate.dateline), style: style)),
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
      credits += "龙币+$coins   ";
    }
    if (crystals > 0) {
      credits += "龙晶+$crystals";
    } else if (crystals < 0) {
      credits += "龙晶$crystals";
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
    final theme = LKModeledApp.modelOf(context).theme;
    TextStyle subheadStyle = theme.subheadStyle;
    TextStyle subtitleStyle = theme.subtitleStyle;
    double size = theme.captionSize;

    final textContent = Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Expanded(
            child: comment2Widget(
              context,
              comment.message,
              detectLink: detectLink,
            ),
          )
        ],
      ),
    );

    if (concise) {
      return Container(
        key: commentItemKey(comment.id),
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: textContent,
      );
    }

    var actionButtons = <Widget>[];
    if (uid != null && uid > 0) {
      if (comment.authorid == uid) {
        actionButtons.add(IconButton(
          iconSize: size * 2,
          icon: Icon(Icons.edit),
          onPressed: () {
            onTap(CommentAction.Edit);
          },
        ));
      } else {
        actionButtons.add(IconButton(
          iconSize: size * 2,
          icon: Icon(Icons.thumb_up),
          onPressed: () {
            onTap(CommentAction.UpVote);
          },
        ));
      }
      actionButtons.add(IconButton(
        iconSize: size * 2,
        icon: Icon(Icons.comment),
        onPressed: () {
          onTap(CommentAction.Reply);
        },
      ));
    }

    Widget authorLine = Text(comment.author, style: subtitleStyle);
    if (author == comment.authorid) {
      authorLine = Row(
        children: <Widget>[
          authorLine,
          SizedBox(
            width: size / 3,
          ),
          Text("[楼主]", style: subtitleStyle.apply(color: Colors.orange)),
        ],
      );
    }

    final timestamp = parseDatetime(comment.dateline);
    final datetime = showDetailTime
        ? stringFromDate(timestamp)
        : timeAgoSinceDate(timestamp);

    var rows = <Widget>[];
    rows.add(Row(
      children: <Widget>[
        buildUserAvatar(context, comment.authorid, size * 2 + 8,
            clickable: true),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: (size / 3 * 2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                authorLine,
                Text(datetime, style: subtitleStyle),
              ],
            ),
          ),
        ),
        Text("${comment.lou}楼", style: subtitleStyle),
      ],
    ));

    rows.add(Container(height: size));

    if (comment.warning == true) {
      rows.add(Container(
          padding: EdgeInsets.all(size / 2),
          decoration: BoxDecoration(
              color: Colors.red[400],
              borderRadius: BorderRadius.circular(size / 2)),
          child: Row(
            children: <Widget>[
              Icon(Icons.warning),
              Container(width: size / 3 * 2),
              Expanded(
                child: Text(
                  "此帖被警告。\n理由：${comment.warningReason}",
                  style: subheadStyle,
                ),
              ),
            ],
          )));
      rows.add(Container(height: size));
    }

    rows.add(textContent);

    rows.add(Container(
      height: size,
    ));
    rows.add(buildRateLog(context, comment.ratelog));
    rows.add(Container(
      height: size * 4,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: actionButtons,
      ),
    ));

    return Container(
      key: commentItemKey(comment.id),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(children: rows),
    );
  }
}
