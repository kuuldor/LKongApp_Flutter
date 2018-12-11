import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/models/theme.dart';
import 'package:lkongapp/models/user.dart';
import 'package:lkongapp/utils/utils.dart';

class UserItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final UserInfo user;

  static final userItemKey = (id) => Key('__user_item_${id}__');

  UserItem({
    @required this.onTap,
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: userItemKey(user.uid),
      onTap: onTap,
      title: Column(children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: CachedNetworkImageProvider(
                  avatarForUserID(user.uid),
                  imageOnError: "assets/noavatar.png"),
              radius: 24.0,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      stripHtmlTag(user.username),
                      style: Theme.of(context).textTheme.title,
                    ),
                    // Text(timeAgoSinceDate(parseDatetime(forum.dateline))),
                  ],
                ),
              ),
            ),
            user.verify == true
                ? Column(
                    children: <Widget>[
                      Icon(Icons.verified_user, color: htmlColor("#ff8833"),),
                    ],
                  )
                : Container(),
          ],
        ),
      ]),
      subtitle: user != null && user.customstatus.length > 0
          ? Text(stripHtmlTag(user.customstatus), maxLines: 8)
          : null,
    );
  }
}
