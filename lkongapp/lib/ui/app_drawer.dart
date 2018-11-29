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
  final AuthState authState;
  final User user;
  final UserInfo info;
  final Function(BuildContext, String) pushScreen;

  AppDrawerViewModel({
    @required this.authState,
    @required this.info,
    @required this.user,
    @required this.pushScreen,
  });

  static AppDrawerViewModel fromStore(Store<AppState> store) {
    AuthState state = store.state.persistState.authState;
    var _user = selectUser(store);
    var _info = _user?.userInfo;
    if (_user != null && _info == null) {
      store.dispatch(UserInfoRequest(null, _user));
    }
    return AppDrawerViewModel(
        authState: state,
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
    bool isAuthed = viewModel.authState.isAuthed;

    var nameLine = <Widget>[Text(user?.identity ?? "")];

    if (viewModel.authState.userRepo.length > 0) {
      final allUsers = viewModel.authState.userRepo.asMap().values;
      final dropMenu = DropdownButtonHideUnderline(
          child: DropdownButton<User>(
        value: user,
        hint: Text("请登录"),
        items: allUsers.map((User _aUser) {
          final uname = _aUser.userInfo?.username ?? _aUser.identity;
          return DropdownMenuItem<User>(
            value: _aUser,
            child: Text(uname),
          );
        }).toList(),
        onChanged: (_aUser) {
          dispatchAction(context)(LoginRequest(null, _aUser));
        },
      ));

      nameLine.add(dropMenu);
    } else {
      nameLine.add(Text("请登录"));
    }

    var children = <Widget>[
      Container(
        child: DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  userAvatar(isAuthed ? user?.uid : null, 64.0),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 8.0, left: 4.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: nameLine),
              ),
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
            dispatchAction(context)(LogoutRequest(null));
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
