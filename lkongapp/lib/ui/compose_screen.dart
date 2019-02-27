import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/ui/emoji_picker.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/tools/choose_image.dart';
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
  static final GlobalKey<FormState> _linkFormKey = GlobalKey<FormState>();

  static final String signatureLink = "http://lkong.cn/thread/2214383";
  static final String signaturePattern =
      "<br>--<a target='_blank' href='.*?'.*?>.*?</a>";
  static final String editorPattern =
      r"<i class=.pstatus.>.*?</i><br\s*[/]?><br\s*[/]?>";
  static final String quotaPattern =
      "<blockquote class=.lkquote.>[^]*?</blockquote>(<br>)?";

  final subjectController = TextEditingController();
  final contentController = TextEditingController();

  String initialContent;
  String initialSubject;

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    subjectController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    initialContent = widget.comment?.message;
    initialSubject = widget.story?.subject;
  }

  bool sending = false;
  int selectionStart;
  int selectionEnd;

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
              ?.signature ??
          "";
      RegExp dotPattern = RegExp(r"'(\.\*\?)\'(\.\*\?)>(\.\*\?)");
      final signature = signaturePattern.replaceAllMapped(
          dotPattern, (Match m) => "'$signatureLink'>$signatureRaw");

      content = "$content $signature";
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

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {
      if (error == null) {
        dispatchAction(context)(UINavigationPop(context));
      } else {
        showToast("发帖失败: $error");
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

  Future<String> _uploadImage(File image) async {
    // print("Image $image");
    if (image != null) {
      setState(() {
        this.sending = true;
      });
      return apiDispatch(UPLOAD_IMAGE_API, {"file": image.path}).then((result) {
        setState(() {
          this.sending = false;
        });
        final link = result["image"];
        final error = result["error"];
        if (link != null) {
          return link;
        }
        if (error != null) {
          showToast("传图失败: $error");
        }
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final config = stateOf(context).persistState.appConfig;
    final theme = LKModeledApp.modelOf(context).theme;
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
        final story = widget.story;
        if (subjectController.text.length == 0 && initialSubject != null) {
          subjectController.text = initialSubject;
          initialSubject = null;
        }
        if (contentController.text.length == 0 && initialContent != null) {
          contentController.text = stripSignature(initialContent);
          initialContent = null;
        }
        title = "编辑：${story.subject}";
        break;
      case ReplyType.EditComment:
        final comment = widget.comment;
        if (contentController.text.length == 0 && initialContent != null) {
          contentController.text = stripSignature(initialContent);
          initialContent = null;
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

    Widget bottomBar = BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: 12.0,
          ),
          IconButton(
            color: theme.barIconColor,
            icon: Icon(Icons.add_photo_alternate),
            onPressed: () {
              final cursor = contentController.selection;
              selectionStart = cursor.start;
              selectionEnd = cursor.end;
              chooseImage(
                context,
                _scaffoldKey,
                cropping: config.setting.noCropImage != true,
                onChosen: (file) {
                  _uploadImage(file).then((link) {
                    if (link != null) {
                      insertImage(link);
                    }
                  });
                },
              );
            },
          ),
          SizedBox(
            width: 12,
          ),
          IconButton(
            color: theme.barIconColor,
            icon: Icon(Icons.insert_emoticon),
            onPressed: () {
              final cursor = contentController.selection;
              selectionStart = cursor.start;
              selectionEnd = cursor.end;
              dispatchAction(context)(UINavigationPush(
                  context, LKongAppRoutes.emojiPicker, builder: (context) {
                return EmojiPicker(
                  onEmojiTapped: (context, emid) {
                    final link = "http://img.lkong.cn/bq/em$emid.gif";
                    insertImage(link);
                  },
                );
              }));
            },
          ),
          SizedBox(
            width: 12,
          ),
          IconButton(
            color: theme.barIconColor,
            icon: Icon(Icons.link),
            onPressed: () {
              final cursor = contentController.selection;
              selectionStart = cursor.start;
              selectionEnd = cursor.end;
              onAddLinkTap(context);
            },
          ),
          Expanded(
              child: Container(
            height: 0.0,
          )),
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
        body: Column(
          children: <Widget>[
            Expanded(
              child: form,
            ),
            bottomBar,
          ],
        ));

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

  void insertImage(String link) {
    // final image = "[img]$link[/img]";
    final image = '<img src="$link" />';
    insertText(image);
  }

  void insertLink(String title, String link) {
    if (title == null || title.trim().length == 0) {
      title = link;
    }
    final achor = '<a href="$link"> $title </a>';
    insertText(achor);
  }

  void insertText(String inserted) {
    String text = contentController.text;
    if (text == null || text.length == 0) {
      contentController.text = inserted;
      selectionStart = inserted.length;
      selectionEnd = selectionStart;
    } else {
      if (selectionStart == null || selectionEnd == null) {
        final cursor = contentController.selection;
        selectionStart = cursor.start;
        selectionEnd = cursor.end;
      }

      if (selectionStart >= 0 && selectionEnd >= 0) {
        contentController.text =
            text.replaceRange(selectionStart, selectionEnd, inserted);
        selectionStart += inserted.length;
        selectionEnd = selectionStart;
      } else {
        contentController.text += inserted;
        selectionStart = contentController.text.length;
        selectionEnd = selectionStart;
      }
    }
    contentController.selection =
        TextSelection.fromPosition(TextPosition(offset: selectionStart));
  }

  void onAddLinkTap(BuildContext context) {
    final titleController = TextEditingController();
    final linkController = TextEditingController();

    final ValueKey _titleKey = Key('__addurl__title__');
    final ValueKey _linkKey = Key('__addurl__link__');

    final titleFld = TextFormField(
      key: _titleKey,
      controller: titleController,
      autofocus: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: '链接标题',
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
    );

    final linkFld = TextFormField(
      key: _linkKey,
      controller: linkController,
      autocorrect: false,
      keyboardType: TextInputType.url,
      autofocus: false,
      validator: (val) =>
          val.isEmpty || val.trim().length == 0 ? '请输入链接' : null,
      decoration: InputDecoration(
        hintText: '链接地址',
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
    );

    final form = Form(
      key: _linkFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('标题'),
            SizedBox(height: 4.0),
            titleFld,
            SizedBox(height: 8.0),
            Text('链接'),
            SizedBox(height: 4.0),
            linkFld,
            SizedBox(height: 18.0),
          ],
        ),
      ),
    );

    showDialog<void>(
      context: _scaffoldKey.currentContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('添加链接'),
          content: form,
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('确定'),
              onPressed: () {
                if (!_linkFormKey.currentState.validate()) {
                  return;
                }
                final title = titleController.text;
                final link = linkController.text.trim();
                insertLink(title, link);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
