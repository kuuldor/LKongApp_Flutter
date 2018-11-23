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

_parseChildren(BuildContext context, dom.Node node, List<Widget> widgetList) {
  print("NodeType: ${node.nodeType}");
  print("Node: ${node.toString()}");
  if (node is dom.Element) {
    dom.Element e = node;
    print(e.localName);

    List<Widget> nodeWidgets = List<Widget>();
    if (e.nodes.length > 0) {
      e.nodes.forEach((e) => _parseChildren(context, e, nodeWidgets));
    }

    if (e.localName == "img" && e.attributes.containsKey('src')) {
      var src = e.attributes['src'];

      if (src.startsWith("http") || src.startsWith("https")) {
        widgetList.add(new CachedNetworkImage(
          imageUrl: src,
          fit: BoxFit.cover,
        ));
      } else if (src.startsWith('data:image')) {
        var exp = new RegExp(r'data:.*;base64,');
        var base64Str = src.replaceAll(exp, '');
        var bytes = base64.decode(base64Str);
        widgetList.add(new Image.memory(bytes, fit: BoxFit.cover));
      } else {
        print("Image src : $src");
        widgetList.add(Image.asset("assets/image_placeholder.png"));
      }
    } else if (e.localName == "blockquote") {
      LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
      widgetList.add(Card(
          color: theme.quoteBG,
          elevation: 0.0,
          child: Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: nodeWidgets,
              ))));
    } else {
      widgetList.addAll(nodeWidgets);
    }
  } else if (node is dom.Text) {
    print("Text: ${node.text}");
    widgetList.add(Row(
      children: <Widget>[
        Expanded(
          child: Text(
            node.text,
            softWrap: true,
          ),
        )
      ],
    ));
  }
}

Widget comment2Widget(BuildContext context, String comment, {ThemeData style}) {
  List<Widget> widgetList = List<Widget>();
  dom.Document document = parse(comment);
  dom.Element body = document.body;

  dom.NodeList docBodyChildren = body.nodes;
  if (docBodyChildren.length > 0)
    docBodyChildren.forEach((e) => _parseChildren(context, e, widgetList));

  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgetList);
}
