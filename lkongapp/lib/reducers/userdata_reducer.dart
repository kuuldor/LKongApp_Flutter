import 'package:built_collection/built_collection.dart';
import 'package:lkongapp/models/lkong_jsons/story_result.dart';
import 'package:lkongapp/reducers/fetchlist_reducer.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

final userDataReducer = combineReducers<BuiltMap<int, UserData>>([
  TypedReducer<BuiltMap<int, UserData>, FollowListSuccess>(
      _followListSucceeded),
  TypedReducer<BuiltMap<int, UserData>, PunchCardSuccess>(_punchCardSucceeded),
  _favoriteReducer,
  _atMeReducer,
]);

BuiltMap<int, UserData> _followListSucceeded(
    BuiltMap<int, UserData> state, FollowListSuccess action) {
  final request = action.request as FollowListRequest;
  final user = request.user;
  final followList = action.followList;
  final update = (b) => b..followList.replace(followList);
  return state.rebuild((b) => b
    ..updateValue(user.uid, (v) => v.rebuild(update),
        ifAbsent: () => UserData().rebuild(update)));
}

BuiltMap<int, UserData> _punchCardSucceeded(
    BuiltMap<int, UserData> state, PunchCardSuccess action) {
  final request = action.request as PunchCardRequest;
  final user = request.user;
  final result = action.result;
  final update = (b) => b..punchCard.replace(result);
  return state.rebuild((b) => b
    ..updateValue(user.uid, (v) => v.rebuild(update),
        ifAbsent: () => UserData().rebuild(update)));
}

enum GetMyDataRequestType {
  New,
  Refresh,
  LoadMore,
}
final _favoriteReducer = combineReducers<BuiltMap<int, UserData>>([
  TypedReducer<BuiltMap<int, UserData>, GetMyFavoritesNewRequest>(
      _getMyFavoritesNew),
  TypedReducer<BuiltMap<int, UserData>, GetMyFavoritesRequest>(
      _getMyFavoritesRequested),
  TypedReducer<BuiltMap<int, UserData>, GetMyFavoritesFailure>(
      _getMyFavoritesFailed),
  TypedReducer<BuiltMap<int, UserData>, GetMyFavoritesNewSuccess>(
      _getMyFavoritesSucceeded(FetchListRequestType.New)),
  TypedReducer<BuiltMap<int, UserData>, GetMyFavoritesRefreshSuccess>(
      _getMyFavoritesSucceeded(FetchListRequestType.Refresh)),
  TypedReducer<BuiltMap<int, UserData>, GetMyFavoritesLoadMoreSuccess>(
      _getMyFavoritesSucceeded(FetchListRequestType.LoadMore)),
]);

BuiltMap<int, UserData> _getMyFavoritesRequested(
    BuiltMap<int, UserData> repo, GetMyFavoritesRequest action) {
  return repo.rebuild((b) => b.updateValue(
        action.uid,
        (v) => v.rebuild(
              (b) => b.favorites.replace(
                    fetchListLoading(v.favorites),
                  ),
            ),
      ));
}

BuiltMap<int, UserData> _getMyFavoritesNew(
    BuiltMap<int, UserData> repo, GetMyFavoritesNewRequest action) {
  final updates = (b) => b.favorites.replace(StoryFetchList());
  return repo.rebuild((b) => b.updateValue(
      action.uid, (v) => v.rebuild(updates),
      ifAbsent: () => UserData().rebuild(updates)));
}

BuiltMap<int, UserData> _getMyFavoritesFailed(
    BuiltMap<int, UserData> repo, GetMyFavoritesFailure action) {
  int uid;

  final request = action.request as GetMyFavoritesRequest;
  if (request != null) {
    uid = request.uid;
  }

  var newRepo = repo;
  if (uid != null) {
    final data = newRepo[uid] ?? UserData();
    final value = data.rebuild((b) =>
        b.favorites.replace(fetchListFailed(data.favorites, action.error)));
    newRepo = newRepo.rebuild(
        (b) => b.updateValue(uid, (v) => value, ifAbsent: () => value));
  }

  return newRepo;
}

_getMyFavoritesSucceeded(FetchListRequestType type) =>
    (BuiltMap<int, UserData> repo, GetMyFavoritesSuccess action) {
      var request = action.request as GetMyFavoritesRequest;
      int uid = request.uid;
      var result = action.result;
      var newRepo = repo;
      final data = newRepo[uid] ?? UserData();
      final value = data.rebuild((b) => b.favorites
          .replace(fetchListSucceeded(type, data.favorites, result)));

      newRepo = newRepo.rebuild(
          (b) => b.updateValue(uid, (v) => value, ifAbsent: () => value));

      return newRepo;
    };

final _atMeReducer = combineReducers<BuiltMap<int, UserData>>([
  TypedReducer<BuiltMap<int, UserData>, GetMyAtsNewRequest>(_getMyAtsNew),
  TypedReducer<BuiltMap<int, UserData>, GetMyAtsRequest>(_getMyAtsRequested),
  TypedReducer<BuiltMap<int, UserData>, GetMyAtsFailure>(_getMyAtsFailed),
  TypedReducer<BuiltMap<int, UserData>, GetMyAtsNewSuccess>(
      _getMyAtsSucceeded(FetchListRequestType.New)),
  TypedReducer<BuiltMap<int, UserData>, GetMyAtsRefreshSuccess>(
      _getMyAtsSucceeded(FetchListRequestType.Refresh)),
  TypedReducer<BuiltMap<int, UserData>, GetMyAtsLoadMoreSuccess>(
      _getMyAtsSucceeded(FetchListRequestType.LoadMore)),
]);

BuiltMap<int, UserData> _getMyAtsRequested(
    BuiltMap<int, UserData> repo, GetMyAtsRequest action) {
  return repo.rebuild((b) => b.updateValue(
        action.uid,
        (v) => v.rebuild(
              (b) => b.atMe.replace(
                    fetchListLoading(v.atMe),
                  ),
            ),
      ));
}

BuiltMap<int, UserData> _getMyAtsNew(
    BuiltMap<int, UserData> repo, GetMyAtsNewRequest action) {
  final updates = (b) => b.atMe.replace(StoryFetchList());
  return repo.rebuild((b) => b.updateValue(
      action.uid, (v) => v.rebuild(updates),
      ifAbsent: () => UserData().rebuild(updates)));
}

BuiltMap<int, UserData> _getMyAtsFailed(
    BuiltMap<int, UserData> repo, GetMyAtsFailure action) {
  int uid;

  final request = action.request as GetMyAtsRequest;
  if (request != null) {
    uid = request.uid;
  }

  var newRepo = repo;
  if (uid != null) {
    final data = newRepo[uid] ?? UserData();
    final value = data.rebuild(
        (b) => b.atMe.replace(fetchListFailed(data.atMe, action.error)));
    newRepo = newRepo.rebuild(
        (b) => b.updateValue(uid, (v) => value, ifAbsent: () => value));
  }

  return newRepo;
}

_getMyAtsSucceeded(FetchListRequestType type) =>
    (BuiltMap<int, UserData> repo, GetMyAtsSuccess action) {
      var request = action.request as GetMyAtsRequest;
      int uid = request.uid;
      var result = action.result;
      var newRepo = repo;
      final data = newRepo[uid] ?? UserData();
      final value = data.rebuild(
          (b) => b.atMe.replace(fetchListSucceeded(type, data.atMe, result)));

      newRepo = newRepo.rebuild(
          (b) => b.updateValue(uid, (v) => value, ifAbsent: () => value));

      return newRepo;
    };
