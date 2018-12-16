import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/utils.dart';

class StoryItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Story story;

  static final storyItemKey = (id) => Key('__story_item_${id}__');

  StoryItem({
    @required this.onTap,
    @required this.story,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LKModeledApp.modelOf(context).theme;

    Widget title;
    Widget subtitle;

    if (story.isthread != false) {
      var titleStyle = Theme.of(context).textTheme.title;
      if (story.digest != null && story.digest != 0) {
        titleStyle = titleStyle.apply(fontWeightDelta: 1);
      } else {
        titleStyle = titleStyle.apply(fontWeightDelta: -1);
      }
      titleStyle = titleStyle.apply(color: theme.darkTextColor);
      title = Column(children: <Widget>[
        Row(
          children: <Widget>[
            buildUserAvatar(context, story.uid, 36.0),
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
                  style: titleStyle,
                ),
              ),
            ],
          ),
        ),
      ]);
      if (story.message != null) {
        subtitle = Text(stripHtmlTag(story.message), maxLines: 4);
      }
    } else {
      String message;
      if (story.isquote) {
        message = story.message;
      } else {
        message =
            "<blockquote><a href='' dataitem='name_${story.tAuthor}'>@${story.tAuthor}</a><br><b>${story.subject}</b></a></blockquote><div>${story.message}</div>";
      }
      title = Column(children: <Widget>[
        Row(
          children: <Widget>[
            buildUserAvatar(context, story.uid, 36.0),
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
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                child: comment2Widget(
                  context,
                  message,
                  style: Theme.of(context),
                ),
              ),
            ],
          ),
        ),
      ]);
    }

    return ListTile(
      key: storyItemKey(story.id),
      onTap: onTap,
      title: title,
      subtitle: subtitle,
    );
  }
}
