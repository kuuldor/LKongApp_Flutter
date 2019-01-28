import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/utils.dart';

class StoryItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final Story story;
  final bool showDetailTime;

  static final storyItemKey = (id) => Key('__story_item_${id}__');

  StoryItem({
    @required this.onTap,
    @required this.story,
    @required this.showDetailTime,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LKModeledApp.modelOf(context).theme;
    TextStyle titleStyle = theme.titleStyle;
    TextStyle subheadStyle = theme.subheadStyle;
    TextStyle subtitleStyle = theme.subtitleStyle;
    double size = theme.captionSize;

    Widget title;
    Widget subtitle;

    final timestamp = parseDatetime(story.dateline);
    final datetime = showDetailTime
        ? stringFromDate(timestamp)
        : timeAgoSinceDate(timestamp);

    if (story.isthread != false) {
      if (story.digest != null && story.digest != 0) {
        titleStyle = titleStyle.apply(fontWeightDelta: 2);
      }

      title = Column(children: <Widget>[
        Row(
          children: <Widget>[
            buildUserAvatar(context, story.uid, theme.subheadSize * 2 + 4),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: size * 2 / 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(story.username, style: subheadStyle),
                    Text(datetime, style: subheadStyle),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                (story.closed == 1
                    ? Icon(Icons.lock, size: theme.subheadSize)
                    : Icon(Icons.message, size: theme.subheadSize)),
                Text("${story.replynum ?? story.tReplynum}",
                    style: subheadStyle),
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
        subtitle = Text(stripHtmlTag(story.message),
            maxLines: 4, style: subtitleStyle);
      }
    } else {
      String message;
      if (story.isquote) {
        message = story.message;
      } else {
        message =
            "<blockquote><a href='' dataitem='name_${story.tAuthor}'>@${story.tAuthor}</a>：<b>${story.subject}</b></a></blockquote><div>${story.message}</div>";
      }
      title = Column(children: <Widget>[
        Row(
          children: <Widget>[
            buildUserAvatar(context, story.uid, theme.subheadSize * 2 + 4),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: size * 2 / 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(story.username, style: subheadStyle),
                    Text(datetime, style: subheadStyle),
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
