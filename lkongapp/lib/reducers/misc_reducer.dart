import 'package:built_collection/built_collection.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/models/lkong_jsons/story_result.dart';
import 'package:lkongapp/reducers/fetchlist_reducer.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

final hotDigestReducer = combineReducers<BuiltList<HotDigestResult>>([
  TypedReducer<BuiltList<HotDigestResult>, HotDigestSuccess>(
      _hotDigestSucceeded),
]);

BuiltList<HotDigestResult> _hotDigestSucceeded(
    BuiltList<HotDigestResult> hotDigest, HotDigestSuccess action) {
  var list = action.list;
  var newRepo = hotDigest;
  if (list != null) {
    newRepo = newRepo.rebuild((b) => b..replace(list));
  }

  return newRepo;
}

final blacklistReducer = combineReducers<BuiltList<UserInfo>>([
  TypedReducer<BuiltList<UserInfo>, GetBlacklistSuccess>(
      _getBlackListSucceeded),
  TypedReducer<BuiltList<UserInfo>, FollowSuccess>(_editBlackListSucceeded),
]);

BuiltList<UserInfo> _getBlackListSucceeded(
    BuiltList<UserInfo> blacklist, GetBlacklistSuccess action) {
  var list = action.list;
  var newRepo = blacklist;
  if (list != null) {
    newRepo = newRepo.rebuild((b) => b..replace(list));
  }

  return newRepo;
}

BuiltList<UserInfo> _editBlackListSucceeded(
    BuiltList<UserInfo> blacklist, FollowSuccess action) {
  var request = action.request as FollowRequest;
  var newRepo = blacklist;
  if (request.replyType == FollowType.black) {
    if (request.unfollow == true) {
      newRepo =
          newRepo.rebuild((b) => b..where((user) => user.uid != request.id));
    } else {
      final user = UserInfo().rebuild((b) => b
        ..uid = request.id
        ..username = request.name);
      newRepo = newRepo.rebuild((b) => b..add(user));
    }
  }

  return newRepo;
}
