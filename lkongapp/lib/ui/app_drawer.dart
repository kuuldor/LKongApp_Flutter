import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/utils/utils.dart';

class AppDrawerBuilder extends StatelessWidget {
  AppDrawerBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppDrawerViewModel>(
      converter: AppDrawerViewModel.fromStore,
      builder: (context, viewModel) {
        return AppDrawer(viewModel: viewModel);
      },
    );
  }
}

class AppDrawerViewModel {
  AppDrawerViewModel();

  static AppDrawerViewModel fromStore(Store<AppState> store) {
    return AppDrawerViewModel();
  }
}

class AppDrawer extends StatelessWidget {
  final AppDrawerViewModel viewModel;

  AppDrawer({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    NavigatorState navigator = Navigator.of(context);

    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: DrawerHeader(
              child: Container(),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              navigator.pushReplacementNamed(LKongAppRoutes.home);
            },
          ),
          // STARTER: menu - do not remove comment
          AboutListTile(
            applicationName: '',
            icon: Icon(Icons.info_outline),
          ),
        ],
      ),
    );
  }
}
