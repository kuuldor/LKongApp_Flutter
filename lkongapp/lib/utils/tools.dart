import 'dart:collection';
import 'dart:convert';
import 'package:html_unescape/html_unescape.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:photo_view/photo_view.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/models/theme.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lkongapp/data/theme.dart' as themeData;
import 'package:lkongapp/ui/tools/item_handler.dart';
//here goes the function

dispatchAction(BuildContext context) =>
    (action) => StoreProvider.of<AppState>(context).dispatch(action);

AppState stateOf(BuildContext context) =>
    StoreProvider.of<AppState>(context).state;

Widget buildUserAvatar(BuildContext context, int uid, double size,
    {bool clickable: false}) {
  final avatar = CircleAvatar(
    backgroundColor: Colors.transparent,
    backgroundImage: uid != null && uid > 0
        ? CachedNetworkImageProvider(avatarForUserID(uid),
            imageOnError: "assets/noavatar.png")
        : AssetImage("assets/noavatar.png"),
    radius: size / 2,
  );

  return clickable
      ? GestureDetector(
          child: avatar,
          onTap: () {
            onUserTap(context, UserInfo().rebuild((b) => b..uid = uid));
          },
        )
      : avatar;
}

String html2Text(String htmlString) {
  var document = parse(htmlString);

  String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}

String stripHtmlTag(String string) {
  RegExp tagPattern = RegExp(r'<[!/a-z].*?>');
  RegExp spacePattern = RegExp(r'\s+', multiLine: true);

  string = string.replaceAll(tagPattern, "");
  string = string.replaceAll(spacePattern, " ");
  string = HtmlUnescape().convert(string);

  return string.trim();
}

_handleURL(BuildContext context, String url) async {
  print("URL is cliked: $url");
  if (url.startsWith("http")) {
    if (await canLaunch(url)) {
      await launch(url);
    }
  } else if (url.startsWith("lkong://")) {
    final typeID = url.substring(8); // strip lkong://
    final flds = parseTypeAndId(typeID);
    switch (flds[0]) {
      case "thread":
        int tid;
        try {
          tid = int.parse(flds[1]);
        } catch (_) {}
        if (tid != null) {
          openThreadView(context, tid);
        }
        break;
      case "name":
        openUserView(context, flds[1]);
        break;
      case "post":
        int pid;
        try {
          pid = int.parse(flds[1]);
        } catch (_) {}
        if (pid != null) {
          openThreadView(context, null, pid);
        }
        break;
      default:
        break;
    }
  }
}

_textList2Widget(List<TextSpan> textList) {
  List<TextSpan> texts = List<TextSpan>();
  texts.addAll(textList);
  TextSpan text = texts.length == 1 ? texts[0] : TextSpan(children: texts);

  var widget = Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: RichText(
          softWrap: true,
          text: text,
        ),
      )
    ],
  );
  return widget;
}

_cleanUpTextList(List<Widget> widgetList, List<TextSpan> textList) {
  if (textList.length > 0) {
    widgetList.add(_textList2Widget(textList));
    textList.clear();
  }
}

