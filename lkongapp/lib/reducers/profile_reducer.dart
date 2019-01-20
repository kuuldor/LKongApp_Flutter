import 'package:built_collection/built_collection.dart';
import 'package:lkongapp/actions/profile_action.dart';
import 'package:lkongapp/models/lkong_jsons/search_result.dart';
import 'package:lkongapp/models/lkong_jsons/story_result.dart';
import 'package:lkongapp/reducers/fetchlist_reducer.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

final profileReducer = combineReducers<BuiltMap<int, Profile>>([
  TypedReducer<BuiltMap<int, Profile>, UserInfoSuccess>(_userInfoSucceeded),
  TypedReducer<BuiltMap<int, Profile>, UserInfoFailure>(_userInfoFailed),
  TypedReducer<BuiltMap<int, Profile>, ProfileRequest>(_profileRequested),
  TypedReducer<BuiltMap<int, Profile>, ProfileFailure>(_profileFailed),
  TypedReducer<BuiltMap<int, Profile>, ProfileNewSuccess>(
      _profileSucceeded(FetchListRequestType.New)),
  TypedReducer<BuiltMap<int, Profile>, ProfileLoadMoreSuccess>(
      _profileSucceeded(FetchListRequestType.LoadMore)),
]);

absentUpdate(int uid) =>
    (Function(ProfileBuilder) update) => (ProfileBuilder b) =>
        update(b)..user.replace(UserInfo().rebuild((b) => b..uid = uid));

BuiltMap<int, Profile> _userInfoSucceeded(
    BuiltMap<int, Profile> state, UserInfoSuccess action) {
  final request = action.request as UserInfoRequest;
  final user = request.user;

  final update = (b) => b
    ..loading = false
    ..lastError = null
    ..user.replace(action.userInfo);

  return state.rebuild((b) => b
    ..updateValue(user, (v) => v.rebuild(update),
        ifAbsent: () => Profile().rebuild(update)));
}

BuiltMap<int, Profile> _userInfoFailed(
    BuiltMap<int, Profile> state, UserInfoFailure action) {
  final request = action.request as UserInfoRequest;
  final user = request.user;
  final update = (b) => b
    ..lastError = action.error
    ..loading = false;

  return state.rebuild((b) => b
    ..updateValue(user, (v) => v.rebuild(update),
        ifAbsent: () => Profile().rebuild(absentUpdate(user)(update))));
}

BuiltMap<int, Profile> _profileRequested(
    BuiltMap<int, Profile> state, ProfileRequest action) {
  final user = action.uid;
  final Function(ProfileBuilder) update = (b) => b..loading = true;

  return state.rebuild((b) => b
    ..updateValue(user, (v) => v.rebuild(update),
        ifAbsent: () => Profile().rebuild(absentUpdate(user)(update))));
}

BuiltMap<int, Profile> _profileFailed(
    BuiltMap<int, Profile> state, ProfileFailure action) {
  final request = action.request as ProfileRequest;
  final user = request.uid;
  final update = (b) => b
    ..lastError = action.error
    ..loading = false;

  return state.rebuild((b) => b
    ..updateValue(user, (v) => v.rebuild(update),
        ifAbsent: () => Profile().rebuild(absentUpdate(user)(update))));
}

BuiltMap<int, Profile> Function(
    BuiltMap<int, Profile> state, ProfileSuccess action) _profileSucceeded(
        FetchListRequestType type) =>
    (BuiltMap<int, Profile> state, action) {
      final request = action.request as ProfileRequest;
      final user = request.uid;

      final profile = state[user] ?? Profile();

      final update = (ProfileBuilder b) {
        b
          ..loading = false
          ..lastError = null;

        switch (request.fetchType) {
          case 0:
            final result = action.result as StoryListResult;
            final newList = fetchListSucceeded(
                type, profile.stories ?? FetchList<Story>(), result);
            b..stories.replace(newList);
            break;
          case 1:
            final result = action.result as SearchUserResult;
            final newList = fetchUserSucceeded(
                type, profile.fans ?? SearchUserResult(), result);
            b..fans.replace(newList);
            break;
          case 2:
            final result = action.result as SearchUserResult;
            final newList = fetchUserSucceeded(
                type, profile.follows ?? SearchUserResult(), result);
            b..follows.replace(newList);
            break;
          case 3:
            final result = action.result as StoryListResult;
            final newList = fetchListSucceeded(
                type, profile.digests ?? FetchList<Story>(), result);
            b..digests.replace(newList);
            break;
          case 4:
            final result = action.result as StoryListResult;
            final newList = fetchListSucceeded(
                type, profile.allPosts ?? FetchList<Story>(), result);
            b..allPosts.replace(newList);
            break;
        }
        return b;
      };

      return state.rebuild((b) => b
        ..updateValue(user, (v) => v.rebuild(update),
            ifAbsent: () => profile.rebuild(absentUpdate(user)(update))));
    };
