import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/utils/utils.dart';

class CommentItem extends StatelessWidget {
  // final GestureTapCallback onTap;
  final Comment comment;

  static final storyItemKey = (int id) => Key('__story_item_${id}__');

  CommentItem({
    // @required this.onTap,
    @required this.comment,
  });

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

    return ListTile(
      // onTap: onTap,
      title: Column(children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: CachedNetworkImageProvider(
                  avatarForUserID(comment.authorid),
                  imageOnError: "assets/noavatar.png"),
              radius: 16.0,
            ),
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
                    color: Colors.red[300],
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
      ]),
    );
  }
}
