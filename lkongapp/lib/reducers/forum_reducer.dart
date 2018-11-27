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
