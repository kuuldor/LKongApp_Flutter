import 'package:lkongapp/models/models.dart';

import 'package:redux/redux.dart';

final selectForumStories = (Store<AppState> store) =>
    (forum) => store.state.uiState.content.forumRepo[forum];
