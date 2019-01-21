import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
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
  TypedReducer<BuiltMap<int, UserData>, GetMyDataRequest>(_dataRequested),
  TypedReducer<BuiltMap<int, UserData>, GetMyDataSuccess>(_dataSucceeded),
  TypedReducer<BuiltMap<int, UserData>, GetMyDataFailure>(_dataFailed),
]);

final _userDataReducer = combineReducers<UserData>([
  _favoriteReducer,
  _atMeReducer,
  _noticeReducer,
  _ratelogReducer,
  _pmReducer,
  _pmSessionMapReducer,
]);

BuiltMap<int, UserData> _handleDataActions(
    BuiltMap<int, UserData> state, int uid, action) {
  return state.rebuild((b) => b
    ..updateValue(uid, (v) => _userDataReducer(v, action),
        ifAbsent: () => _userDataReducer(UserData(), action)));
}

BuiltMap<int, UserData> _dataRequested(
    BuiltMap<int, UserData> state, GetMyDataRequest action) {
  final uid = action.uid;

  return _handleDataActions(state, uid, action);
}

BuiltMap<int, UserData> _dataSucceeded(
    BuiltMap<int, UserData> state, GetMyDataSuccess action) {
  final request = action.request as GetMyDataRequest;
  final uid = request.uid;
  return _handleDataActions(state, uid, action);
}

BuiltMap<int, UserData> _dataFailed(
    BuiltMap<int, UserData> state, GetMyDataFailure action) {
  final request = action.request as GetMyDataRequest;
  final uid = request.uid;
  return _handleDataActions(state, uid, action);
}

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

final builder = (UserData data, updates) => data.rebuild(updates);

final favoritesAccessor = (v) => v.favorites;
final _favoriteReducer = combineReducers<UserData>([
  TypedReducer<UserData, GetMyFavoritesNewRequest>(
      _getMyDataNew<UserData, GetMyFavoritesNewRequest, Story>(
          favoritesAccessor, builder)),
  TypedReducer<UserData, GetMyFavoritesRequest>(
      _getMyDataRequested<UserData, GetMyFavoritesRequest>(
          favoritesAccessor, builder)),
  TypedReducer<UserData, GetMyFavoritesFailure>(
      _getMyDataFailed<UserData, GetMyFavoritesFailure>(
          favoritesAccessor, builder)),
  TypedReducer<UserData, GetMyFavoritesNewSuccess>(
      _getMyDataSucceeded<UserData, GetMyFavoritesNewSuccess>(
          FetchListRequestType.New, favoritesAccessor, builder)),
  TypedReducer<UserData, GetMyFavoritesRefreshSuccess>(
      _getMyDataSucceeded<UserData, GetMyFavoritesRefreshSuccess>(
          FetchListRequestType.Refresh, favoritesAccessor, builder)),
  TypedReducer<UserData, GetMyFavoritesLoadMoreSuccess>(
      _getMyDataSucceeded<UserData, GetMyFavoritesLoadMoreSuccess>(
          FetchListRequestType.LoadMore, favoritesAccessor, builder)),
]);

final atMeAccessor = (v) => v.atMe;
final _atMeReducer = combineReducers<UserData>([
  TypedReducer<UserData, GetMyAtsNewRequest>(
      _getMyDataNew<UserData, GetMyAtsNewRequest, Story>(
          atMeAccessor, builder)),
  TypedReducer<UserData, GetMyAtsRequest>(
      _getMyDataRequested<UserData, GetMyAtsRequest>(atMeAccessor, builder)),
  TypedReducer<UserData, GetMyAtsFailure>(
      _getMyDataFailed<UserData, GetMyAtsFailure>(atMeAccessor, builder)),
  TypedReducer<UserData, GetMyAtsNewSuccess>(
      _getMyDataSucceeded<UserData, GetMyAtsNewSuccess>(
          FetchListRequestType.New, atMeAccessor, builder)),
  TypedReducer<UserData, GetMyAtsRefreshSuccess>(
      _getMyDataSucceeded<UserData, GetMyAtsRefreshSuccess>(
          FetchListRequestType.Refresh, atMeAccessor, builder)),
  TypedReducer<UserData, GetMyAtsLoadMoreSuccess>(
      _getMyDataSucceeded<UserData, GetMyAtsLoadMoreSuccess>(
          FetchListRequestType.LoadMore, atMeAccessor, builder)),
]);

