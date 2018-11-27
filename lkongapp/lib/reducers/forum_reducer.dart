import 'package:built_collection/built_collection.dart';
import 'package:lkongapp/models/lkong_jsons/story_result.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

final forumContentsReducer = combineReducers<ForumInfo>([
  // TypedReducer<ForumInfo, ForumListRequest>(_forumListRequested),
  TypedReducer<ForumInfo, ForumListSuccess>(_forumListSucceeded),
  // TypedReducer<ForumInfo, ForumInfoRequest>(_forumInfoRequested),
  TypedReducer<ForumInfo, ForumInfoSuccess>(_forumInfoSucceeded),
]);

// ForumInfo _forumListRequested(
//     ForumInfo forumRepo, ForumListRequest action) {
//   var newRepo = forumRepo;
//   return newRepo;
// }

ForumInfo _forumListSucceeded(ForumInfo forumRepo, ForumListSuccess action) {
  var list = action.list;
  var newRepo = forumRepo;
  if (list != null && list.isok) {
    newRepo = newRepo.rebuild((b) =>
        b..forums.replace(list.forumList)..sysplanes.replace(list.sysweimian));
  }

  return newRepo;
}

// ForumInfo _forumInfoRequested(
//     ForumInfo forumRepo, ForumInfoRequest action) {}

ForumInfo _forumInfoSucceeded(ForumInfo forumRepo, ForumInfoSuccess action) {
  var result = action.result;
  var newRepo = forumRepo;
  if (result != null && result.isok) {
    newRepo = newRepo.rebuild((b) =>
        b..info.updateValue(result.fid, (v) => result, ifAbsent: () => result));
  }
  return newRepo;
}

enum ForumStoryRequestType {
  New,
  Refresh,
  LoadMore,
}
final forumRepoReducer = combineReducers<BuiltMap<int, StoryFetchList>>([
  TypedReducer<BuiltMap<int, StoryFetchList>, ForumStoryNewSuccess>(
      _forumStorySucceeded(ForumStoryRequestType.New)),
  TypedReducer<BuiltMap<int, StoryFetchList>, ForumStoryRefreshSuccess>(
      _forumStorySucceeded(ForumStoryRequestType.Refresh)),
  TypedReducer<BuiltMap<int, StoryFetchList>, ForumStoryLoadMoreSuccess>(
      _forumStorySucceeded(ForumStoryRequestType.LoadMore)),
]);

_forumStorySucceeded(ForumStoryRequestType type) =>
    (BuiltMap<int, StoryFetchList> repo, ForumStorySuccess action) {
      var request = action.request as ForumStoryRequest;
      var result = action.result;
      var newRepo = repo;
      var list = result.data;

      if (request != null && list != null && list.length > 0) {
        int fid = request.forum;
        final update = (StoryFetchListBuilder b) {
          int nexttime = type != ForumStoryRequestType.Refresh
              ? result.nexttime
              : b.nexttime;
          int current = type != ForumStoryRequestType.LoadMore
              ? result.curtime
              : b.current;

          b
            ..nexttime = nexttime
            ..current = current;
          switch (type) {
            case ForumStoryRequestType.New:
              b..stories.replace(list);
              break;
            case ForumStoryRequestType.Refresh:
              b..stories.insertAll(0, list);
              break;
            case ForumStoryRequestType.LoadMore:
              b..stories.addAll(list);
              break;
          }
        };
        newRepo = newRepo.rebuild((b) => b.updateValue(
            fid, (v) => v.rebuild(update),
            ifAbsent: () => StoryFetchList().rebuild(update)));
      }

      return newRepo;
    };
