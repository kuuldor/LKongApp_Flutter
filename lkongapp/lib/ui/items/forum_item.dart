import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
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
              radius: 24.0,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      forum.name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    // Text(timeAgoSinceDate(parseDatetime(forum.dateline))),
                  ],
                ),
              ),
            ),
            info != null
                ? Column(
                    children: <Widget>[
                      Icon(Icons.message),
                      Text("${info.todayposts}"),
                    ],
                  )
                : Container(),
          ],
        ),
      ]),
      subtitle:
          info != null ? Text(html2Text(info.description), maxLines: 8) : null,
    );
  }
}
