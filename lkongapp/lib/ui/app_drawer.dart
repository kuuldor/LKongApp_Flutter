import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lkongapp/actions/actions.dart';
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
  final User user;
  final UserInfo info;
  final Function(BuildContext, String) pushScreen;

  AppDrawerViewModel({
    @required this.info,
    @required this.user,
    @required this.pushScreen,
  });

  static AppDrawerViewModel fromStore(Store<AppState> store) {
    var _user = selectUser(store);
    var _info = selectUserInfo(store);
    if (_user != null && _info == null) {
      store.dispatch(UserInfoRequest(null, _user));
    }
    return AppDrawerViewModel(
        user: _user,
        info: _info,
        pushScreen: (context, screen) {
          store.dispatch(UINavigationPush(context, screen));
        });
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
    User user = viewModel.user;
    UserInfo info = viewModel.info;
    
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: CachedNetworkImageProvider(
                        avatarForUserID(user?.uid ?? 0),
                        imageOnError: "assets/noavatar.png"),
                    radius: 36.0,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 2.0),
                    child: Text(user != null ? info?.username??"" : "请登录"),
                  ),
                  user != null
                      ? Container(
                          padding: const EdgeInsets.only(top: 2.0, bottom: 8.0),
                          child: Text(user.identity),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(user != null ? Icons.settings : Icons.account_circle),
            title: Text(user != null ? "Settings" : "Login"),
            onTap: () {
              viewModel.pushScreen(context,
                  user != null ? LKongAppRoutes.settings : LKongAppRoutes.login);
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
