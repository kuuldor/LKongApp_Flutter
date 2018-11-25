import 'dart:collection';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:lkongapp/models/theme.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

//here goes the function

String html2Text(String htmlString) {
  var document = parse(htmlString);

  String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}

_handleURL(String url) async {
  print("URL is cliked: $url");
  if (url.startsWith("http")) {
    if (await canLaunch(url)) {
      await launch(url);
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

_parseImageAndText(BuildContext context,
    {@required dom.Node node,
    @required List<Widget> widgetList,
    @required TextStyle baseTextStyle,
    @required List<TextSpan> textList}) {
  LKongAppTheme theme = LKModeledApp.modelOf(context).theme;
  if (node is dom.Element) {
    dom.Element e = node;

    // print(e.toString());

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
      if (e.localName == "em" || e.localName == "i") {
        baseTextStyle = baseTextStyle.copyWith(fontStyle: FontStyle.italic);
      } else if (e.localName == "strong" || e.localName == "b") {
        baseTextStyle = baseTextStyle.copyWith(fontWeight: FontWeight.bold);
      } else if (e.localName == "blockquote") {
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
              baseTextStyle = baseTextStyle.apply(color: htmlColor(value));
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
        nodeTextList.add(TextSpan(style: baseTextStyle, text: "\n"));
      }

      //Handle elements to be converted to widget. Otherwise just append to widget/text list
      if (e.localName == "blockquote") {
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

        print("Anchor is ${e.outerHtml}");
        if (link != null) {
          if (nodeWidgets.length > 0) {
            print("Image in link");
            _cleanUpTextList(nodeWidgets, nodeTextList);
            var linkDetector = GestureDetector(
              // When the child is tapped, show a snackbar
              onTap: () => _handleURL(link),
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
              ..onTap = () => _handleURL(link);
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

_parseDocumentBody(
    BuildContext context, dom.Element body, List<Widget> widgetList) {
  List<TextSpan> textList = List<TextSpan>();
  dom.NodeList docBodyChildren = body.nodes;
  TextStyle defaultStyle =
      Theme.of(context).textTheme.title.apply(fontWeightDelta: -1);

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

  return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgetList));
}
