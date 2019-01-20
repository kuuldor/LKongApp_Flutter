import 'package:built_collection/built_collection.dart';
import 'package:lkongapp/models/lkong_jsons/story_result.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/models/models.dart';

import 'fetchlist_reducer.dart';

final storyContentsReducer = combineReducers<BuiltMap<int, StoryPageList>>([
  TypedReducer<BuiltMap<int, StoryPageList>, StoryContentRequest>(
      _storyContentRequested),
  TypedReducer<BuiltMap<int, StoryPageList>, StoryContentSuccess>(
      _storyContentSucceeded),
  TypedReducer<BuiltMap<int, StoryPageList>, ReplySuccess>(
      _storyReplySucceeded),
  TypedReducer<BuiltMap<int, StoryPageList>, StoryInfoRequest>(
      _storyInfoRequested),
  TypedReducer<BuiltMap<int, StoryPageList>, StoryInfoSuccess>(
      _storyInfoSucceeded),
  TypedReducer<BuiltMap<int, StoryPageList>, StoryContentFailure>(
      _storyContentFailed),
  TypedReducer<BuiltMap<int, StoryPageList>, StoryInfoFailure>(
      _storyInfoFailed),
  TypedReducer<BuiltMap<int, StoryPageList>, UpvoteSuccess>(_upvoteSucceeded),
]);

BuiltMap<int, StoryPageList> _storyInfoRequested(
    BuiltMap<int, StoryPageList> storyRepo, StoryInfoRequest action) {
  var newRepo = storyRepo;

  if (action.story != null) {
    int threadId = action.story;
    newRepo = _buildStoryPages(newRepo, threadId, forceNew: true).rebuild((b) =>
        b.updateValue(threadId, (v) => v.rebuild((b) => b..loading = true)));
  }
  return newRepo;
}

BuiltMap<int, StoryPageList> _storyInfoSucceeded(
    BuiltMap<int, StoryPageList> storyRepo, StoryInfoSuccess action) {
  var newRepo = storyRepo;
  final result = action.result;

  if (result is StoryInfoResult) {
    int threadId = result.tid;

    newRepo = newRepo.rebuild((b) => b
      ..updateValue(
          threadId,
          (v) => v.rebuild((b) => b
            ..loading = false
            ..lastError = null
            ..storyInfo.replace(result))));
  }
  return newRepo;
}

BuiltMap<int, StoryPageList> _storyInfoFailed(
    BuiltMap<int, StoryPageList> storyRepo, StoryInfoFailure action) {
  int threadId;
  final request = action.request as StoryInfoRequest;
  if (request != null) {
    threadId = request.story;
  }
  return _storyRequestFailed(storyRepo, threadId, action);
}

BuiltMap<int, StoryPageList> _storyContentFailed(
    BuiltMap<int, StoryPageList> storyRepo, StoryContentFailure action) {
  int threadId;
  final request = action.request as StoryContentRequest;
  if (request != null) {
    threadId = request.story;
  }
  return _storyRequestFailed(storyRepo, threadId, action);
}

BuiltMap<int, StoryPageList> _storyRequestFailed(
    BuiltMap<int, StoryPageList> storyRepo, int threadId, APIFailure action) {
  var newRepo = storyRepo;
  if (threadId != null) {
    newRepo = newRepo.rebuild((b) => b
      ..updateValue(
          threadId,
          (v) => v.rebuild((b) => b
            ..loading = false
            ..lastError = action.error)));
  }
  return newRepo;
}

BuiltMap<int, StoryPageList> _buildStoryPages(
    BuiltMap<int, StoryPageList> newRepo, int threadId,
    {bool forceNew: false}) {
  StoryPageList storyContents = newRepo[threadId];
  if (forceNew || storyContents == null) {
    newRepo = newRepo
        .rebuild((b) => b..addEntries([MapEntry(threadId, StoryPageList())]));
    storyContents = newRepo[threadId];
  }
  return newRepo;
}

BuiltMap<int, StoryPageList> _storyContentRequested(
    BuiltMap<int, StoryPageList> storyRepo, StoryContentRequest action) {
  var newRepo = storyRepo;

  if (action.story != null) {
    int threadId = action.story;
    newRepo = _buildStoryPages(newRepo, threadId);

    StoryPageList storyContents = newRepo[threadId];
    StoryPage page = StoryPage();
    if (storyContents.pages[action.page] == null) {
      newRepo = newRepo.rebuild((b) => b.updateValue(
          threadId,
          (v) => v.rebuild((b) => b
            ..loading = true
            ..pages.addEntries([MapEntry(action.page, page)]))));
    }
  }
  return newRepo;
}

