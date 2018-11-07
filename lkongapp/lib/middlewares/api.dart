import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:built_value/built_value.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
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

Future<Map> _handleHttp(
  Future<http.Response> httpAction, {
  @required Map bodyParser(String body),
  String preProcessor(String body),
}) {
  return httpAction.then((response) {
    Map result = {};

    if (response.statusCode >= 400) {
      result = {"error": "HTTP错误: ${response.statusCode}"};
    } else {
      var body;
      if (preProcessor != null) {
        body = preProcessor(response.body);
      } else {
        body = response.body;
      }
      result = bodyParser(body);
      if (result == null) {
        result = {"error": 'API没有返回信息'};
      }
    }
    return result;
  }).catchError((error) => {"error": error.toString()});
}

Future<Map> login(Map args) {
  User user = userParam(args);
  String url = baseURL + endpoint["login"];
  var httpAction = http.post(url, body: {
    "action": "login",
    "email": user.identity,
    "password": user.password,
    "rememberme": "on"
  });
  return _handleHttp(httpAction, bodyParser: (body) => json.decode(body));
}

User userParam(Map args) {
  User user = args["user"];
  return user;
}

int timeStamp = DateTime.now().millisecondsSinceEpoch;

Map defaultParameter() {
  var param = new Map();
  param['_'] = timeStamp++;
  return param;
}

Map getTimeParameter(nexttime, current) {
  var param = defaultParameter();

  if (nexttime != 0) {
    param['nexttime'] = nexttime;
  } else if (current != 0) {
    param['curtime'] = current;
  }

  return param;
}

String querify(Map parameters) {
  var param = '';
  parameters.forEach((key, value) {
    param += '&' + key.toString() + '=' + value.toString();
  });
  return param;
}

Future<Map> fetchStories<T>(url, parameters, T fromJson(String json),
    [void proccessor(T t)]) {
  var urlString = url + querify(parameters);

  print("Fetching Stories: URL is $urlString");

  var httpAction = http.get(urlString);
  return _handleHttp(httpAction, bodyParser: (body) {
    Map result;
    print(body);
    T stories = fromJson(body);
    if (stories != null) {
      if (proccessor != null) {
        proccessor(stories);
      }
      result = {"result": stories};
    }
    return result;
  }, preProcessor: numMapperBuiler(["uid"]));
}

Future<Map> getStoriesForForum(Map args) {
  int nexttime = args["nexttime"] ?? 0;
  int current = args["current"] ?? 0;
  int mode = args["mode"] ?? 0;
  int forumId = args["forumId"];

  var modeString = "";
  var reverse = false;
  if (mode == 1) {
    modeString = "/digest";
  } else if (mode == 2) {
    modeString = "/thread_dateline";
    reverse = true;
  }

  var urlString = baseURL + endpoint["forumStories"] + "$forumId" + modeString;
  print("getHomeList: URL is $urlString");
  var params = getTimeParameter(nexttime, current);

  return fetchStories<ForumStoryResult>(
      urlString, params, ForumStoryResult.fromJson, (stories) {
    if (reverse) {
      stories.rebuild((b) => b..data.replace(stories.data.reversed));
    }
  });
}

Future<Map> getHomeList(Map args) {
  int nexttime = args["nexttime"] ?? 0;
  int current = args["current"] ?? 0;
  bool threadOnly = args["threadOnly"] ?? false;

  var urlString = baseURL + endpoint["stories"] + (threadOnly ? 'thread' : '');
  print("getHomeList: URL is $urlString");
  var params = getTimeParameter(nexttime, current);

  return fetchStories<HomeListResult>(
      urlString, params, HomeListResult.fromJson, (stories) {
    stories.rebuild((b) => b..data.replace(stories.data.reversed));
  });
}

_parseResponseBody<T>(T fromJson(String json)) => (String body) {
      Map result;
      print(body);
      T forums = fromJson(body);
      if (forums != null) {
        result = {"result": forums};
      }
      return result;
    };

Future<Map> contentsForStory(Map args) {
  int story = args["story"];
  int page = args["page"];

  assert(story != null, "Story must be defined");
  assert(page != null, "Page must be defined");

  var urlString = baseURL +
      endpoint["comments"] +
      "$story/$page" +
      querify(defaultParameter());

  print("contentsForStory: URL is $urlString");

  var httpAction = http.get(urlString);
  return _handleHttp(httpAction, bodyParser: (body) => json.decode(body));
}

Future<Map> getStoryInfo(Map args) {
  int story = args["story"];

  assert(story != null, "Story must be defined");

  var urlString = baseURL +
      endpoint["threadInfo"] +
      "_$story" +
      querify(defaultParameter());

  print("getStoryInfo: URL is $urlString");

  var httpAction = http.get(urlString);
  return _handleHttp(httpAction,
      bodyParser: _parseResponseBody(StoryInfoResult.fromJson));
}

Future<Map> getForumList() {
  var urlString = baseURL + endpoint["forumList"] + querify(defaultParameter());

  print("getForumList: URL is $urlString");

  var httpAction = http.get(urlString);
  return _handleHttp(httpAction,
      bodyParser: _parseResponseBody(ForumListResult.fromJson));
}

Future<Map> getForumInfo(Map args) {
  int forumId = args["id"];

  assert(forumId != null, "forumId must be defined");

  var urlString = baseURL + endpoint["forumInfo"] + "_$forumId";

  print("getForumInfo: URL is $urlString");

  var httpAction = http.get(urlString);
  return _handleHttp(httpAction,
      bodyParser: _parseResponseBody(ForumInfoResult.fromJson),
      preProcessor: numMapperBuiler(["membernum", "todayposts"]));
}

var numMapperBuiler = (List<String> fields) => (String body) {
      var processed = body;

      var numMapper = (Match m) => "${m[1]}:${m[2]}";

      fields.forEach((field) {
        RegExp pattern = RegExp("(\"$field\")\\s*:\\s*\"(\\d+)\"");
        processed = processed.replaceAllMapped(pattern, numMapper);
      });

      return processed;
    };

Future<Map> apiDispatch(api, Map parameters) {
  if (api == LOGIN_API) {
    return login(parameters);
  }

  if (api.startsWith(HOMELIST_API)) {
    return getHomeList(parameters);
  }

  if (api == STORY_CONTENT_API) {
    return contentsForStory(parameters);
  }

  if (api == STORY_INFO_API) {
    return getStoryInfo(parameters);
  }

  if (api == FORUMLIST_API) {
    return getForumList();
  }

  if (api.startsWith(FORUMTHREADS_API)) {
    return getStoriesForForum(parameters);
  }

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
