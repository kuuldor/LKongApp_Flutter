import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/async_avatar.dart';
import 'package:lkongapp/utils/utils.dart';

class StoryItem extends StatefulWidget {
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
  StoryItemState createState() {
    return StoryItemState();
  }
}

class StoryItemState extends State<StoryItem> with AvatarLoaderState {
  bool disposed;

  @override
  void initState() {
    super.initState();
    disposed = false;
  }

  @override
  void dispose() {
    super.dispose();
    disposed = true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = LKModeledApp.modelOf(context).theme;
    TextStyle titleStyle = theme.titleStyle;
    TextStyle subheadStyle = theme.subheadStyle;
    TextStyle subtitleStyle = theme.subtitleStyle;
    double size = theme.captionSize;

    Widget title;
    Widget subtitle;

    final timestamp = parseDatetime(widget.story.dateline);
    final datetime = widget.showDetailTime
        ? stringFromDate(timestamp)
        : timeAgoSinceDate(timestamp);

    final avatar = asyncUserAvatar(
      context,
      this,
      widget.story.uid,
      theme.subheadSize * 2 + 4,
      delayInMillies: 1000,
    );

    if (widget.story.isthread != false) {
      if (widget.story.digest != null && widget.story.digest != 0) {
        titleStyle = titleStyle.apply(fontWeightDelta: 2);
      }

      title = Column(children: <Widget>[
        Row(
          children: <Widget>[
            avatar,
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: size * 2 / 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.story.username, style: subheadStyle),
                    Text(datetime, style: subheadStyle),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                (widget.story.closed == 1
                    ? Icon(Icons.lock, size: theme.subheadSize)
                    : Icon(Icons.message, size: theme.subheadSize)),
                Text("${widget.story.replynum ?? widget.story.tReplynum}",
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
                  widget.story.subject,
                  style: titleStyle,
                ),
              ),
            ],
          ),
        ),
      ]);
      if (widget.story.message != null) {
        subtitle = Text(stripHtmlTag(widget.story.message),
            maxLines: 4, style: subtitleStyle);
      }
    } else {
      String message;
      if (widget.story.isquote) {
        message = widget.story.message;
      } else {
        message =
            "<blockquote><a href='' dataitem='name_${widget.story.tAuthor}'>@${widget.story.tAuthor}</a>：<b>${widget.story.subject}</b></a></blockquote><div>${widget.story.message}</div>";
      }
      title = Column(children: <Widget>[
        Row(
          children: <Widget>[
            avatar,
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: size * 2 / 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.story.username, style: subheadStyle),
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
      key: StoryItem.storyItemKey(widget.story.id),
      onTap: widget.onTap,
      title: title,
      subtitle: subtitle,
    );
  }
}
