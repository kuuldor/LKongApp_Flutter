import 'package:lkongapp/models/models.dart';

import 'package:redux/redux.dart';

final selectUser = (Store<AppState> store) =>
    store.state.persistState.authState.isAuthed
        ? store.state.persistState.authState.currentUser
        : null;

final selectUserInfo = (Store<AppState> store) =>
    store.state.persistState.authState.isAuthed
        ? store.state.persistState.authState.userInfo
        : null;
