import 'package:built_collection/built_collection.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/models/lkong_jsons/story_result.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

enum FetchListRequestType {
  New,
  Refresh,
  LoadMore,
}

FetchList<T> fetchListNewCountChecked<T extends Identifiable>(
    FetchList<T> list, int result) {
  return list.rebuild((b) => b.newcount = result);
}

FetchList<T> fetchListLoading<T extends Identifiable>(FetchList<T> list) {
  return list.rebuild((b) => b..loading = true);
}

FetchList<T> fetchListFailed<T extends Identifiable>(
    FetchList<T> list, String error) {
  return list.rebuild((b) => b
    ..loading = false
    ..lastError = error);
}

FetchList<T> fetchListSucceeded<T extends Identifiable>(
    FetchListRequestType type, FetchList<T> list, FetchResult<T> result) {
  return list.rebuild((b) {
    var data = result.data;
    if (result.curtime == null && result.nexttime == null && data.length == 0) {
      return b;
    }

    int nexttime = type != FetchListRequestType.Refresh
        ? (data != null && data.length > 0 ? result.nexttime : 0)
        : b.nexttime;
    int current =
        type != FetchListRequestType.LoadMore ? result.curtime : b.current;

    b
      ..loading = false
      ..lastError = null
      ..nexttime = (nexttime ?? 0)
      ..current = (current ?? 0);

    if (data != null && data.length > 0) {
      switch (type) {
        case FetchListRequestType.New:
          b
            ..newcount = 0
            ..data.replace(data);
          break;
        case FetchListRequestType.Refresh:
          if (data.length >= 20) {
            b
              ..newcount = 0
              ..data.replace(data);
          } else {
            var newsSet = data.map((story) => story.id).toSet();

            b
              ..newcount = 0
              ..data.where((story) => !newsSet.contains(story.id))
              ..data.insertAll(0, data);
          }
          break;
        case FetchListRequestType.LoadMore:
          b..data.addAll(data);
          break;
      }
    }
    return b;
  });
}

SearchUserResult fetchUserSucceeded(
    FetchListRequestType type, SearchUserResult list, SearchUserResult result) {
  return list.rebuild((SearchUserResultBuilder b) {
    var data = result.user;
    int nexttime = type != FetchListRequestType.Refresh
        ? (data != null && data.length > 0 ? result.nexttime : 0)
        : b.nexttime;
    int current =
        type != FetchListRequestType.LoadMore ? result.curtime : b.curtime;

    b
      ..nexttime = (nexttime ?? 0)
      ..curtime = (current ?? 0);

    switch (type) {
      case FetchListRequestType.New:
        b..user.replace(data);
        break;

      case FetchListRequestType.LoadMore:
        b..user.addAll(data ?? []);
        break;
      default:
        break;
    }
    return b;
  });
}