final noticeAccessor = (v) => v.notice;
final _noticeReducer = combineReducers<UserData>([
  TypedReducer<UserData, GetNoticeNewRequest>(
      _getMyDataNew<UserData, GetNoticeNewRequest, Notice>(
          noticeAccessor, builder)),
  TypedReducer<UserData, GetNoticeRequest>(
      _getMyDataRequested<UserData, GetNoticeRequest>(noticeAccessor, builder)),
  TypedReducer<UserData, GetNoticeFailure>(
      _getMyDataFailed<UserData, GetNoticeFailure>(noticeAccessor, builder)),
  TypedReducer<UserData, GetNoticeNewSuccess>(
      _getMyDataSucceeded<UserData, GetNoticeNewSuccess>(
          FetchListRequestType.New, noticeAccessor, builder)),
  TypedReducer<UserData, GetNoticeRefreshSuccess>(
      _getMyDataSucceeded<UserData, GetNoticeRefreshSuccess>(
          FetchListRequestType.Refresh, noticeAccessor, builder)),
  TypedReducer<UserData, GetNoticeLoadMoreSuccess>(
      _getMyDataSucceeded<UserData, GetNoticeLoadMoreSuccess>(
          FetchListRequestType.LoadMore, noticeAccessor, builder)),
]);

final ratelogAccessor = (v) => v.ratelog;
final _ratelogReducer = combineReducers<UserData>([
  TypedReducer<UserData, GetRatelogNewRequest>(
      _getMyDataNew<UserData, GetRatelogNewRequest, Ratelog>(
          ratelogAccessor, builder)),
  TypedReducer<UserData, GetRatelogRequest>(
      _getMyDataRequested<UserData, GetRatelogRequest>(
          ratelogAccessor, builder)),
  TypedReducer<UserData, GetRatelogFailure>(
      _getMyDataFailed<UserData, GetRatelogFailure>(ratelogAccessor, builder)),
  TypedReducer<UserData, GetRatelogNewSuccess>(
      _getMyDataSucceeded<UserData, GetRatelogNewSuccess>(
          FetchListRequestType.New, ratelogAccessor, builder)),
  TypedReducer<UserData, GetRatelogRefreshSuccess>(
      _getMyDataSucceeded<UserData, GetRatelogRefreshSuccess>(
          FetchListRequestType.Refresh, ratelogAccessor, builder)),
  TypedReducer<UserData, GetRatelogLoadMoreSuccess>(
      _getMyDataSucceeded<UserData, GetRatelogLoadMoreSuccess>(
          FetchListRequestType.LoadMore, ratelogAccessor, builder)),
]);

final pmAccessor = (v) => v.pm;
final _pmReducer = combineReducers<UserData>([
  TypedReducer<UserData, GetPMNewRequest>(
      _getMyDataNew<UserData, GetPMNewRequest, PrivateMessage>(
          pmAccessor, builder)),
  TypedReducer<UserData, GetPMRequest>(
      _getMyDataRequested<UserData, GetPMRequest>(pmAccessor, builder)),
  TypedReducer<UserData, GetPMFailure>(
      _getMyDataFailed<UserData, GetPMFailure>(pmAccessor, builder)),
  TypedReducer<UserData, GetPMNewSuccess>(
      _getMyDataSucceeded<UserData, GetPMNewSuccess>(
          FetchListRequestType.New, pmAccessor, builder)),
  TypedReducer<UserData, GetPMRefreshSuccess>(
      _getMyDataSucceeded<UserData, GetPMRefreshSuccess>(
          FetchListRequestType.Refresh, pmAccessor, builder)),
  TypedReducer<UserData, GetPMLoadMoreSuccess>(
      _getMyDataSucceeded<UserData, GetPMLoadMoreSuccess>(
          FetchListRequestType.LoadMore, pmAccessor, builder)),
]);

_getMyDataRequested<D, T extends GetMyDataRequest>(
        Function accessor, D Function(D, dynamic) rebuild) =>
    (D repo, T action) {
      return rebuild(
        repo,
        (b) => accessor(b).replace(
              fetchListLoading(accessor(repo)),
            ),
      );
    };

_getMyDataNew<D, T extends GetMyDataRequest, S>(
        Function accessor, D Function(D, dynamic) rebuild) =>
    (D repo, T action) {
      final updates = (b) => accessor(b).replace(FetchList<S>());
      return rebuild(repo, updates);
    };

_getMyDataFailed<D, T extends GetMyDataFailure>(
        Function accessor, D Function(D, dynamic) rebuild) =>
    (D repo, T action) {
      return rebuild(
          repo,
          (b) => accessor(b)
              .replace(fetchListFailed(accessor(repo), action.error)));
    };

