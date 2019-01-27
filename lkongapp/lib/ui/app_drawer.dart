import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/actions/ui_action.dart';
import 'package:lkongapp/ui/connected_widget.dart';
import 'package:lkongapp/utils/globals.dart';
import 'package:quiver/core.dart';
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
  final bool loading;
  final Function(BuildContext, String) pushScreen;

  @override
  bool operator ==(other) {
    return other is AppDrawerViewModel &&
        user == other.user &&
        authState == other.authState &&
        info == other.info;
  }

  @override
  int get hashCode => hash3(info, user, authState);

  AppDrawerViewModel({
    @required this.authState,
    @required this.info,
    @required this.user,
    @required this.loading,
    @required this.pushScreen,
  });

  static AppDrawerViewModel fromStore(Store<AppState> store) {
    AuthState state = store.state.persistState.authState;
    var _user = selectUser(store);
    var _info = _user?.userInfo;

    return AppDrawerViewModel(
        authState: state,
        loading: store.state.isLoading,
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

    if (!viewModel.loading && user != null && info == null) {
      dispatchAction(context)(UserInfoRequest(null, user.uid));
    }

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
                  buildUserAvatar(context, isAuthed ? user?.uid : null, 64.0,
                      clickable: isAuthed),
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
          title: Text('设置'),
          onTap: () {
            viewModel.pushScreen(context, LKongAppRoutes.settings);
          },
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text('收藏'),
          onTap: () {
            viewModel.pushScreen(context, LKongAppRoutes.favorite);
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('退出登录'),
          onTap: () {
            dispatchAction(context)(LogoutRequest(null));
          },
        ),
      ]);
    } else {
      children.add(ListTile(
        leading: Icon(Icons.account_circle),
        title: Text('登录'),
        onTap: () {
          viewModel.pushScreen(context, LKongAppRoutes.login);
        },
      ));
    }

    children.add(
      ListTile(
        leading: Icon(Icons.group_add),
        title: Text('帐号管理'),
        onTap: () {
          viewModel.pushScreen(context, LKongAppRoutes.accountManage);
        },
      ),
    );
    children.add(AboutListTile(
      applicationName: '龍空',
      applicationVersion: appVersion,
      icon: Icon(Icons.info_outline),
    ));

    return Drawer(
      child: ListView(
        children: children,
      ),
    );
  }
}
