import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/utils/utils.dart';

class StoryItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Story story;

  static final storyItemKey = (int id) => Key('__story_item_${id}__');

  StoryItem({
    @required this.onTap,
    @required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Column(children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: CachedNetworkImageProvider(
                  avatarForUserID(story.uid),
                  imageOnError: "assets/noavatar.png"),
              radius: 18.0,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(story.username),
                    Text(timeAgoSinceDate(parseDatetime(story.dateline))),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Icon(Icons.message),
                Text("${story.replynum ?? story.tReplynum}"),
              ],
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  story.subject,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ],
          ),
        ),
      ]),
      subtitle: Text(html2Text(story.message), maxLines: 4),
    );
  }
}
