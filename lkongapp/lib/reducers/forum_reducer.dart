import 'package:built_collection/built_collection.dart';
import 'package:lkongapp/models/lkong_jsons/story_result.dart';
import 'package:lkongapp/reducers/fetchlist_reducer.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

final forumContentsReducer = combineReducers<ForumLists>([
  TypedReducer<ForumLists, ForumListRequest>(_forumRequestSent),
  TypedReducer<ForumLists, ForumInfoRequest>(_forumRequestSent),
  TypedReducer<ForumLists, ForumListSuccess>(_forumListSucceeded),
  TypedReducer<ForumLists, ForumInfoSuccess>(_forumInfoSucceeded),
  TypedReducer<ForumLists, ForumListFailure>(_forumFaileded),
  TypedReducer<ForumLists, ForumInfoFailure>(_forumFaileded),
]);

ForumLists _forumRequestSent(ForumLists forumRepo, action) {
  return forumRepo.rebuild((b) => b..loading = true);
}

ForumLists _forumFaileded(ForumLists forumRepo, APIFailure action) {
  var newRepo = forumRepo;
  newRepo = newRepo.rebuild((b) => b
    ..loading = false
    ..lastError = action.error);

  return newRepo;
}

ForumLists _forumListSucceeded(ForumLists forumRepo, ForumListSuccess action) {
  var list = action.list;
  var newRepo = forumRepo;
  if (list != null && list.isok) {
    var syswm = newRepo.sysplanes.map((f) => f.fid).toSet();

    newRepo = newRepo.rebuild((b) => b
      ..loading = false
      ..lastError = null
      ..forums.replace(list.forumList)
      ..sysplanes.addAll(list.sysweimian.where((f) => !syswm.contains(f.fid))));
  }

  return newRepo;
}

ForumLists _forumInfoSucceeded(ForumLists forumRepo, ForumInfoSuccess action) {
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
final forumRepoReducer = combineReducers<BuiltMap<int, FetchList<Story>>>([
  TypedReducer<BuiltMap<int, FetchList<Story>>, ForumStoryNewRequest>(
      _forumStoryNew),
  TypedReducer<BuiltMap<int, FetchList<Story>>, ForumStoryRequest>(
      _forumStoryRequested),
  TypedReducer<BuiltMap<int, FetchList<Story>>, ForumStoryFailure>(
      _forumStoryFailed),
  TypedReducer<BuiltMap<int, FetchList<Story>>, ForumStoryCheckNewFailure>(
      _forumStoryCheckNewFailed),
  TypedReducer<BuiltMap<int, FetchList<Story>>, ForumStoryCheckNewSuccess>(
      _forumStoryNewCountChecked),
  TypedReducer<BuiltMap<int, FetchList<Story>>, ForumStoryNewSuccess>(
      _forumStorySucceeded(FetchListRequestType.New)),
  TypedReducer<BuiltMap<int, FetchList<Story>>, ForumStoryRefreshSuccess>(
      _forumStorySucceeded(FetchListRequestType.Refresh)),
  TypedReducer<BuiltMap<int, FetchList<Story>>, ForumStoryLoadMoreSuccess>(
      _forumStorySucceeded(FetchListRequestType.LoadMore)),
]);

BuiltMap<int, FetchList<Story>> _forumStoryRequested(
    BuiltMap<int, FetchList<Story>> repo, ForumStoryRequest action) {
  return repo.rebuild((b) => b.updateValue(
        action.forum,
        (v) => fetchListLoading(v),
        ifAbsent: () => fetchListLoading(FetchList<Story>()),
      ));
}

BuiltMap<int, FetchList<Story>> _forumStoryNew(
    BuiltMap<int, FetchList<Story>> repo, ForumStoryNewRequest action) {
  var emptyLoadingList = FetchList<Story>();
  return repo.rebuild((b) => b.updateValue(
        action.forum,
        (v) => emptyLoadingList,
        ifAbsent: () => emptyLoadingList,
      ));
}

BuiltMap<int, FetchList<Story>> _forumStoryNewCountChecked(
    BuiltMap<int, FetchList<Story>> repo, ForumStoryCheckNewSuccess action) {
  var newRepo = repo;
  var request = action.request as ForumStoryCheckNewRequest;
  if (request != null) {
    final fid = request.forum;
    final result = action.result;
    final value =
        fetchListNewCountChecked(newRepo[fid] ?? FetchList<Story>(), result);

    newRepo = newRepo.rebuild(
        (b) => b.updateValue(fid, (v) => value, ifAbsent: () => value));
  }
  return newRepo;
}

BuiltMap<int, FetchList<Story>> _forumStoryFailed(
    BuiltMap<int, FetchList<Story>> repo, ForumStoryFailure action) {
  int fid;

  final request = action.request as ForumStoryRequest;
  if (request != null) {
    fid = request.forum;
  }
  return _forumRequestFailed(repo, fid, action);
}

BuiltMap<int, FetchList<Story>> _forumStoryCheckNewFailed(
    BuiltMap<int, FetchList<Story>> repo, ForumStoryCheckNewFailure action) {
  int fid;

  final request = action.request as ForumStoryCheckNewRequest;
  if (request != null) {
    fid = request.forum;
  }
  return _forumRequestFailed(repo, fid, action);
}

BuiltMap<int, FetchList<Story>> _forumRequestFailed(
    BuiltMap<int, FetchList<Story>> repo, int fid, APIFailure action) {
  var newRepo = repo;
  if (fid != null) {
    final error = action.error;
    final value = fetchListFailed(newRepo[fid] ?? FetchList<Story>(), error);
    newRepo = newRepo.rebuild(
        (b) => b.updateValue(fid, (v) => value, ifAbsent: () => value));
  }

  return newRepo;
}

_forumStorySucceeded(FetchListRequestType type) =>
    (BuiltMap<int, FetchList<Story>> repo, ForumStorySuccess action) {
      var request = action.request as ForumStoryRequest;
      var result = action.result;
      var newRepo = repo;
      int fid = request.forum;
      final value =
          fetchListSucceeded(type, newRepo[fid] ?? FetchList<Story>(), result);

      newRepo = newRepo.rebuild(
          (b) => b.updateValue(fid, (v) => value, ifAbsent: () => value));

      return newRepo;
    };
