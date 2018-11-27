import 'package:built_collection/built_collection.dart';
import 'package:lkongapp/models/lkong_jsons/story_result.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';


final storyContentsReducer = combineReducers<BuiltMap<int, StoryPageList>>([
  TypedReducer<BuiltMap<int, StoryPageList>, StoryContentRequest>(
      _storyContentRequested),
  TypedReducer<BuiltMap<int, StoryPageList>, StoryContentSuccess>(
      _storyContentSucceeded),
  TypedReducer<BuiltMap<int, StoryPageList>, StoryInfoRequest>(
      _storyInfoRequested),
  TypedReducer<BuiltMap<int, StoryPageList>, StoryInfoSuccess>(
      _storyInfoSucceeded),
]);

BuiltMap<int, StoryPageList> _storyInfoRequested(
    BuiltMap<int, StoryPageList> storyRepo, StoryInfoRequest action) {
  var newRepo = storyRepo;

  if (action.story != null) {
    int threadId = action.story;
    newRepo = _buildStoryPages(newRepo, threadId);
  }
  return newRepo;
}

BuiltMap<int, StoryPageList> _storyInfoSucceeded(
    BuiltMap<int, StoryPageList> storyRepo, StoryInfoSuccess action) {
  var newRepo = storyRepo;
  final result = action.result;

  if (result is StoryInfoResult) {
    int threadId = result.tid;

    newRepo = newRepo.rebuild((b) => b
      ..updateValue(
          threadId, (v) => v.rebuild((b) => b..storyInfo.replace(result))));
  }
  return newRepo;
}

BuiltMap<int, StoryPageList> _buildStoryPages(
    BuiltMap<int, StoryPageList> newRepo, int threadId) {
  StoryPageList storyContents = newRepo[threadId];
  if (storyContents == null) {
    newRepo = newRepo
        .rebuild((b) => b..addEntries([MapEntry(threadId, StoryPageList())]));
    storyContents = newRepo[threadId];
  }
  return newRepo;
}

BuiltMap<int, StoryPageList> _storyContentRequested(
    BuiltMap<int, StoryPageList> storyRepo, StoryContentRequest action) {
  var newRepo = storyRepo;

  if (action.story != null) {
    int threadId = action.story;
    newRepo = _buildStoryPages(newRepo, threadId);

    StoryPageList storyContents = newRepo[threadId];
    StoryPage page = StoryPage();
    if (storyContents.pages[action.page] == null) {
      newRepo = newRepo.rebuild((b) => b.updateValue(
          threadId,
          (v) => v.rebuild(
              (b) => b..pages.addEntries([MapEntry(action.page, page)]))));
    }
  }
  return newRepo;
}

BuiltMap<int, StoryPageList> _storyContentSucceeded(
    BuiltMap<int, StoryPageList> storyRepo, StoryContentSuccess action) {
  var newRepo = storyRepo;
  final result = action.result;
  var id = parseLKTypeId(result.model);

  if (id != null) {
    int threadId = int.parse(id);
    StoryPage page =
        StoryPage().rebuild((b) => b..comments.replace(result.comments));

    newRepo = newRepo.rebuild((b) => b
      ..updateValue(
          threadId,
          (v) => v
              .rebuild((b) => b..pages.updateValue(result.page, (v) => page))));
  }
  return newRepo;
}

final homeListReducer = combineReducers<HomeList>([
  // TypedReducer<HomeList, HomeListRequest>(_homeListLoading),
  TypedReducer<HomeList, HomeListNewSuccess>(
      _homeListSucceeded(HomeListRequestType.New)),
  // TypedReducer<HomeList, HomeListNewFailure>(
      // _homeListFailed(HomeListRequestType.New)),
  TypedReducer<HomeList, HomeListRefreshSuccess>(
      _homeListSucceeded(HomeListRequestType.Refresh)),
  // TypedReducer<HomeList, HomeListRefreshFailure>(
      // _homeListFailed(HomeListRequestType.Refresh)),
  TypedReducer<HomeList, HomeListLoadMoreSuccess>(
      _homeListSucceeded(HomeListRequestType.LoadMore)),
  // TypedReducer<HomeList, HomeListLoadMoreFailure>(
      // _homeListFailed(HomeListRequestType.LoadMore)),
]);

enum HomeListRequestType {
  New,
  Refresh,
  LoadMore,
}

_homeListSucceeded(HomeListRequestType type) =>
    (HomeList list, HomeListSuccess action) {
      return list.rebuild((b) {
        // b..loading = false;
        var data = action.list.data;
        if (data.length > 0) {
          int nexttime = type != HomeListRequestType.Refresh
              ? action.list.nexttime
              : list.nexttime;
          int current = type != HomeListRequestType.LoadMore
              ? action.list.curtime
              : list.current;

          b
            ..nexttime = nexttime
            ..current = current;
          switch (type) {
            case HomeListRequestType.New:
              b..stories.replace(data);
              break;
            case HomeListRequestType.Refresh:
              b..stories.insertAll(0, data);
              break;
            case HomeListRequestType.LoadMore:
              b..stories.addAll(data);
              break;
          }
        }
        return b;
      });
    };

// _homeListFailed(HomeListRequestType type) => (HomeList list, action) {
//       return list.rebuild((b) => b..loading = false);
//     };

// HomeList _homeListLoading(HomeList list, action) {
//   return list.rebuild((b) => b..loading = true);
// }
