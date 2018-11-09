import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/page_builder.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

Widget buildConnectedWidget<T extends ConnectedWidgetModel>(
    BuildContext context,
    T fromStore(Store<AppState> store),
    Widget buidler(T vm)) {
  return StoreConnector<AppState, T>(
    converter: fromStore,
    builder: (context, vm) {
      return WidgetView(
        viewModel: vm,
        builder: buidler,
      );
    },
  );
}

class ConnectedWidgetModel {
  static ConnectedWidgetModel fromStore(Store<AppState> store) {
    return ConnectedWidgetModel();
  }
}

typedef Widget BuilderType(ConnectedWidgetModel vm);

class WidgetView extends StatefulWidget {
  final ConnectedWidgetModel viewModel;
  final BuilderType builder;

  WidgetView({
    Key key,
    @required this.viewModel,
    @required this.builder,
  }) : super(key: key);

  @override
  _WidgetViewState createState() => new _WidgetViewState();
}

class _WidgetViewState extends State<WidgetView> {
  @override
  Widget build(BuildContext context) {
    var viewModel = widget.viewModel;

    return widget.builder(viewModel);
  }
}
