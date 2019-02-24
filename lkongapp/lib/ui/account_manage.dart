import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/fetched_list.dart';
import 'package:lkongapp/ui/forum_story.dart';
import 'package:lkongapp/ui/grouped_list.dart';
import 'package:lkongapp/ui/items/forum_item.dart';
import 'package:lkongapp/ui/items/item_wrapper.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/screens.dart';
import 'package:lkongapp/ui/tools/drawer_button.dart';
import 'package:lkongapp/ui/tools/icon_message.dart';
import 'package:lkongapp/ui/tools/item_handler.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

import 'package:lkongapp/ui/connected_widget.dart';

class AccountManageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget(context, AccountManageModel.fromStore,
        (viewModel) {
      return viewModel.buildListView(context);
    });
  }
}

class AccountManageModel extends DataTableSource with GroupedListModel {
  final List<User> allUsers;
  final bool loading;
  final String lastError;
  final User currentUser;

  Set<User> selectedUsers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  SliverAppBar buildAppBar(BuildContext context) {
    var actions = <Widget>[];
    actions.add(IconButton(
      icon: Icon(Icons.person_add),
      onPressed: () {
        onAddUserTap(context);
      },
    ));

    actions.add(IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        if (selectedUsers.contains(currentUser)) {
          dispatchAction(context)(LogoutRequest(null));
        }
        dispatchAction(context)(DeleteUsers(selectedUsers));
      },
    ));

    return SliverAppBar(
      title: GestureDetector(
        child: Text("帐号管理",
            style:
                Theme.of(context).textTheme.title.apply(color: Colors.white)),
        onTap: () => scrollToTop(context),
      ),
      actions: actions,
      floating: false,
      pinned: true,
    );
  }

  @override
  bool operator ==(other) {
    return other is AccountManageModel && allUsers == other.allUsers;
  }

  @override
  int get hashCode => hashObjects([allUsers]);

  AccountManageModel({
    @required this.allUsers,
    @required this.currentUser,
    @required this.loading,
    @required this.lastError,
  }) {
    selectedUsers = Set<User>();
  }

  static AccountManageModel fromStore(Store<AppState> store) {
    return AccountManageModel(
      allUsers: store.state.persistState.authState.userRepo.values.toList(),
      currentUser: selectUser(store),
      loading: store.state.isLoading,
      lastError: store.state.persistState.authState.error,
    );
  }

  @override
  int get numberOfSections => 1;

  @override
  int countOfItemsInSection({int section}) {
    int count = allUsers?.length ?? 0;
    return count;
  }

  @override
  Widget headerForSection(BuildContext context, {int section}) {
    return null;
  }

  @override
  Widget fillupForEmptyView(BuildContext context) => null;

  @override
  Widget builderSection(BuildContext context, int section) {
    int rowsPerPage = rowCount;
    if (rowsPerPage > 8 || rowsPerPage == 0) {
      rowsPerPage = 8;
    }
    return SliverFillViewport(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return PaginatedDataTable(
          onSelectAll: _selectAll,
          sortAscending: true,
          header: loading
              ? Center(
                  child: Container(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator()))
              : Container(),
          columns: <DataColumn>[
            DataColumn(
              label: Text('头像'),
            ),
            DataColumn(
              label: Text('用户名'),
            ),
            DataColumn(
              label: Text('邮箱'),
            ),
            DataColumn(
              label: Text('密码'),
            ),
          ],
          source: this,
          rowsPerPage: rowsPerPage,
        );
      }, childCount: 1),
    );
  }

  Widget buildListView(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: super.buildGroupedListView(context),
    );
  }

  void _selectAll(bool checked) {
    if (checked) {
      selectedUsers.addAll(allUsers);
    } else {
      selectedUsers.clear();
    }

    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= allUsers.length) return null;
    final User user = allUsers[index];
    return DataRow.byIndex(
        index: index,
        selected: selectedUsers.contains(user),
        onSelectChanged: (bool selected) {
          if (selectedUsers.contains(user) != selected) {
            if (selected) {
              selectedUsers.add(user);
            } else {
              selectedUsers.remove(user);
            }
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: user.uid != null && user.uid > 0
                ? CachedNetworkImageProvider(avatarForUserID(user.uid),
                    imageOnError: "assets/noavatar.png")
                : AssetImage("assets/noavatar.png"),
            radius: 12,
          )),
          DataCell(Text('${user?.userInfo?.username ?? ""}')),
          DataCell(Text('${user.identity}')),
          DataCell(Text('${user.password}')),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => allUsers.length;

  @override
  int get selectedRowCount => selectedUsers.length;

  @override
  Widget cellForSectionAndIndex(BuildContext context,
      {int section, int index}) {
    return null;
  }

  void onAddUserTap(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    final ValueKey _usernameKey = Key('__adduser__username__');
    final ValueKey _passwordKey = Key('__adduser__password__');

    final usernameFld = TextFormField(
      key: _usernameKey,
      controller: usernameController,
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      validator: (val) =>
          val.isEmpty || val.trim().length == 0 ? '请输入登录邮箱' : null,
      decoration: InputDecoration(
        hintText: '登录邮箱',
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
    );

    final passwordFld = TextFormField(
      key: _passwordKey,
      controller: passwordController,
      autocorrect: false,
      obscureText: true,
      autofocus: false,
      validator: (val) =>
          val.isEmpty || val.trim().length == 0 ? '请输入密码' : null,
      decoration: InputDecoration(
        hintText: '密码',
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
    );

    final form = Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('邮箱'),
            SizedBox(height: 4.0),
            usernameFld,
            SizedBox(height: 8.0),
            Text('密码'),
            SizedBox(height: 4.0),
            passwordFld,
            SizedBox(height: 18.0),
          ],
        ),
      ),
    );

    final completer = Completer<String>();

    showDialog<void>(
      context: _scaffoldKey.currentContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('添加账号'),
          content: form,
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('确定'),
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                final email = usernameController.text;
                final password = passwordController.text.trim();
                dispatchAction(context)(LoginTestRequest(
                    completer,
                    User().rebuild((b) => b
                      ..identity = email.trim()
                      ..password = password.trim())));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    completer.future.then((error) {
      String msg = '添加账号';
      if (error == null) {
        msg += '成功';
      } else {
        msg += '失败' + ": $error";
      }
      showToast(msg);
      dispatchAction(context)(LoginTestRequest(null, currentUser));
    });
  }

  @override
  void scrolledToBottom(BuildContext context) {
    // TODO: implement scrolledToBottom
  }
}
