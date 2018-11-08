import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

final homeListReducer = combineReducers<HomeList>([
  TypedReducer<HomeList, HomeListRequest>(_homeListLoading),
  TypedReducer<HomeList, HomeListNewSuccess>(
      _homeListSucceeded(HomeListRequestType.New)),
  TypedReducer<HomeList, HomeListNewFailure>(
      _homeListFailed(HomeListRequestType.New)),
  TypedReducer<HomeList, HomeListRefreshSuccess>(
      _homeListSucceeded(HomeListRequestType.Refresh)),
  TypedReducer<HomeList, HomeListRefreshFailure>(
      _homeListFailed(HomeListRequestType.Refresh)),
  TypedReducer<HomeList, HomeListLoadMoreSuccess>(
      _homeListSucceeded(HomeListRequestType.LoadMore)),
  TypedReducer<HomeList, HomeListLoadMoreFailure>(
      _homeListFailed(HomeListRequestType.LoadMore)),
]);

enum HomeListRequestType {
  New,
  Refresh,
  LoadMore,
}

_homeListSucceeded(HomeListRequestType type) =>
    (HomeList list, HomeListSuccess action) {
      return list.rebuild((b) {
        b..loading = false;
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

_homeListFailed(HomeListRequestType type) => (HomeList list, action) {
      return list.rebuild((b) => b..loading = false);
    };

HomeList _homeListLoading(HomeList list, action) {
  return list.rebuild((b) => b..loading = true);
}
