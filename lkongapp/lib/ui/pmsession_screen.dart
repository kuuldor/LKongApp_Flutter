import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/fetched_list.dart';
import 'package:lkongapp/ui/forum_story.dart';
import 'package:lkongapp/ui/items/forum_item.dart';
import 'package:lkongapp/ui/items/item_wrapper.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/tools/drawer_button.dart';
import 'package:lkongapp/ui/tools/item_handler.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

import 'package:lkongapp/ui/connected_widget.dart';

class PMSessionScreen extends StatelessWidget {
  final int pmid;

  const PMSessionScreen({Key key, @required this.pmid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget(context, PMSessionModel.fromIDAndStore(pmid),
        (viewModel) {
      return viewModel.buildConversationView(context);
    });
  }
}

class PMSessionModel extends FetchedListModel {
  final int uid;
  final int pmid;
  final Profile profile;
  final FetchList<PrivateMessage> session;
  final bool loading;
  final String lastError;
  final bool showDetailTime;

  AppBar appBar(BuildContext context) => AppBar(
        title: GestureDetector(
          child: Text("与${profile?.user?.username ?? ""}的对话",
              style:
                  Theme.of(context).textTheme.title.apply(color: Colors.white)),
          onTap: () => scrollToTop(context),
        ),
      );

  @override
  bool operator ==(other) {
    return other is PMSessionModel &&
        session == other.session &&
        profile == other.profile &&
        loading == other.loading &&
        uid == other.uid &&
        pmid == other.pmid &&
        showDetailTime == other.showDetailTime &&
        lastError == other.lastError;
  }

  @override
  int get hashCode => hashObjects(
      [session, profile, loading, lastError, uid, pmid, showDetailTime]);

  PMSessionModel({
    @required this.uid,
    @required this.pmid,
    @required this.profile,
    @required this.session,
    @required this.showDetailTime,
    @required this.loading,
    @required this.lastError,
  });

  @override
  int get itemCount => session?.data?.length ?? 0;

  @override
  bool get reverse => true;

  @override
  APIRequest get fetchFromScratchRequest {
    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return GetPMSessionNewRequest(completer, uid, pmid, 0, 0);
  }

  @override
  APIRequest get loadMoreRequest {
    if (session == null || session.nexttime == 0) {
      return null;
    }

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return GetPMSessionLoadMoreRequest(completer, uid, pmid, session.nexttime);
  }

  @override
  APIRequest get refreshRequest {
    if (session == null || session.current == 0) {
      return null;
    }

    final Completer<String> completer = Completer<String>();
    completer.future.then((error) {});
    return GetPMSessionRefreshRequest(completer, uid, pmid, session.current);
  }

  @override
  Future<Null> handleRefresh(BuildContext context) {
    final Completer<String> completer = Completer<String>();
    dispatchAction(context)(GetPMSessionNewRequest(completer, uid, pmid, 0, 0));
    return completer.future.then((_) {});
  }

  static Function fromIDAndStore(int pmid) {
    final func = (Store<AppState> store) {
      final userData = selectUserData(store);
      final uid = selectUID(store);

      return PMSessionModel(
        profile: store.state.uiState.content.profiles[pmid],
        uid: uid,
        loading: store.state.uiState.content.loading,
        lastError: store.state.uiState.content.lastError,
        pmid: pmid,
        session: userData?.pmSession[pmid],
        showDetailTime: selectSetting(store).showDetailTime,
      );
    };
    return func;
  }

  Widget createPMSessionItem(BuildContext context, PrivateMessage message) {
    return ListTile(
      title: Text(
        message.message,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  @override
  Widget headerForSection(BuildContext context, {int section}) {
    return Container(
        color: Colors.grey[500],
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
        alignment: Alignment.centerLeft,
        child: Row(children: <Widget>[
          Expanded(
            child: TextField(),
          ),
          FlatButton(
            color: Colors.blue,
            child: Text("发送"),
            onPressed: () {},
          ),
        ]));
  }

  @override
  Widget createListItem(BuildContext context, int index) {
    BuiltList<PrivateMessage> messages = session.data;

    if (messages != null && index >= 0 && index < messages.length) {
      Widget item = createPMSessionItem(context, messages[index]);

      return wrapItem(context, item);
    }
    return null;
  }

  @override
  bool get initLoaded => (session?.data?.length ?? 0) > 0;

  @override
  void listIsReady(BuildContext context) {}

  Widget buildConversationView(BuildContext context) {
    if (profile == null) {
      if (loading != true && lastError == null) {
        handleFetchUserInfo(context);
      }
    }

    return Scaffold(
      appBar: appBar(context),
      body: buildListView(context),
    );
  }

  void handleFetchUserInfo(BuildContext context) {
    if (pmid != null && pmid > 0) {
      dispatchAction(context)(UserInfoRequest(null, pmid));
    }
  }
}
