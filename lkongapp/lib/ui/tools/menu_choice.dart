import 'package:flutter/material.dart';

enum MenuAction {
  follow,
  unfollow,
  chat,
  block,
  unblock,
  showAll,
  manageBlackList,
  uploadAvatar,
  digest,
  timeline,
}

class Choice {
  const Choice({this.title, this.icon, this.action});

  final String title;
  final IconData icon;
  final MenuAction action;
}
