import 'package:flutter/material.dart';
import 'package:lkongapp/models/models.dart';

StatelessWidget verifyIcon(UserInfo user) {
  return user?.verify == true
      ? Icon(
          Icons.verified_user,
          size: 18.0,
          color: htmlColor("#ff8833"),
        )
      : Container(
          height: 0.0,
          width: 18.0,
        );
}
