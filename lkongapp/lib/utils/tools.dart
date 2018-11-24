import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/utils.dart';
//here goes the function

String html2Text(String htmlString) {
  var document = parse(htmlString);

  String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}

_cleanUpTextList(List<Widget> widgetList, List<TextSpan> textList) {
  if (textList.length > 0) {
    List<TextSpan> texts = List<TextSpan>();
    texts.addAll(textList);
    TextSpan text = TextSpan(children: texts);
    widgetList.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: RichText(
            text: text,
          ),
        )
      ],
    ));
    textList.clear();
  }
}

_parseImageAndText(BuildContext context,
    {@required dom.Node node,
    @required List<Widget> widgetList,
    @required TextStyle baseTextStyle,
    @required List<TextSpan> textList}) {
  if (node is dom.Element) {
    dom.Element e = node;

    if (e.localName == "img" && e.attributes.containsKey('src')) {
      _cleanUpTextList(widgetList, textList);

      var src = e.attributes['src'];

      if (src.startsWith("http") || src.startsWith("https")) {
        widgetList.add(CachedNetworkImage(
          imageUrl: src,
          fit: BoxFit.cover,
        ));
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
      //TODO: handle text style elements first, like i strong font etc.

      List<Widget> nodeWidgets = List<Widget>();
      List<TextSpan> nodeTextList = List<TextSpan>();
      if (e.nodes.length > 0) {
        e.nodes.forEach((e) => _parseImageAndText(context,
            node: e,
            widgetList: nodeWidgets,
            baseTextStyle: baseTextStyle,
            textList: nodeTextList));
      }
      if (e.localName == "blockquote") {
        _cleanUpTextList(nodeWidgets, nodeTextList);
        LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
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
    textList.add(TextSpan(style: baseTextStyle, text: node.text));
  }
}

_parseDocumentBody(
    BuildContext context, dom.Element body, List<Widget> widgetList) {
  List<TextSpan> textList = List<TextSpan>();
  dom.NodeList docBodyChildren = body.nodes;
  TextStyle defaultStyle = Theme.of(context).textTheme.body1;

  if (docBodyChildren.length > 0)
    docBodyChildren.forEach((e) => _parseImageAndText(context,
        node: e,
        widgetList: widgetList,
        baseTextStyle: defaultStyle,
        textList: textList));

  _cleanUpTextList(widgetList, textList);
}

Widget comment2Widget(BuildContext context, String comment, {ThemeData style}) {
  List<Widget> widgetList = List<Widget>();

  dom.Document document = parse(comment);
  dom.Element body = document.body;

  _parseDocumentBody(context, body, widgetList);

  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgetList);
}
