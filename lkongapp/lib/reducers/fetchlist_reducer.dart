import 'package:built_collection/built_collection.dart';
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

StoryFetchList fetchListNewCountChecked(StoryFetchList list, int result) {
  return list.rebuild((b) => b.newcount = result);
}

StoryFetchList fetchListLoading(StoryFetchList list) {
  return list.rebuild((b) => b..loading = true);
}

StoryFetchList fetchListFailed(StoryFetchList list, String error) {
  return list.rebuild((b) => b
    ..loading = false
    ..lastError = error);
}

StoryFetchList fetchListSucceeded(
    FetchListRequestType type, StoryFetchList list, StoryListResult result) {
  return list.rebuild((b) {
    var data = result.data;

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
            ..stories.replace(data);
          break;
        case FetchListRequestType.Refresh:
          var newsSet = data.map((story) => story.id).toSet();

          b
            ..newcount = 0
            ..stories.where((story) => !newsSet.contains(story.id))
            ..stories.insertAll(0, data);

          break;
        case FetchListRequestType.LoadMore:
          b..stories.addAll(data);
          break;
      }
    }
    return b;
  });
}
