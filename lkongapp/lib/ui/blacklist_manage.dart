import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/middlewares/api.dart';
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

class BlacklistManageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget(context, BlacklistManageModel.fromStore,
        (viewModel) {
      return viewModel.buildListView(context);
    });
  }
}

class BlacklistManageModel extends DataTableSource with GroupedListModel {
  final List<UserInfo> blacklist;
  final FollowList followList;
  final bool loading;
  final String lastError;

  Set<UserInfo> selectedUsers;
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
        final completers = List<Future<String>>();

        selectedUsers.forEach((user) {
          final completer = Completer<String>();
          completers.add(completer.future);
          dispatchAction(context)(FollowRequest(
            completer,
            id: user.uid,
            replyType: FollowType.black,
            unfollow: true,
          ));
        });
        Future.wait(completers).then((errors) {
          String msg = '解除黑名单';
          if (errors.where((e) => e != null).length == 0) {
            msg += '成功';
          } else {
            msg += '失败' + ": $errors";
          }
          showToast(msg);
        });
      },
    ));

    return SliverAppBar(
      title: GestureDetector(
        child: Text("黑名单管理",
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
    return other is BlacklistManageModel && blacklist == other.blacklist;
  }

  @override
  int get hashCode => blacklist.hashCode;

  BlacklistManageModel({
    @required this.blacklist,
    @required this.loading,
    @required this.lastError,
    @required this.followList,
  }) {
    selectedUsers = Set<UserInfo>();
  }

  static BlacklistManageModel fromStore(Store<AppState> store) {
    return BlacklistManageModel(
      blacklist: store.state.uiState.content.blacklist.toList(),
      followList: selectUserData(store)?.followList,
      loading: store.state.isLoading,
      lastError: store.state.persistState.authState.error,
    );
  }

  @override
  int get numberOfSections => 1;

  @override
  int countOfItemsInSection({int section}) {
    int count = blacklist?.length ?? 0;
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
          ],
          source: this,
          rowsPerPage: rowsPerPage,
        );
      }, childCount: 1),
    );
  }

  Widget buildListView(BuildContext context) {
    if (!initLoaded && loading != true && lastError == null) {
      handleFetchFromScratch(context);
    }

    Widget view;
    final listView = super.buildGroupedListView(context);

    if (refreshRequest != null) {
      view = listView;
    } else {
      view = RefreshIndicator(
          backgroundColor: Colors.white70,
          onRefresh: () => handleRefresh(context),
          child: listView);
    }

    return Scaffold(
      key: _scaffoldKey,
      body: view,
    );
  }

  void _selectAll(bool checked) {
    if (checked) {
      selectedUsers.addAll(blacklist);
    } else {
      selectedUsers.clear();
    }

    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= blacklist.length) return null;
    final UserInfo user = blacklist[index];
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
          DataCell(Text('${user?.username ?? ""}')),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => blacklist.length;

  @override
  int get selectedRowCount => selectedUsers.length;

  @override
  Widget cellForSectionAndIndex(BuildContext context,
      {int section, int index}) {
    return null;
  }

  bool get initLoaded =>
      (blacklist?.length ?? 0) >= (followList?.black?.length ?? 0);

  APIRequest get refreshRequest => fetchFromScratchRequest;
  APIRequest get fetchFromScratchRequest {
    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {
      // showToast(context, success ? 'Loading Succeed' : 'Loading Failed');
    });
    return GetBlacklistRequest(completer);
  }

  APIRequest get loadMoreRequest => null;

  Future<Null> handleRefresh(BuildContext context) async {
    var request = refreshRequest;
    if (request != null) {
      dispatchAction(context)(request);
      return request.completer.future.then((_) {});
    }

    return Future(() {});
  }

  Future<Null> handleFetchFromScratch(BuildContext context) async {
    var request = fetchFromScratchRequest;
    if (request != null) {
      dispatchAction(context)(request);
    }
  }

  Future<Null> handleLoadMore(BuildContext context) async {
    var request = loadMoreRequest;
    if (request != null) {
      dispatchAction(context)(request);
    }
  }

  void onAddUserTap(BuildContext context) {
    final usernameController = TextEditingController();

    final ValueKey _usernameKey = Key('__addblacklist__username__');

    final usernameFld = TextFormField(
      key: _usernameKey,
      controller: usernameController,
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      validator: (val) =>
          val.isEmpty || val.trim().length == 0 ? '请输入用户名' : null,
      decoration: InputDecoration(
        hintText: '输入用户名',
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
            Text('用户名'),
            SizedBox(height: 4.0),
            usernameFld,
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
          title: Text('拉黑用户'),
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
                final username = usernameController.text;
                apiDispatch(QUERY_API, {"userName": username}).then((result) {
                  int uid;
                  final location = result["location"];
                  if (location != null) {
                    uid = parseLKTypeId(location, type: "user");
                  }
                  if (uid != null) {
                    dispatchAction(context)(FollowRequest(
                      completer,
                      id: uid,
                      name: username,
                      replyType: FollowType.black,
                      unfollow: false,
                    ));
                  } else {
                    final String error = result["error"] ?? "没有找到用户";
                    Future.delayed(Duration(milliseconds: 200),
                        () => completer.complete(error));
                  }

                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );

    completer.future.then((error) {
      String msg = '拉黑用户';
      if (error == null) {
        msg += '成功';
      } else {
        msg += '失败' + ": $error";
      }
      showToast(msg);
    });
  }
}
