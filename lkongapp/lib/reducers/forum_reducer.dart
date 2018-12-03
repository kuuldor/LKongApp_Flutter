import 'package:built_collection/built_collection.dart';
import 'package:lkongapp/models/lkong_jsons/story_result.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

final forumContentsReducer = combineReducers<ForumInfo>([
  TypedReducer<ForumInfo, ForumListRequest>(_forumRequestSent),
  TypedReducer<ForumInfo, ForumInfoRequest>(_forumRequestSent),
  TypedReducer<ForumInfo, ForumListSuccess>(_forumListSucceeded),
  TypedReducer<ForumInfo, ForumInfoSuccess>(_forumInfoSucceeded),
  TypedReducer<ForumInfo, ForumListFailure>(_forumFaileded),
  TypedReducer<ForumInfo, ForumInfoFailure>(_forumFaileded),
]);

ForumInfo _forumRequestSent(ForumInfo forumRepo, action) {
  return forumRepo.rebuild((b) => b..loading = true);
}

ForumInfo _forumFaileded(ForumInfo forumRepo, APIFailure action) {
  var newRepo = forumRepo;
  newRepo = newRepo.rebuild((b) => b
    ..loading = false
    ..lastError = action.error);

  return newRepo;
}

ForumInfo _forumListSucceeded(ForumInfo forumRepo, ForumListSuccess action) {
  var list = action.list;
  var newRepo = forumRepo;
  if (list != null && list.isok) {
    newRepo = newRepo.rebuild((b) => b
      ..loading = false
      ..lastError = null
      ..forums.replace(list.forumList)
      ..sysplanes.replace(list.sysweimian));
  }

  return newRepo;
}

ForumInfo _forumInfoSucceeded(ForumInfo forumRepo, ForumInfoSuccess action) {
  var result = action.result;
  var newRepo = forumRepo;
  if (result != null && result.isok) {
    newRepo = newRepo.rebuild((b) => b
      ..loading = false
      ..lastError = null
      ..info.updateValue(result.fid, (v) => result, ifAbsent: () => result));
  }
  return newRepo;
}

enum ForumStoryRequestType {
  New,
  Refresh,
  LoadMore,
}
final forumRepoReducer = combineReducers<BuiltMap<int, StoryFetchList>>([
  TypedReducer<BuiltMap<int, StoryFetchList>, ForumStoryNewRequest>(
      _forumStoryNew),
  TypedReducer<BuiltMap<int, StoryFetchList>, ForumStoryRequest>(
      _forumStoryRequested),
  TypedReducer<BuiltMap<int, StoryFetchList>, ForumStoryFailure>(
      _forumStoryFailed),
  TypedReducer<BuiltMap<int, StoryFetchList>, ForumStoryCheckNewFailure>(
      _forumStoryCheckNewFailed),
  TypedReducer<BuiltMap<int, StoryFetchList>, ForumStoryCheckNewSuccess>(
      _forumStoryNewCountChecked),
  TypedReducer<BuiltMap<int, StoryFetchList>, ForumStoryNewSuccess>(
      _forumStorySucceeded(ForumStoryRequestType.New)),
  TypedReducer<BuiltMap<int, StoryFetchList>, ForumStoryRefreshSuccess>(
      _forumStorySucceeded(ForumStoryRequestType.Refresh)),
  TypedReducer<BuiltMap<int, StoryFetchList>, ForumStoryLoadMoreSuccess>(
      _forumStorySucceeded(ForumStoryRequestType.LoadMore)),
]);

BuiltMap<int, StoryFetchList> _forumStoryRequested(
    BuiltMap<int, StoryFetchList> repo, ForumStoryRequest action) {
  return repo.rebuild((b) =>
      b.updateValue(action.forum, (v) => v.rebuild((b) => b..loading = true)));
}

BuiltMap<int, StoryFetchList> _forumStoryNew(
    BuiltMap<int, StoryFetchList> repo, ForumStoryNewRequest action) {
  var emptyLoadingList = StoryFetchList();
  return repo.rebuild((b) => b.updateValue(
      action.forum, (v) => emptyLoadingList,
      ifAbsent: () => emptyLoadingList));
}

BuiltMap<int, StoryFetchList> _forumStoryNewCountChecked(
    BuiltMap<int, StoryFetchList> repo, ForumStoryCheckNewSuccess action) {
  var newRepo = repo;
  var request = action.request as ForumStoryCheckNewRequest;
  if (request != null) {
    int fid = request.forum;

    var result = action.result;
    final update = (StoryFetchListBuilder b) => b.newcount = result;

    newRepo = newRepo.rebuild((b) => b.updateValue(
        fid, (v) => v.rebuild(update),
        ifAbsent: () => StoryFetchList().rebuild(update)));
  }
  return newRepo;
}

BuiltMap<int, StoryFetchList> _forumStoryFailed(
    BuiltMap<int, StoryFetchList> repo, ForumStoryFailure action) {
  int fid;

  final request = action.request as ForumStoryRequest;
  if (request != null) {
    fid = request.forum;
  }
  return _forumRequestFailed(repo, fid, action);
}

BuiltMap<int, StoryFetchList> _forumStoryCheckNewFailed(
    BuiltMap<int, StoryFetchList> repo, ForumStoryCheckNewFailure action) {
  int fid;

  final request = action.request as ForumStoryCheckNewRequest;
  if (request != null) {
    fid = request.forum;
  }
  return _forumRequestFailed(repo, fid, action);
}

BuiltMap<int, StoryFetchList> _forumRequestFailed(
    BuiltMap<int, StoryFetchList> repo, int fid, APIFailure action) {
  var newRepo = repo;
  if (fid != null) {
    newRepo = newRepo.rebuild((b) => b.updateValue(
        fid,
        (v) => v.rebuild((b) => b
          ..loading = false
          ..lastError = action.error),
        ifAbsent: () =>
            StoryFetchList().rebuild((b) => b.lastError = action.error)));
  }

  return newRepo;
}

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
            ..loading = false
            ..lastError = null
            ..nexttime = nexttime
            ..current = current;
          switch (type) {
            case ForumStoryRequestType.New:
              b
                ..newcount = 0
                ..stories.replace(list);
              break;
            case ForumStoryRequestType.Refresh:
              var newsSet = list.map((story) => story.id).toSet();

              b
                ..newcount = 0
                ..stories.where((story) => !newsSet.contains(story.id))
                ..stories.insertAll(0, list);

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
