import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';

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
      title: Container(
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
      
      subtitle: Text(story.message, maxLines: 4),
    );
  }
}