_parseImageAndText(
  BuildContext context, {
  @required dom.Node node,
  @required List<Widget> widgetList,
  @required TextStyle baseTextStyle,
  @required List<TextSpan> textList,
}) {
  LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
  if (node is dom.Element) {
    dom.Element e = node;

    // print(e.toString());

    if (e.localName == "img" && e.attributes.containsKey('src')) {
      _cleanUpTextList(widgetList, textList);

      var src = e.attributes['src'];

      if (src.startsWith("http") || src.startsWith("https")) {
        Widget image = CachedNetworkImage(
          imageUrl: src,
          imageOnError: "assets/image_placeholder.png",
          fit: BoxFit.cover,
        );

        if (!isLKongEmoji(src)) {
          final imageProvider = CachedNetworkImageProvider(src,
              imageOnError: "assets/image_placeholder.png");
          image = GestureDetector(
            child: image,
            onLongPress: () {
              dispatchAction(context)(UINavigationPush(
                  context, LKongAppRoutes.photoView, false, (context) {
                return Container(
                  child: PhotoView(
                    imageProvider: imageProvider,
                    minScale: PhotoViewComputedScale.contained * 0.5,
                    maxScale: 2.5,
                  ),
                );
              }));
            },
          );
        }
        widgetList.add(image);
      } else if (src.startsWith('data:image')) {
        var exp = RegExp(r'data:.*;base64,');
        var base64Str = src.replaceAll(exp, '');
        var bytes = base64.decode(base64Str);
        widgetList.add(Image.memory(bytes, fit: BoxFit.cover));
      } else {
        print("Image src : $src");
        widgetList.add(Image.asset("assets/image_placeholder.png"));
      }
    } else if (e.localName == "video") {
      _cleanUpTextList(widgetList, textList);
      //TODO: handle video nodes

    } else {
      String cls = e.attributes["class"];
      baseTextStyle = applyCSSForClass(cls, theme, baseTextStyle);
      if (e.localName == "em" || e.localName == "i") {
        baseTextStyle = baseTextStyle.copyWith(fontStyle: FontStyle.italic);
      } else if (e.localName == "strong" || e.localName == "b") {
        baseTextStyle = baseTextStyle.copyWith(fontWeight: FontWeight.bold);
      } else if (e.localName == "blockquote" || cls == "lkong_quobes") {
        baseTextStyle =
            baseTextStyle.apply(fontSizeFactor: 0.85, color: Colors.blueGrey);
      } else if (e.localName == "font") {
        e.attributes.forEach((name, value) {
          switch (name.toString().toLowerCase()) {
            case "size":
              baseTextStyle = baseTextStyle.apply(
                  fontSizeFactor: double.parse(value) / 3.0);
              break;
            case "color":
              baseTextStyle = baseTextStyle.apply(
                  color: htmlColor(value, nightRev: theme.isNightMode));
              break;
          }
        });
      } else if (e.localName == "a") {
        baseTextStyle = baseTextStyle.apply(color: theme.linkColor);
      }

      List<Widget> nodeWidgets = List<Widget>();
      List<TextSpan> nodeTextList = List<TextSpan>();
      if (e.nodes.length > 0) {
        e.nodes.forEach((e) => _parseImageAndText(context,
            node: e,
            widgetList: nodeWidgets,
            baseTextStyle: baseTextStyle,
            textList: nodeTextList));
      }

      if (e.localName == "br") {
        nodeTextList.add(TextSpan(style: baseTextStyle, text: "\n"));
      } else if (e.localName == "p") {
        nodeTextList.insert(0, TextSpan(style: baseTextStyle, text: "\n"));
        // nodeTextList.add(TextSpan(style: baseTextStyle, text: "\n"));
      } else if (e.localName == "div" && cls != "lkong_quobes") {
        if (e.nodes.length == 1) {
          final child = e.nodes.elementAt(0);
          if (!(child is dom.Element) ||
              (child as dom.Element).localName != "div") {
            nodeTextList.insert(0, TextSpan(style: baseTextStyle, text: "\n"));
            // nodeTextList.add(TextSpan(style: baseTextStyle, text: "\n"));
          }
        }
      }

      //Handle elements to be converted to widget. Otherwise just append to widget/text list
      if (e.localName == "blockquote" || cls == "lkong_quobes") {
        _cleanUpTextList(nodeWidgets, nodeTextList);
        widgetList.add(
          Card(
            color: theme.quoteBG,
            shape: Border(left: BorderSide(width: 2.0, color: Colors.orange)),
            elevation: 0.0,
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: nodeWidgets,
                  ),
                ),
              ]),
            ),
          ),
        );
      } else if (e.localName == "a") {
        String dataItem = e.attributes["dataitem"];

        String link =
            dataItem == null ? e.attributes["href"] : "lkong://$dataItem";

        if (link != null) {
          if (nodeWidgets.length > 0) {
            print("Image in link");
            _cleanUpTextList(nodeWidgets, nodeTextList);
            var linkDetector = GestureDetector(
              // When the child is tapped, show a snackbar
              onTap: () => _handleURL(context, link),
              // Our Custom Button!
              child: Column(
                children: nodeWidgets,
              ),
            );
            widgetList.add(linkDetector);
          } else if (nodeTextList.length > 0) {
            // TextSpan's recognizer only works on direct text but not children.
            // var linkText = TextSpan(
            //   style: baseTextStyle,
            //   children: nodeTextList,
            //   recognizer: TapGestureRecognizer()..onTap = () => _handleURL(link),
            // );
            // textList.add(linkText);
            TapGestureRecognizer tapper = TapGestureRecognizer()
              ..onTap = () => _handleURL(context, link);
            List<TextSpan> linkTexts = List<TextSpan>();
            nodeTextList.forEach((text) {
              linkTexts.add(TextSpan(
                  recognizer: tapper, style: text.style, text: text.text));
            });
            textList.addAll(linkTexts);
          }
        }
      } else {
        if (nodeWidgets.length > 0) {
          _cleanUpTextList(widgetList, textList);
          widgetList.addAll(nodeWidgets);
          _cleanUpTextList(widgetList, nodeTextList);
        } else {
          textList.addAll(nodeTextList);
        }
      }
    }
  } else if (node is dom.Text) {
    String text =
        node.text.trim().replaceAll(RegExp(r"(\s+)", multiLine: true), " ");
    textList.add(TextSpan(style: baseTextStyle, text: text));
  }
}

TextStyle applyCSSForClass(
    String className, LKongAppTheme theme, TextStyle baseTextStyle) {
  if (className != null) {
    // print("Class $className");
    var style = themeData.cssStyle[".$className"];
    if (style != null) {
      String fcolorName = style["color"] as String;
      if (fcolorName != null) {
        String fcolor = theme.appTheme.colors[fcolorName];
        if (fcolor == null) {
          fcolor = fcolorName;
        }
        Color color = htmlColor(fcolor);
        baseTextStyle = baseTextStyle.apply(color: color);
      }

      double fsize = style["font-size"];
      if (fsize != null) {
        baseTextStyle = baseTextStyle.apply(fontSizeFactor: fsize);
      }
    }
  }
  return baseTextStyle;
}

_parseDocumentBody(
    BuildContext context, dom.Element body, List<Widget> widgetList) {
  List<TextSpan> textList = List<TextSpan>();
  dom.NodeList docBodyChildren = body.nodes;

  final theme = LKModeledApp.modelOf(context).theme;
  TextStyle defaultStyle = Theme.of(context)
      .textTheme
      .title
      .apply(fontWeightDelta: -1, color: theme.darkTextColor);

  if (docBodyChildren.length > 0)
    docBodyChildren.forEach((e) => _parseImageAndText(
          context,
          node: e,
          widgetList: widgetList,
          baseTextStyle: defaultStyle,
          textList: textList,
        ));

  _cleanUpTextList(widgetList, textList);
}

Widget comment2Widget(BuildContext context, String comment, {ThemeData style}) {
  List<Widget> widgetList = List<Widget>();

  dom.Document document = parse(comment);
  dom.Element body = document.body;

  _parseDocumentBody(context, body, widgetList);

  return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgetList));
}
