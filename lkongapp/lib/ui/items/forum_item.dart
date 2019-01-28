import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/utils.dart';

class ForumItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Forum forum;
  final ForumInfoResult info;

  static final forumItemKey = (id) => Key('__forum_item_${id}__');

  ForumItem({
    @required this.onTap,
    @required this.forum,
    this.info,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LKModeledApp.modelOf(context).theme;
    TextStyle titleStyle = theme.titleStyle;
    TextStyle subheadStyle = theme.subheadStyle;
    TextStyle subtitleStyle = theme.subtitleStyle;

    return ListTile(
      key: forumItemKey(forum.fid),
      onTap: onTap,
      title: Column(children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: CachedNetworkImageProvider(
                  avatarForForumID(forum.fid),
                  imageOnError: "assets/image_placeholder.png"),
              radius: theme.titleSize + 4,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      forum.name,
                      style: titleStyle,
                    ),
                    // Text(timeAgoSinceDate(parseDatetime(forum.dateline))),
                  ],
                ),
              ),
            ),
            info != null && info.todayposts != null
                ? Column(
                    children: <Widget>[
                      Icon(Icons.message),
                      Text("${info.todayposts}", style: subheadStyle),
                    ],
                  )
                : Container(),
          ],
        ),
      ]),
      subtitle: info != null && info.description != null
          ? Container(
              padding: EdgeInsetsDirectional.only(top: 8.0),
              child: Text(info.description, maxLines: 8, style: subtitleStyle))
          : null,
    );
  }
}
