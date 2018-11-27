import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:lkongapp/models/models.dart';


Widget buildConnectedWidget<T>(
    BuildContext context,
    T fromStore(Store<AppState> store),
    Widget buidler(T vm)) {
  return StoreConnector<AppState, T>(
    converter: fromStore,
    distinct: true,
    builder: (context, vm) {
      return WidgetView(
        viewModel: vm,
        builder: buidler,
      );
    },
  );
}

typedef Widget BuilderType<T>(T vm);

class WidgetView<T> extends StatefulWidget {
  final T viewModel;
  final BuilderType<T> builder;

  WidgetView({
    Key key,
    @required this.viewModel,
    @required this.builder,
  }) : super(key: key);

  @override
  _WidgetViewState<T> createState() => new _WidgetViewState<T>();
}

class _WidgetViewState<T> extends State<WidgetView<T>> {
  @override
  Widget build(BuildContext context) {
    T viewModel = widget.viewModel;

    return widget.builder(viewModel);
  }
}
