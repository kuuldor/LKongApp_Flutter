import 'package:lkongapp/models/models.dart';

import 'package:redux/redux.dart';

final selectUser = (Store<AppState> store) => store.state.persistState.authState
    .userRepo[store.state.persistState.authState.currentUser];
