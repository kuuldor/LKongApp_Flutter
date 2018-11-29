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
  final bool isAuthed;
  final User user;
  final UserInfo info;
  final Function(BuildContext, String) pushScreen;

  AppDrawerViewModel({
    @required this.isAuthed,
    @required this.info,
    @required this.user,
    @required this.pushScreen,
  });

  static AppDrawerViewModel fromStore(Store<AppState> store) {
    var _user = selectUser(store);
    var _info = _user?.userInfo;
    if (_user != null && _info == null) {
      store.dispatch(UserInfoRequest(null, _user));
    }
    return AppDrawerViewModel(
        isAuthed: store.state.persistState.authState.isAuthed,
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
    bool isAuthed = viewModel.isAuthed;

    var children = <Widget>[
      Container(
        child: DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: isAuthed && user != null
                    ? CachedNetworkImageProvider(avatarForUserID(user.uid ?? 0),
                        imageOnError: "assets/noavatar.png")
                    : AssetImage("assets/noavatar.png"),
                radius: 36.0,
              ),
              Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 2.0),
                child: Text(isAuthed ? info?.username ?? "" : "请登录"),
              ),
              isAuthed && user != null
                  ? Container(
                      padding: const EdgeInsets.only(top: 2.0, bottom: 8.0),
                      child: Text(user.identity),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    ];

    if (isAuthed) {
      children.addAll(<Widget>[
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
          onTap: () {
            viewModel.pushScreen(context,
                isAuthed ? LKongAppRoutes.settings : LKongAppRoutes.login);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text("Logout"),
          onTap: () {
            StoreProvider.of<AppState>(context).dispatch(LogoutRequest(null));
          },
        ),
      ]);
    } else {
      children.add(ListTile(
        leading: Icon(Icons.account_circle),
        title: Text("Login"),
        onTap: () {
          viewModel.pushScreen(context,
              isAuthed ? LKongAppRoutes.settings : LKongAppRoutes.login);
        },
      ));
    }
    children.add(AboutListTile(
      applicationName: '',
      icon: Icon(Icons.info_outline),
    ));

    return Drawer(
      child: ListView(
        children: children,
      ),
    );
  }
}
