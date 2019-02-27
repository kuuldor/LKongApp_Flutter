import 'dart:collection';
import 'dart:convert';
import 'package:html_unescape/html_unescape.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:connectivity/connectivity.dart';
import 'package:lkongapp/utils/globals.dart' as globals;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:lkongapp/utils/async_avatar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/models/theme.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:lkongapp/data/theme.dart' as themeData;
import 'package:lkongapp/ui/tools/item_handler.dart';
//here goes the function

dispatchAction(BuildContext context) =>
    (action) => StoreProvider.of<AppState>(context).dispatch(action);

AppState stateOf(BuildContext context) =>
    StoreProvider.of<AppState>(context).state;

Widget asyncUserAvatar(
  BuildContext context,
  AvatarLoaderState loader,
  int uid,
  double size, {
  bool clickable: false,
  int delayInMillies,
}) {
  bool loadAvatar = shouldLoadAvatar(context);

  final avatar = CircleAvatar(
    backgroundColor: Colors.transparent,
    backgroundImage: loadAvatar && uid != null && uid > 0
        ? AsyncAvatarProvider(loader, avatarForUserID(uid),
            delayInMillies: delayInMillies)
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

bool shouldLoadAvatar(BuildContext context) {
  final setting = stateOf(context).persistState.appConfig.setting;
  bool loadAvatar = true;
  if (!setting.loadAvatar) {
    loadAvatar = shouldLoadImage(context);
  }
  return loadAvatar;
}

bool shouldLoadImage(context) {
  final setting = stateOf(context).persistState.appConfig.setting;
  bool loadImage = true;
  if (setting.noImageMode == 1) {
    loadImage = false;
  } else if (setting.noImageMode == 2 &&
      globals.connectivity == ConnectivityResult.mobile) {
    loadImage = false;
  }
  return loadImage;
}

Widget buildUserAvatar(BuildContext context, int uid, double size,
    {bool clickable: false}) {
  return asyncUserAvatar(context, null, uid, size,
      clickable: clickable, delayInMillies: 0);
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

final needNewLineTest = (dom.Element e) => (e.localName == "p" ||
    e.localName == "h1" ||
    e.localName == "h2" ||
    e.localName == "h3" ||
    e.localName == "h4" ||
    e.localName == "h5");

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
        Widget image;

        final Match m = isLKongEmoji(src);
        if (m == null) {
          final imageProvider = CachedNetworkImageProvider(src,
              imageOnError: "assets/image_placeholder.png");
          image = GestureDetector(
            child: shouldLoadImage(context)
                ? Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  )
                : Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Image.asset("assets/image_placeholder.png"),
                      Text('长按查看图片', style: TextStyle(color: Colors.black)),
                    ],
                  ),
            onLongPress: () {
              dispatchAction(context)(UINavigationPush(
                  context, LKongAppRoutes.photoView, builder: (context) {
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
        } else {
          image = Image.asset("assets/bq/${m[1]}");
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

      String style = e.attributes["style"];
      baseTextStyle = applyCSSForStyle(style, baseTextStyle, theme.isNightMode);

      if (e.localName == "em" || e.localName == "i") {
        baseTextStyle = baseTextStyle.copyWith(fontStyle: FontStyle.italic);
      } else if (e.localName == "strong" || e.localName == "b") {
        baseTextStyle = baseTextStyle.copyWith(fontWeight: FontWeight.bold);
      } else if (e.localName == "blockquote" || cls == "lkong_quobes") {
        baseTextStyle = theme.subheadStyle.apply(color: Colors.blueGrey);
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
      } else if (e.localName == "h1") {
        baseTextStyle = theme.headerStyle
            .apply(fontSizeFactor: 1.5)
            .copyWith(fontWeight: FontWeight.bold);
      } else if (e.localName == "h2") {
        baseTextStyle = theme.headerStyle
            .apply(fontSizeFactor: 1.2)
            .copyWith(fontWeight: FontWeight.bold);
      } else if (e.localName == "h3") {
        baseTextStyle = theme.headerStyle
            .apply(fontSizeFactor: 1.0)
            .copyWith(fontWeight: FontWeight.bold);
      } else if (e.localName == "h4") {
        baseTextStyle = theme.headerStyle
            .apply(fontSizeFactor: 0.9)
            .copyWith(fontWeight: FontWeight.bold);
      } else if (e.localName == "h5") {
        baseTextStyle = theme.headerStyle
            .apply(fontSizeFactor: 0.8)
            .copyWith(fontWeight: FontWeight.bold);
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
      } else if (needNewLineTest(e)) {
        nodeTextList.insert(0, TextSpan(style: baseTextStyle, text: "\n"));
        nodeTextList.add(TextSpan(style: baseTextStyle, text: "\n"));
      } else if (e.localName == "div" && cls != "lkong_quobes") {
        if (e.nodes.length == 1) {
          final child = e.nodes.elementAt(0);
          bool needNewline = false;
          if (child is dom.Element) {
            if (child.localName != "div" && !needNewLineTest(child)) {
              needNewline = true;
            }
          } else {
            needNewline = true;
          }
          if (needNewline) {
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

        String link = (dataItem == null || dataItem == "href")
            ? e.attributes["href"]
            : "lkong://$dataItem";

        if (link != null) {
          if (nodeWidgets.length > 0) {
            print("Image in link");
            _cleanUpTextList(nodeWidgets, nodeTextList);
            var linkDetector = GestureDetector(
              // When the child is tapped, show a snackbar
              onTap: () => handleURL(context, link),
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
              ..onTap = () => handleURL(context, link);
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
    if (text.length > 0) {
      textList.add(TextSpan(style: baseTextStyle, text: text));
    }
  }
}

TextStyle applyCSSForStyle(
    String style, TextStyle baseTextStyle, bool isNightMode) {
  if (style != null) {
    RegExp colorPattern = RegExp(r'color:\s*(.*?)\s*;', caseSensitive: false);
    if (colorPattern.hasMatch(style)) {
      String fcolor = colorPattern.firstMatch(style).group(1);

      Color color = htmlColor(fcolor, nightRev: isNightMode);
      baseTextStyle = baseTextStyle.apply(color: color);
    }
  }

  return baseTextStyle;
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
  TextStyle defaultStyle = theme.textStyle;

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

String detectLinkAndConvert(String html) {
  String retv = html;
  final achorPattern = RegExp(
      r'((src|href)=)(["' +
          "'" +
          r']?)(http)(s?:\/\/[^/$.?#]*\.[a-zA-Z0-9.:;!%\/&=?_-]*)',
      caseSensitive: false);
  final linkPattern = RegExp(
      r'(https?:\/\/[^/$.?#]*\.[a-zA-Z0-9.:;!%\/&=?_-]*)',
      caseSensitive: false);
  if (linkPattern.hasMatch(html)) {
    var hideMapper = (Match m) => '${m[1]}${m[3]}h_x_t_x_t_x_p${m[5]}';

    var mapper = (Match m) => '<a href="${m[1]}">${m[1]}</a>';

    retv = retv.replaceAllMapped(achorPattern, hideMapper);
    retv = retv.replaceAllMapped(linkPattern, mapper);
    retv = retv.replaceAll("h_x_t_x_t_x_p", "http");
  }

  return retv;
}

Widget comment2Widget(BuildContext context, String comment,
    {bool detectLink: false}) {
  List<Widget> widgetList = List<Widget>();

  if (detectLink == true) {
    comment = detectLinkAndConvert(comment);
  }

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
