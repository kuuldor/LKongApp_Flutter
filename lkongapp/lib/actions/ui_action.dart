import 'package:flutter/material.dart';
import 'package:lkongapp/models/models.dart';

class UIChange {
  final Function(UIStateBuilder builder) change;

  UIChange(this.change);
}

class UIUpdateCurrentRoute {
  final String route;

  UIUpdateCurrentRoute(this.route);
}

class UINavigationPush {
  final BuildContext context;
  final String routeName;
  final bool unique;

  UINavigationPush(this.context, this.routeName, [this.unique = false]);
}

class UINavigationPopTo {
  final String routeName;
  final BuildContext context;
  UINavigationPopTo(this.context, this.routeName);
}

class UINavigationPop {
  final BuildContext context;
  UINavigationPop(this.context);
}
