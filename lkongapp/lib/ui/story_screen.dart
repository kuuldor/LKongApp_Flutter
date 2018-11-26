import 'package:flutter/material.dart';

import 'package:lkongapp/ui/story_content.dart';
import 'package:lkongapp/ui/connected_widget.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

class StoryScreen extends StatelessWidget {
  final int storyId;
  final int postId;
  final int page;

  StoryScreen({Key key, @required this.storyId, this.postId, this.page: 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryContent(storyId: storyId, postId: postId, page: page),
    );
  }
}
