import 'package:built_collection/built_collection.dart';
import 'package:lkongapp/models/lkong_jsons/story_result.dart';
import 'package:lkongapp/reducers/fetchlist_reducer.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

final profileReducer = combineReducers<BuiltMap<int, Profile>>([
  TypedReducer<BuiltMap<int, Profile>, UserInfoSuccess>(_userInfoSucceeded),
  TypedReducer<BuiltMap<int, Profile>, UserInfoFailure>(_userInfoFailed),
]);

BuiltMap<int, Profile> _userInfoSucceeded(
    BuiltMap<int, Profile> state, UserInfoSuccess action) {
  final request = action.request as UserInfoRequest;
  final user = request.user;

  final update = (b) => b..user.replace(action.userInfo);
  return state.rebuild((b) => b
    ..updateValue(user, (v) => v.rebuild(update),
        ifAbsent: () => Profile().rebuild(update)));
}

BuiltMap<int, Profile> _userInfoFailed(
    BuiltMap<int, Profile> state, UserInfoFailure action) {
  final request = action.request as UserInfoRequest;
  final user = request.user;
  final update = (b) => b..lastError.replace(action.error);
  return state.rebuild((b) => b
    ..updateValue(user, (v) => v.rebuild(update),
        ifAbsent: () => Profile().rebuild(update)));
}


