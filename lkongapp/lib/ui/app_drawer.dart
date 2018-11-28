import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lkongapp/actions/ui_action.dart';
import 'package:lkongapp/ui/connected_widget.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/utils/utils.dart';

class AppDrawerBuilder extends StatelessWidget {
  AppDrawerBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget(
      context,
      AppDrawerViewModel.fromStore,
      (viewModel) {
        return AppDrawer(viewModel: viewModel);
      },
    );
  }
}

class AppDrawerViewModel {
  final UserInfo user;
  final Function(BuildContext, String) pushScreen;

  AppDrawerViewModel({
    @required this.user,
    @required this.pushScreen,
  });

  static AppDrawerViewModel fromStore(Store<AppState> store) {
    var _user = selectUserInfo(store);
    return AppDrawerViewModel(
        user: _user,
        pushScreen: (context, screen) {
          store.dispatch(UINavigationPush(context, screen));
        });
  }

  @override
  bool operator ==(other) {
    return other is AppDrawerViewModel && user == other.user;
  }

  @override
  int get hashCode => user.hashCode;
}

class AppDrawer extends StatelessWidget {
  final AppDrawerViewModel viewModel;

  AppDrawer({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserInfo user = viewModel.user;

    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: CachedNetworkImageProvider(
                        avatarForUserID(user?.uid??0),
                        imageOnError: "assets/noavatar.png"),
                    radius: 18.0,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(user != null ? user.username : "请登录"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(user != null ? Icons.home : Icons.account_circle),
            title: Text(user != null ? "Home" : "Login"),
            onTap: () {
              viewModel.pushScreen(context,
                  user != null ? LKongAppRoutes.home : LKongAppRoutes.login);
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
