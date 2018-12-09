import 'package:lkongapp/models/models.dart';

import 'package:redux/redux.dart';

final selectUID =
    (Store<AppState> store) => store.state.persistState.authState.currentUser;
final selectUser = (Store<AppState> store) => store.state.persistState.authState
    .userRepo[store.state.persistState.authState.currentUser];

final selectUserData = (Store<AppState> store) => store.state.uiState.content
    .userData[store.state.persistState.authState.currentUser];
