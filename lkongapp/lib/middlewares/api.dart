import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

const LOGIN_API = "LOGIN";
const HOMELIST_API = "HOMELIST";
const STORY_CONTENT_API = "STORY_CONTENT";
const STORY_INFO_API = "STORY_INFO";
const FORUMLIST_API = "FORUMLIST";
const FORUMTHREADS_API = "FORUMTHREADS";

const baseURL = 'http://lkong.cn';

const endpoint = {
  "login": "/index.php?mod=login",
  "logout": "/forum/index.php?mod=ajax&action=logout",
  "userInfo": "/index.php?mod=ajax&action=userconfig",
  "threadInfo": "/index.php?mod=ajax&action=threadconfig",
  "stories": "/index.php?mod=data&sars=index/",
  "userStories": "/index.php?mod=data&sars=user/",
  "forumList": "/index.php?mod=ajax&action=forumlist",
  "forumInfo": "/index.php?mod=ajax&action=forumconfig",
  "square": "/index.php?mod=ajax&action=square",
  "forumStories": "/index.php?mod=data&sars=forum/",
  "comments": "/index.php?mod=data&sars=thread/",
  "punchCard": "/index.php?mod=ajax&action=punch",
  "reply": "/post/index.php?mod=post",
  "query": "/index.php?mod=ajax&action=panelocation",
  "follow": "/index.php?mod=follow",
  "message": "/index.php?mod=ajax&action=submitbox",
  "atMe": "/index.php?mod=data&sars=my/",
  "pmSession": "/index.php?mod=data&sars=pm/",
  "checkNew": "/index.php?mod=ajax&action=langloop",
  "upvote": "/index.php?mod=ajax&action=submitbox",
  "search": "/index.php?mod=data&sars=search/",
  "getBlacklist": "/index.php?mod=ajax&action=getblack",
};

Future<Map> login(Map parameters) {
  User user = userParam(parameters);
  String url = baseURL + endpoint["login"];

  return http.post(url, body: {
    "action": "login",
    "email": user.identity,
    "password": user.password,
    "rememberme": "on"
  }).then((response) {
    Map result = {};

    if (response.statusCode >= 400) {
      result = {"error": "HTTP错误: ${response.statusCode}"};
    } else {
      result = json.decode(response.body);
      if (result == null) {
        result = {"error": 'API没有返回信息'};
      }
    }
    return result;
  }).catchError((error) => {"error": error.toString()});
}

User userParam(Map parameters) {
  User user = parameters["user"];
  return user;
}

Future<Map> apiDispatch(api, parameters) {
  if (api == LOGIN_API) {
    return login(parameters);
  }

  // if (api.startsWith(HOMELIST_API)) {
  //   return getHomeList(parameters);
  // }

  // if (api == STORY_CONTENT_API) {
  //   return contentsForStory(parameters);
  // }

  // if (api == STORY_INFO_API) {
  //   return getStoryInfo(parameters);
  // }

  // if (api == FORUMLIST_API) {
  //   return getForumList(parameters);
  // }

  // if (api.startsWith(FORUMTHREADS_API)) {
  //   return getStoriesForForum(parameters);
  // }

  return Future<Map>(null);
}

APIResponse createResponseAction(APIRequest action, Map response) {
  APIResponse result = APIResponse();

  String api = action.api;
  String error = response["error"];

  switch (api) {
    case LOGIN_API:
      User user = userParam(action.parameters);
      result = error == null
          ? LoginSuccess(user.rebuild((b) => b..uid = response["uid"]))
          : LoginFailure(error);
      break;
    default:
      break;
  }
  return result;
}

void callAPI(Store<AppState> store, APIRequest action, NextDispatcher next) {
  next(action);
  store.dispatch((store) {
    apiDispatch(action.api, action.parameters).then((map) {
      APIResponse response = createResponseAction(action, map);
      store.dispatch(response);

      action.completer.complete(response is APISuccess);
    });
  });
}
