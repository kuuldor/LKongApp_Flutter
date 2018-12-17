import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/ui/tools/icon_message.dart';
import 'package:lkongapp/utils/utils.dart';

class ComposeScreen extends StatefulWidget {
  final Comment comment;
  final StoryInfoResult story;
  final Forum forum;

  final ReplyType replyType;

  const ComposeScreen(
      {Key key, this.comment, this.story, this.forum, this.replyType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ComposeState();
  }
}

class ComposeState extends State<ComposeScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static final String signatureLink = "http://lkong.cn/";
  static final String signaturePattern =
      r"<br>-- <a href='.*?' dataitem='signature'>.*?</a>";

  final subjectController = TextEditingController();
  final contentController = TextEditingController();

  bool hasSignature(String s) {
    RegExp pattern = RegExp(signaturePattern);
    return pattern.hasMatch(s);
  }

  String appendSignature(BuildContext context, String content) {
    if (!hasSignature(content)) {
      String signatureRaw = stateOf(context)
          .persistState
          .appConfig
          .accountSettings
          .currentSetting
          .signature;
      RegExp dotPattern = RegExp(r'(\.\*\?)(.*)(\.\*\?)');
      final signature = signaturePattern.replaceAllMapped(
          dotPattern, (Match m) => "$signatureLink${m[2]}$signatureRaw");

      content += signature;
    }

    return content;
  }

  String finalizeContent(BuildContext context, String content) {
    RegExp newlinePattern = RegExp('\n');
    content = content.replaceAllMapped(newlinePattern, (Match m) => "<br>");
    content = appendSignature(context, content);

    return content;
  }

  String stripSignature(String content) {
    RegExp pattern = RegExp(signaturePattern);
    return content.replaceFirstMapped(pattern, (Match m) => "");
  }

  void sendMessage(BuildContext context) {
    String subject;

    switch (widget.replyType) {
      case ReplyType.Forum:
        subject = subjectController.text;
        break;
      case ReplyType.EditStory:
        subject = subjectController.text;
        break;
      default:
        break;
    }
    String content = finalizeContent(context, contentController.text);

    final Completer<bool> completer = Completer<bool>();
    completer.future.then((success) {
      if (success) {
        dispatchAction(context)(UINavigationPop(context));
      } else {
        showToast(_scaffoldKey.currentState, '发帖失败',
            background: Colors.red, textColor: Colors.white);
      }
    });

    dispatchAction(context)(ReplyRequest(
      completer,
      subject: subject,
      content: content,
      replyType: widget.replyType,
      forum: widget.forum,
      story: widget.story,
      comment: widget.comment,
    ));
  }

  @override
  Widget build(BuildContext context) {
    String title;

    switch (widget.replyType) {
      case ReplyType.Forum:
        final forum = widget.forum;
        title = "发帖：${forum.name}";
        break;
      case ReplyType.Story:
        final story = widget.story;
        title = "回复：${story.subject}";
        break;
      case ReplyType.Comment:
        final comment = widget.comment;
        title = "回复：${comment.author}";
        break;
      case ReplyType.EditStory:
        final comment = widget.comment;
        final story = widget.story;
        subjectController.text = story.subject;
        contentController.text = stripSignature(comment.message);
        title = "编辑：${story.subject}";
        break;
      case ReplyType.EditComment:
        final comment = widget.comment;
        contentController.text = comment.message;
        title = "编辑：${comment.lou}楼";
        break;
    }

    final ValueKey _subjectKey = LKongAppKeys.composeSubjectKey;
    final ValueKey _contentKey = LKongAppKeys.comoposeContentKey;

    final email = (widget.replyType == ReplyType.Forum ||
            widget.replyType == ReplyType.EditStory)
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (!_formKey.currentState.validate()) {
                return;
              }
              sendMessage(context);
            },
          ),
        ],
      ),
      body: form,
    );
  }
}
