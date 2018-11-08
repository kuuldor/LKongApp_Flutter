import 'package:html/parser.dart';
//here goes the function

String html2Text(String htmlString) {
  var document = parse(htmlString);

  String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}
