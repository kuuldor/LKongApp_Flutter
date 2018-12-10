import 'package:built_collection/built_collection.dart';
import 'package:lkongapp/models/lkong_jsons/story_result.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

import 'story_reducer.dart';
import 'forum_reducer.dart';
import 'userdata_reducer.dart';
import 'search_reducer.dart';

final contentReducer = combineReducers<ContentCache>([
  TypedReducer<ContentCache, APIRequest>(_contentRequested),
  TypedReducer<ContentCache, APIFailure>(_contentRequestFailed),
  TypedReducer<ContentCache, APISuccess>(_contentRequestSucceed),
  TypedReducer<ContentCache, LoginSuccess>(_loginoutSucceeded),
  TypedReducer<ContentCache, LogoutSuccess>(_loginoutSucceeded),
  _contentReducer,
]);

ContentCache _contentRequested(ContentCache content, APIRequest action) {
  return content.rebuild((b) => b..lastError = null);
}

ContentCache _contentRequestFailed(ContentCache content, APIFailure action) {
  return content.rebuild((b) => b..lastError = action.error);
}

ContentCache _contentRequestSucceed(ContentCache content, APISuccess action) {
  return content.rebuild((b) => b..lastError = null);
}

ContentCache _loginoutSucceeded(ContentCache content, action) {
  return content.rebuild((b) => b..homeList.replace(StoryFetchList()));
}

ContentCache _contentReducer(ContentCache content, action) {
  return content.rebuild((b) => b
    ..homeList.replace(homeListReducer(content.homeList, action))
    ..storyRepo.replace(storyContentsReducer(content.storyRepo, action))
    ..forumInfo.replace(forumContentsReducer(content.forumInfo, action))
    ..userData.replace(userDataReducer(content.userData, action))
    ..searchResult.replace(searchResultReducer(content.searchResult, action))
    ..forumRepo.replace(forumRepoReducer(content.forumRepo, action)));
}
