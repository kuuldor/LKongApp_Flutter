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

  static Choice copy(Choice choice) {
    return Choice(
        title: choice.title,
        icon: choice.icon,
        action: choice.action,
        enabled: choice.enabled);
  }

  static Choice disable(Choice choice) {
    return Choice(
        title: choice.title,
        icon: choice.icon,
        action: choice.action,
        enabled: false);
  }

  static Choice newTitle(Choice choice, String title) {
    return Choice(
        title: title,
        icon: choice.icon,
        action: choice.action,
        enabled: choice.enabled);
  }
}

popupMenu(BuildContext context, List<Choice> menus,
        Function(BuildContext, Choice) action) =>
    PopupMenuButton<Choice>(
      onSelected: (choice) => action(context, choice),
      itemBuilder: (BuildContext context) {
        return menus.map((Choice menuItem) {
          return PopupMenuItem<Choice>(
            value: menuItem,
            enabled: menuItem.enabled,
            child: Text(menuItem.title),
          );
        }).toList();
      },
    );
