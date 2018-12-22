import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class IconMessage extends StatelessWidget {
  final String message;
  final IconData icon;

  IconMessage({
    this.message,
    this.icon = Icons.check_circle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(this.icon),
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(this.message),
        )
      ],
    );
  }
}

showToast(String msg,
    {Color background: Colors.red, Color textColor: Colors.white}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: background,
      textColor: textColor);
}
