import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/models/theme.dart';
import 'package:lkongapp/models/user.dart';
import 'package:lkongapp/ui/tools/user_icon.dart';
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
            buildUserAvatar(context, user.uid, 48.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.username,
                      style: Theme.of(context).textTheme.title,
                    ),
                    // Text(timeAgoSinceDate(parseDatetime(forum.dateline))),
                  ],
                ),
              ),
            ),
            verifyIcon(user),
          ],
        ),
      ]),
      subtitle:
          user != null && (user.customstatus != null || user.sightml != null)
              ? (user.customstatus != null && user.customstatus.length > 0
                  ? Text(user.customstatus, maxLines: 8)
                  : (user.sightml != null && user.sightml.length > 0
                      ? Text(
                          user.sightml,
                          maxLines: 8,
                        )
                      : null))
              : null,
    );
  }
}
