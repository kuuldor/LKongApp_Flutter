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
