import 'package:built_collection/built_collection.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
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
  _noticeReducer,
  _ratelogReducer,
  _pmReducer,
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

final favoritesAccessor = (v) => v.favorites;
final _favoriteReducer = combineReducers<BuiltMap<int, UserData>>([
  TypedReducer<BuiltMap<int, UserData>, GetMyFavoritesNewRequest>(
      _getMyDataNew<GetMyFavoritesNewRequest, Story>(favoritesAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetMyFavoritesRequest>(
      _getMyDataRequested<GetMyFavoritesRequest>(favoritesAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetMyFavoritesFailure>(
      _getMyDataFailed<GetMyFavoritesFailure>(favoritesAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetMyFavoritesNewSuccess>(
      _getMyDataSucceeded<GetMyFavoritesNewSuccess>(
          FetchListRequestType.New, favoritesAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetMyFavoritesRefreshSuccess>(
      _getMyDataSucceeded<GetMyFavoritesRefreshSuccess>(
          FetchListRequestType.Refresh, favoritesAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetMyFavoritesLoadMoreSuccess>(
      _getMyDataSucceeded<GetMyFavoritesLoadMoreSuccess>(
          FetchListRequestType.LoadMore, favoritesAccessor)),
]);

final atMeAccessor = (v) => v.atMe;
final _atMeReducer = combineReducers<BuiltMap<int, UserData>>([
  TypedReducer<BuiltMap<int, UserData>, GetMyAtsNewRequest>(
      _getMyDataNew<GetMyAtsNewRequest, Story>(atMeAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetMyAtsRequest>(
      _getMyDataRequested<GetMyAtsRequest>(atMeAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetMyAtsFailure>(
      _getMyDataFailed<GetMyAtsFailure>(atMeAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetMyAtsNewSuccess>(
      _getMyDataSucceeded<GetMyAtsNewSuccess>(
          FetchListRequestType.New, atMeAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetMyAtsRefreshSuccess>(
      _getMyDataSucceeded<GetMyAtsRefreshSuccess>(
          FetchListRequestType.Refresh, atMeAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetMyAtsLoadMoreSuccess>(
      _getMyDataSucceeded<GetMyAtsLoadMoreSuccess>(
          FetchListRequestType.LoadMore, atMeAccessor)),
]);

final noticeAccessor = (v) => v.notice;
final _noticeReducer = combineReducers<BuiltMap<int, UserData>>([
  TypedReducer<BuiltMap<int, UserData>, GetNoticeNewRequest>(
      _getMyDataNew<GetNoticeNewRequest, Notice>(noticeAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetNoticeRequest>(
      _getMyDataRequested<GetNoticeRequest>(noticeAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetNoticeFailure>(
      _getMyDataFailed<GetNoticeFailure>(noticeAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetNoticeNewSuccess>(
      _getMyDataSucceeded<GetNoticeNewSuccess>(
          FetchListRequestType.New, noticeAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetNoticeRefreshSuccess>(
      _getMyDataSucceeded<GetNoticeRefreshSuccess>(
          FetchListRequestType.Refresh, noticeAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetNoticeLoadMoreSuccess>(
      _getMyDataSucceeded<GetNoticeLoadMoreSuccess>(
          FetchListRequestType.LoadMore, noticeAccessor)),
]);

final ratelogAccessor = (v) => v.ratelog;
final _ratelogReducer = combineReducers<BuiltMap<int, UserData>>([
  TypedReducer<BuiltMap<int, UserData>, GetRatelogNewRequest>(
      _getMyDataNew<GetRatelogNewRequest, Ratelog>(ratelogAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetRatelogRequest>(
      _getMyDataRequested<GetRatelogRequest>(ratelogAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetRatelogFailure>(
      _getMyDataFailed<GetRatelogFailure>(ratelogAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetRatelogNewSuccess>(
      _getMyDataSucceeded<GetRatelogNewSuccess>(
          FetchListRequestType.New, ratelogAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetRatelogRefreshSuccess>(
      _getMyDataSucceeded<GetRatelogRefreshSuccess>(
          FetchListRequestType.Refresh, ratelogAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetRatelogLoadMoreSuccess>(
      _getMyDataSucceeded<GetRatelogLoadMoreSuccess>(
          FetchListRequestType.LoadMore, ratelogAccessor)),
]);

final pmAccessor = (v) => v.pm;
final _pmReducer = combineReducers<BuiltMap<int, UserData>>([
  TypedReducer<BuiltMap<int, UserData>, GetPMNewRequest>(
      _getMyDataNew<GetPMNewRequest, PrivateMessage>(pmAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetPMRequest>(
      _getMyDataRequested<GetPMRequest>(pmAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetPMFailure>(
      _getMyDataFailed<GetPMFailure>(pmAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetPMNewSuccess>(
      _getMyDataSucceeded<GetPMNewSuccess>(
          FetchListRequestType.New, pmAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetPMRefreshSuccess>(
      _getMyDataSucceeded<GetPMRefreshSuccess>(
          FetchListRequestType.Refresh, pmAccessor)),
  TypedReducer<BuiltMap<int, UserData>, GetPMLoadMoreSuccess>(
      _getMyDataSucceeded<GetPMLoadMoreSuccess>(
          FetchListRequestType.LoadMore, pmAccessor)),
]);

_getMyDataRequested<T extends GetMyDataRequest>(Function accessor) =>
    (BuiltMap<int, UserData> repo, T action) {
      return repo.rebuild((b) => b.updateValue(
            action.uid,
            (v) => v.rebuild(
                  (b) => accessor(b).replace(
                        fetchListLoading(accessor(v)),
                      ),
                ),
          ));
    };

_getMyDataNew<T extends GetMyDataRequest, S>(Function accessor) =>
    (BuiltMap<int, UserData> repo, T action) {
      final updates = (b) => accessor(b).replace(FetchList<S>());
      return repo.rebuild((b) => b.updateValue(
          action.uid, (v) => v.rebuild(updates),
          ifAbsent: () => UserData().rebuild(updates)));
    };

_getMyDataFailed<T extends GetMyDataFailure>(Function accessor) =>
    (BuiltMap<int, UserData> repo, T action) {
      int uid;

      final request = action.request as GetMyDataRequest;
      if (request != null) {
        uid = request.uid;
      }

      var newRepo = repo;
      if (uid != null) {
        final data = newRepo[uid] ?? UserData();
        final value = data.rebuild((b) =>
            accessor(b).replace(fetchListFailed(accessor(data), action.error)));
        newRepo = newRepo.rebuild(
            (b) => b.updateValue(uid, (v) => value, ifAbsent: () => value));
      }

      return newRepo;
    };

_getMyDataSucceeded<T extends GetMyDataSuccess>(
        FetchListRequestType type, Function accessor) =>
    (BuiltMap<int, UserData> repo, T action) {
      var request = action.request as GetMyDataRequest;
      int uid = request.uid;
      var result = action.result;
      var newRepo = repo;
      final data = newRepo[uid] ?? UserData();
      final value = data.rebuild((b) => accessor(b)
          .replace(fetchListSucceeded(type, accessor(data), result)));

      newRepo = newRepo.rebuild(
          (b) => b.updateValue(uid, (v) => value, ifAbsent: () => value));

      return newRepo;
    };
