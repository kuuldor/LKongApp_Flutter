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
  normal,
  digest,
  timeline,
  hot,
  favorite,
  unfavorite,
  atMe,
  notice,
  ratelog,
  pm,
}

class Choice {
  const Choice({this.title, this.icon, this.action, this.enabled: true});

  final String title;
  final IconData icon;
  final MenuAction action;
  final bool enabled;

  static Choice disable(Choice choice) {
    return Choice(
        title: choice.title,
        icon: choice.icon,
        action: choice.action,
        enabled: false);
  }
}
