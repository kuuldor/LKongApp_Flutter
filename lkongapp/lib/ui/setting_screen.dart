import 'package:flutter/material.dart';
import 'package:lkongapp/ui/home_list.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/ui/forum_list.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/connected_widget.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget<SettingModel>(context, SettingModel.fromStore,
        (viewModel) {
      if (viewModel.user == null) {
        // viewModel.showLoginScreen(context);
      }
      return Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
          ),
          body: Container());
    });
  }
}

class SettingModel {
  final AppConfig config;
  final User user;
  final Function(BuildContext, int) onSettingChanged;
  final Function(BuildContext, bool) dismissScreen;

  @override
  bool operator ==(other) {
    return other is SettingModel &&
        other.config == config &&
        other.user == user;
  }

  @override
  int get hashCode => hash2(config, user);

  SettingModel({
    @required this.config,
    @required this.user,
    @required this.onSettingChanged,
    @required this.dismissScreen,
  });

  static SettingModel fromStore(Store<AppState> store) {
    var _user = selectUser(store);

    return SettingModel(
      config: store.state.persistState.appConfig,
      user: _user,
      onSettingChanged: (BuildContext context, int value) {},
      dismissScreen: (BuildContext context, bool saveChanges) {
        Future(() {
          if (saveChanges) {
            store.dispatch(Dehydrate());
          }
          store.dispatch(UINavigationPop(context));
        });
      },
    );
  }
}
