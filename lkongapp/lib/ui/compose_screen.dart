import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/utils/utils.dart';

enum ReplyType {
  Forum,
  Story,
  Comment,
}

class ComposeScreen extends StatefulWidget {
  final dynamic replyTo;
  final ReplyType replyType;

  const ComposeScreen({Key key, this.replyTo, this.replyType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ComposeState();
  }
}

class ComposeState extends State<ComposeScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var subjectController = TextEditingController();
  var contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String title;

    switch (widget.replyType) {
      case ReplyType.Forum:
        final forum = widget.replyTo as Forum;
        title = "发帖：${forum.name}";
        break;
      case ReplyType.Story:
        final story = widget.replyTo as StoryInfoResult;
        title = "回复：${story.subject}";
        break;
      case ReplyType.Comment:
        final comment = widget.replyTo as Comment;
        title = "回复：${comment.author}";
        break;
    }

    final ValueKey _subjectKey = LKongAppKeys.composeSubjectKey;
    final ValueKey _contentKey = LKongAppKeys.comoposeContentKey;

    final email = widget.replyType == ReplyType.Forum
        ? TextFormField(
            key: _subjectKey,
            controller: subjectController,
            autofocus: false,
            validator: (val) =>
                val.isEmpty || val.trim().length == 0 ? '请输入标题' : null,
            decoration: InputDecoration(
              hintText: '标题',
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
            ),
          )
        : Container();

    final password = TextFormField(
      controller: contentController,
      key: _contentKey,
      autocorrect: false,
      keyboardType: TextInputType.multiline,
      maxLines: 1000,
      autofocus: true,
      validator: (val) =>
          val.isEmpty || val.trim().length == 0 ? '请输入内容' : null,
      decoration: InputDecoration(
        hintText: '内容',
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
    );

    final form = Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          email,
          SizedBox(height: 8.0),
          Expanded(
            child: password,
          ),
          SizedBox(height: 32.0),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: form,
    );
  }
}
