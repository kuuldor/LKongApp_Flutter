import 'package:built_collection/built_collection.dart';
import 'package:lkongapp/models/lkong_jsons/story_result.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

import 'story_reducer.dart';
import 'forum_reducer.dart';

final contentReducer = combineReducers<ContentCache>([
  TypedReducer<ContentCache, APIFailure>(_contentRequestFailed),
  TypedReducer<ContentCache, LoginSuccess>(_loginSucceeded),
  _contentReducer,
]);

ContentCache _contentRequestFailed(ContentCache content, APIFailure action) {
  return content.rebuild((b) => b..lastError = action.error);
}

ContentCache _loginSucceeded(ContentCache content, action) {
  return content.rebuild((b) => b..homeList.replace(HomeList()));
}

ContentCache _contentReducer(ContentCache content, action) {
  return content.rebuild((b) => b
    ..homeList.replace(homeListReducer(content.homeList, action))
    ..storyRepo.replace(storyContentsReducer(content.storyRepo, action))
    ..forumRepo.replace(forumContentsReducer(content.forumRepo, action))
    );
}