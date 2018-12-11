import 'package:built_collection/built_collection.dart';
import 'package:lkongapp/models/lkong_jsons/search_result.dart';
import 'package:lkongapp/models/lkong_jsons/story_result.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

import 'fetchlist_reducer.dart';

final searchResultReducer = combineReducers<SearchResult>([
  TypedReducer<SearchResult, SearchNewRequest>(_searchResultRequested),
  TypedReducer<SearchResult, SearchFailure>(_searchResultFailed),
  TypedReducer<SearchResult, SearchSuccess>(_searchResultSucceeded),
  // TypedReducer<SearchResult, SearchLoadMoreSuccess>(_searchLoadMoreSucceeded),
]);

SearchResult _searchResultRequested(SearchResult repo, SearchRequest action) {
  return SearchResult().rebuild((b) => b
    ..loading = true
    ..searchString = action.searchString
    ..searchType = action.searchType);
}

SearchResult _searchResultFailed(SearchResult repo, SearchFailure action) {
  return repo.rebuild((b) => b..lastError = action.error);
}

// SearchResult _searchLoadMoreSucceeded(
//     SearchResult repo, SearchLoadMoreSuccess action) {
//   var newRepo = repo;
//   final request = action.request as SearchLoadMoreRequest;
//   final result = action.result;
//   SearchResultBuilder Function(SearchResultBuilder) updates;
//   switch (request.searchType) {
//     case 0: //Story
//       updates = (SearchResultBuilder b) => b
//         ..lastError = null
//         ..loading = false
//         ..stories.replace(fetchListSucceeded(FetchListRequestType.LoadMore,
//             newRepo.stories, result as StoryListResult));
//       break;
//     case 1: //User
//       updates = (SearchResultBuilder b) => b
//         ..lastError = null
//         ..loading = false
//         ..users.replace(
//             searchMoreUserSucceeded(newRepo.users, result as SearchUserResult));
//       break;
//     case 2: //Forum
//       updates = (SearchResultBuilder b) => b
//         ..lastError = null
//         ..loading = false
//         ..forums.replace(searchMoreForumSucceeded(
//             newRepo.forums, result as SearchForumResult));
//       break;
//   }

//   newRepo = newRepo.rebuild(updates);
//   return newRepo;
// }

SearchForumResult searchForumSucceeded(
    SearchForumResult forums, SearchForumResult result) {
  int nexttime = result.forumInfo.length > 0 ? result.nexttime : 0;
  return forums.rebuild((b) => b
    ..nexttime = nexttime
    ..forumInfo.addAll(result.forumInfo ?? []));
}

SearchUserResult searchUserSucceeded(
    SearchUserResult users, SearchUserResult result) {
  int nexttime = result.user.length > 0 ? result.nexttime : 0;
  return users.rebuild((b) => b
    ..nexttime = nexttime
    ..user.addAll(result.user ?? []));
}

StoryFetchList searchStorySucceeded(
    StoryFetchList list, StoryListResult result) {
  int nexttime = result.data.length > 0 ? result.nexttime : 0;
  return list.rebuild((b) => b
    ..nexttime = nexttime
    ..stories.addAll(result.data ?? []));
}

SearchResult _searchResultSucceeded(SearchResult repo, SearchSuccess action) {
  var newRepo = repo;
  final request = action.request as SearchRequest;
  final result = action.result;
  SearchResultBuilder Function(SearchResultBuilder) updates;
  switch (request.searchType) {
    case 0: //Story
      updates = (SearchResultBuilder b) => b
        ..lastError = null
        ..loading = false
        ..stories.replace(
            searchStorySucceeded(newRepo.stories, result as StoryListResult));
      break;
    case 1: //User
      updates = (SearchResultBuilder b) => b
        ..lastError = null
        ..loading = false
        ..users.replace(
            searchUserSucceeded(newRepo.users, result as SearchUserResult));
      break;
    case 2: //Forum
      updates = (SearchResultBuilder b) => b
        ..lastError = null
        ..loading = false
        ..forums.replace(
            searchForumSucceeded(newRepo.forums, result as SearchForumResult));
      break;
  }

  newRepo = newRepo.rebuild(updates);
  return newRepo;
}