_getMyDataSucceeded<D, T extends GetMyDataSuccess>(FetchListRequestType type,
        Function accessor, D Function(D, dynamic) rebuild) =>
    (D repo, T action) {
      var result = action.result;
      return rebuild(
          repo,
          (b) => accessor(b)
              .replace(fetchListSucceeded(type, accessor(repo), result)));
    };

final _pmSessionMapReducer = combineReducers<UserData>([
  TypedReducer<UserData, GetPMSessionRequest>(_handlePMSessionMap),
  TypedReducer<UserData, GetPMSessionSuccess>(_handlePMSessionMap),
  TypedReducer<UserData, GetPMSessionFailure>(_handlePMSessionMap),
]);

final _pmSessionReducer =
    combineReducers<BuiltMap<int, FetchList<PrivateMessage>>>([
  TypedReducer<BuiltMap<int, FetchList<PrivateMessage>>, GetPMSessionRequest>(
      _pmSessionRequested),
  TypedReducer<BuiltMap<int, FetchList<PrivateMessage>>, GetPMSessionSuccess>(
      _pmSessionSucceeded),
  TypedReducer<BuiltMap<int, FetchList<PrivateMessage>>, GetPMSessionFailure>(
      _pmSessionFailed),
]);

UserData _handlePMSessionMap(UserData state, action) {
  return state.rebuild(
      (b) => b..pmSession.replace(_pmSessionReducer(state.pmSession, action)));
}

final _pmBuilder =
    (FetchList<PrivateMessage> list, updates) => list.rebuild(updates);
final selfAccessor = (v) => v;
final _sessionReducer = combineReducers<FetchList<PrivateMessage>>([
  TypedReducer<FetchList<PrivateMessage>, GetPMSessionNewRequest>(_getMyDataNew<
      FetchList<PrivateMessage>,
      GetPMSessionNewRequest,
      PrivateMessage>(selfAccessor, _pmBuilder)),
  TypedReducer<FetchList<PrivateMessage>, GetPMSessionRequest>(
      _getMyDataRequested<FetchList<PrivateMessage>, GetPMSessionRequest>(
          selfAccessor, _pmBuilder)),
  TypedReducer<FetchList<PrivateMessage>, GetPMSessionFailure>(
      _getMyDataFailed<FetchList<PrivateMessage>, GetPMSessionFailure>(
          selfAccessor, _pmBuilder)),
  TypedReducer<FetchList<PrivateMessage>, GetPMSessionNewSuccess>(
      _getMyDataSucceeded<FetchList<PrivateMessage>, GetPMSessionNewSuccess>(
          FetchListRequestType.New, selfAccessor, _pmBuilder)),
  TypedReducer<FetchList<PrivateMessage>, GetPMSessionRefreshSuccess>(
      _getMyDataSucceeded<FetchList<PrivateMessage>,
              GetPMSessionRefreshSuccess>(
          FetchListRequestType.Refresh, selfAccessor, _pmBuilder)),
  TypedReducer<FetchList<PrivateMessage>, GetPMSessionLoadMoreSuccess>(
      _getMyDataSucceeded<FetchList<PrivateMessage>,
              GetPMSessionLoadMoreSuccess>(
          FetchListRequestType.LoadMore, selfAccessor, _pmBuilder)),
]);

BuiltMap<int, FetchList<PrivateMessage>> _handlePMSessionActions(
    BuiltMap<int, FetchList<PrivateMessage>> state, int pmid, action) {
  return state.rebuild((b) => b
    ..updateValue(pmid, (v) => _sessionReducer(v, action),
        ifAbsent: () => FetchList<PrivateMessage>()));
}

BuiltMap<int, FetchList<PrivateMessage>> _pmSessionRequested(
    BuiltMap<int, FetchList<PrivateMessage>> state,
    GetPMSessionRequest action) {
  final pmid = action.pmid;

  return _handlePMSessionActions(state, pmid, action);
}

BuiltMap<int, FetchList<PrivateMessage>> _pmSessionSucceeded(
    BuiltMap<int, FetchList<PrivateMessage>> state,
    GetPMSessionSuccess action) {
  final request = action.request as GetPMSessionRequest;
  final pmid = request.pmid;
  return _handlePMSessionActions(state, pmid, action);
}

BuiltMap<int, FetchList<PrivateMessage>> _pmSessionFailed(
    BuiltMap<int, FetchList<PrivateMessage>> state,
    GetPMSessionFailure action) {
  final request = action.request as GetPMSessionRequest;
  final pmid = request.pmid;
  return _handlePMSessionActions(state, pmid, action);
}
