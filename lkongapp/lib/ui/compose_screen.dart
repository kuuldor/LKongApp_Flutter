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
  final String username;
  final int uid;
  final ReplyType replyType;

  const ComposeScreen(
      {Key key,
      this.comment,
      this.story,
      this.forum,
      this.replyType,
      @required this.username,
      @required this.uid})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ComposeState();
  }
}

class ComposeState extends State<ComposeScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static final String signatureLink = "http://lkong.cn/thread/2214383";
  static final String signaturePattern =
      "<br>--<a target='_blank' href='.*?'.*?>.*?</a>";
  static final String editorPattern =
      r"<i class=.pstatus.>.*?</i><br\s*[/]?><br\s*[/]?>";
  static final String quotaPattern =
      "<blockquote class=.lkquote.>.*?</blockquote>";

  final subjectController = TextEditingController();
  final contentController = TextEditingController();

  bool sending = false;

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
      RegExp dotPattern = RegExp(r"'(\.\*\?)\'(\.\*\?)>(\.\*\?)");
      final signature = signaturePattern.replaceAllMapped(
          dotPattern, (Match m) => "'$signatureLink'>$signatureRaw");

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
    content =
        content.replaceFirstMapped(RegExp(signaturePattern), (Match m) => "");
    content =
        content.replaceFirstMapped(RegExp(editorPattern), (Match m) => "");
    content = content.replaceFirstMapped(
        RegExp(quotaPattern, multiLine: true), (Match m) => "");
    content = content.replaceAllMapped(RegExp(r"<br>"), (Match m) => "\n");
    return content;
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
        showToast('发帖失败');
      }
      setState(() {
        this.sending = false;
      });
    });

    final now = DateTime.now().toUtc().toIso8601String();

    dispatchAction(context)(ReplyRequest(
      completer,
      author: widget.username,
      authorId: widget.uid,
      dateline: now,
      subject: subject,
      content: content,
      replyType: widget.replyType,
      forum: widget.forum,
      story: widget.story,
      comment: widget.comment,
    ));

    setState(() {
      this.sending = true;
    });
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
        if (subjectController.text.length == 0) {
          subjectController.text = story.subject;
        }
        if (contentController.text.length == 0) {
          contentController.text = stripSignature(comment.message);
        }
        title = "编辑：${story.subject}";
        break;
      case ReplyType.EditComment:
        final comment = widget.comment;
        if (contentController.text.length == 0) {
          contentController.text = stripSignature(comment.message);
        }
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

    final screen = Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: (sending
                ? null
                : () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    sendMessage(context);
                  }),
          ),
        ],
      ),
      body: form,
    );

    if (!sending) {
      return screen;
    } else {
      return Stack(
        children: <Widget>[
          screen,
          Center(child: CircularProgressIndicator()),
        ],
      );
    }
  }
}