BuiltMap<int, StoryPageList> _storyReplySucceeded(
    BuiltMap<int, StoryPageList> storyRepo, ReplySuccess action) {
  var newRepo = storyRepo;
  final result = action.result;
  final ReplyRequest request = action.request;

  final message = result["mess"];

  var story = request.story;

  final replyType = request.replyType;

  if (story != null) {
    int page;
    StoryPage storyPage;

    int threadId = story.tid;
    if (replyType == ReplyType.EditComment ||
        replyType == ReplyType.EditStory) {
      var comment = request.comment;
      page = (comment.lou - 1) ~/ 20 + 1;

      storyPage = newRepo[threadId].pages[page];
      if (storyPage != null) {
        int index = storyPage.comments.indexOf(comment);
        storyPage = storyPage.rebuild((b) => b
          ..comments.replaceRange(index, index + 1,
              [comment.rebuild((b) => b..message = message)]));
      }
    }

    if (replyType == ReplyType.Comment || replyType == ReplyType.Story) {
      int lou = result["lou"];
      page = result["page"];
      int pid = result["pid"];
      int tid = result["tid"];
      storyPage = newRepo[threadId].pages[page];
      if (storyPage != null) {
        storyPage = storyPage.rebuild((b) => b
          ..comments.add(Comment().rebuild((b) => b
            ..id = pid
            ..warning = false
            ..warningReason = ""
            ..message = request.content
            ..fid = story.fid
            ..author = request.author
            ..authorid = request.authorId
            ..dateline = request.dateline
            ..pid = pid
            ..tid = tid
            ..lou = lou)));
      }
    }

    if (page != null && storyPage != null) {
      var updater = (b) => b
        ..loading = false
        ..lastError = null
        ..pages.updateValue(page, (v) => storyPage);
      newRepo = newRepo.rebuild(
        (b) => b
          ..updateValue(
            threadId,
            (v) => v.rebuild(updater),
            ifAbsent: () => StoryPageList().rebuild(updater),
          ),
      );
    }
  }
  return newRepo;
}

BuiltMap<int, StoryPageList> _storyContentSucceeded(
    BuiltMap<int, StoryPageList> storyRepo, StoryContentSuccess action) {
  var newRepo = storyRepo;
  final result = action.result;
  int threadId = parseLKTypeId(result.model);

  if (threadId != null) {
    StoryPage page =
        StoryPage().rebuild((b) => b..comments.replace(result.comments));
    var updater = (b) => b
      ..loading = false
      ..lastError = null
      ..pages.updateValue(result.page, (v) => page);
    newRepo = newRepo.rebuild(
      (b) => b
        ..updateValue(
          threadId,
          (v) => v.rebuild(updater),
          ifAbsent: () => StoryPageList().rebuild(updater),
        ),
    );
  }
  return newRepo;
}

final homeListReducer = combineReducers<FetchList<Story>>([
  TypedReducer<FetchList<Story>, HomeListRequest>(_homeListLoading),
  TypedReducer<FetchList<Story>, HomeListFailure>(_homeListFailed),
  TypedReducer<FetchList<Story>, HomeListCheckNewFailure>(_homeListFailed),
  TypedReducer<FetchList<Story>, HomeListNewSuccess>(
      _homeListSucceeded(FetchListRequestType.New)),
  TypedReducer<FetchList<Story>, HomeListRefreshSuccess>(
      _homeListSucceeded(FetchListRequestType.Refresh)),
  TypedReducer<FetchList<Story>, HomeListLoadMoreSuccess>(
      _homeListSucceeded(FetchListRequestType.LoadMore)),
  TypedReducer<FetchList<Story>, HomeListCheckNewSuccess>(
      _homeListNewCountChecked),
]);

FetchList<Story> _homeListNewCountChecked(
    FetchList<Story> list, HomeListCheckNewSuccess action) {
  var result = action.result;

  return fetchListNewCountChecked(list, result);
}

FetchList<Story> _homeListLoading(FetchList<Story> list, HomeListRequest action) {
  return fetchListLoading(list);
}

FetchList<Story> _homeListFailed(FetchList<Story> list, APIFailure action) {
  return fetchListFailed(list, action.error);
}

_homeListSucceeded(FetchListRequestType type) =>
    (FetchList<Story> list, HomeListSuccess action) =>
        fetchListSucceeded(type, list, action.list);

BuiltMap<int, StoryPageList> _upvoteSucceeded(
    BuiltMap<int, StoryPageList> storyRepo, UpvoteSuccess action) {
  var newRepo = storyRepo;
  final result = action.result;
  final UpvoteRequest request = action.request;

  final comment = request.voted;
  final story = request.story;

  if (comment != null) {
    int page;
    StoryPage storyPage;

    int threadId = story.tid;

    page = (comment.lou - 1) ~/ 20 + 1;

    storyPage = newRepo[threadId].pages[page];
    if (storyPage != null) {
      int index = storyPage.comments.indexOf(comment);
      storyPage = storyPage.rebuild((b) => b
        ..comments.replaceRange(index, index + 1, [
          comment.rebuild((b) => b..ratelog.insertAll(0, [result.ratelog]))
        ]));

      var updater = (b) => b
        ..loading = false
        ..lastError = null
        ..pages.updateValue(page, (v) => storyPage);
      newRepo = newRepo.rebuild(
        (b) => b
          ..updateValue(
            threadId,
            (v) => v.rebuild(updater),
            ifAbsent: () => StoryPageList().rebuild(updater),
          ),
      );
    }
  }
  return newRepo;
}
