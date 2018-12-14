import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:built_value/built_value.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/utils/http_session.dart';

import 'package:lkongapp/utils/globals.dart';

const LOGIN_API = "LOGIN";
const LOGOUT_API = "LOGOUT";
const HOMELIST_API = "HOMELIST";
const STORY_CONTENT_API = "STORY_CONTENT";
const STORY_INFO_API = "STORY_INFO";
const FORUMLIST_API = "FORUMLIST";
const FORUM_INFO_API = "FORUMINFO";
const FORUM_THREADS_API = "FORUMTHREADS";
const FORUM_CHECKNEW_API = "FORUM_CHECKNEW";
const USERINFO_API = "USERINFO";
const FOLLOWLIST_API = "FOLLOWLIST";
const PUNCHCARD_API = "PUNCHCARD";
const MYDATA_API = "MYDATA";
const SEARCH_API = "SEARCH";
const USER_PROFILE_API = "USER_PROFILE";

const endpoint = {
  "login": "/index.php?mod=login",
  "logout": "/forum/index.php?mod=ajax&action=logout",
  "userInfo": "/index.php?mod=ajax&action=userconfig",
  "threadInfo": "/index.php?mod=ajax&action=threadconfig",
  "stories": "/index.php?mod=data&sars=index/",
  "userProfile": "/index.php?mod=data&sars=user/",
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
  @required Map dataParser(String data),
  String preProcessor(String data),
}) {
  return httpAction.then((response) {
    Map result = {};

    if (response.statusCode >= 400) {
      result = {"error": "HTTP错误: ${response.statusCode}"};
    } else {
      var data;
      if (preProcessor != null) {
        data = preProcessor(response.body);
      } else {
        data = response.body;
      }

      // print(json.decode(data));
      try {
        result = dataParser(data);
      } catch (e) {
        print(e.toString());
        result = json.decode(data);
        if (result["error"] == null) {
          result = {"error": e.toString()};
        }
      }

      if (result == null) {
        result = {"error": 'API没有返回信息'};
      }
    }
    return result;
  }).catchError((error) {
    String errStr = error.toString();
    print("Error: $errStr");
    return {"error": errStr};
  });
}

Future<Map> login(Map args) {
  User user = userParam(args);

  var httpAction = session.post(endpoint["login"], data: {
    "action": "login",
    "email": user.identity,
    "password": user.password,
    "rememberme": "on"
  });
  return _handleHttp(httpAction, dataParser: (data) => json.decode(data));
}

Future<Map> logout() {
  final urlString = endpoint["logout"] + querify(defaultParameter());
  var httpAction = session.get(urlString);
  return _handleHttp(httpAction, dataParser: (data) => {"result": data});
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
    [T proccessor(T t)]) {
  var urlString = url + querify(parameters);

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction, dataParser: (data) {
    Map result;

    T stories = fromJson(data);
    if (stories != null) {
      if (proccessor != null) {
        stories = proccessor(stories);
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

  var urlString = endpoint["forumStories"] + "$forumId" + modeString;
  var params = getTimeParameter(nexttime, current);

  return fetchStories<StoryListResult>(
      urlString,
      params,
      StoryListResult.fromJson,
      (stories) => reverse
          ? stories.rebuild((b) => b..data.replace(stories.data.reversed))
          : stories);
}

Future<Map> checkNewStories(Map args) {
  int current = args["current"] ?? 0;
  int forumId = args["forumId"];

  String urlBase;

  var parameters = getTimeParameter(0, current);
  parameters["checkrenew"] = 1;

  if (forumId != null) {
    //Check for new stories in a forum
    urlBase = endpoint["forumStories"] + "$forumId";
  } else {
    //Check for the home list
    urlBase = endpoint["stories"];
  }

  var urlString = urlBase + querify(parameters);

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: (data) => {"result": int.parse(data)});
}

Future<Map> getHomeList(Map args) {
  int nexttime = args["nexttime"] ?? 0;
  int current = args["current"] ?? 0;
  bool threadOnly = args["threadOnly"] ?? false;

  var urlString = endpoint["stories"] + (threadOnly ? 'thread' : '');
  var params = getTimeParameter(nexttime, current);

  return fetchStories<StoryListResult>(
      urlString,
      params,
      StoryListResult.fromJson,
      (stories) =>
          stories.rebuild((b) => b..data.replace(stories.data.reversed)));
}

_parseResponseBody<T>(T fromJson(String json)) => (String data) {
      Map result;

      T object = fromJson(data);
      if (object != null) {
        result = {"result": object};
      }
      return result;
    };

Future<Map> contentsForStory(Map args) {
  int story = args["story"];
  int page = args["page"];

  assert(story != null, "Story must be defined");
  assert(page != null, "Page must be defined");

  var urlString =
      endpoint["comments"] + "$story/$page" + querify(defaultParameter());

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(StoryContentResult.fromJson),
      preProcessor: numMapperBuiler(["pid", "id", "authorid"]));
}

Future<Map> getStoryInfo(Map args) {
  int story = args["story"];

  assert(story != null, "Story must be defined");

  var urlString =
      endpoint["threadInfo"] + "_$story" + querify(defaultParameter());

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(StoryInfoResult.fromJson));
}

Future<Map> getForumList() {
  var urlString = endpoint["forumList"] + querify(defaultParameter());

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(ForumListResult.fromJson));
}

Future<Map> getForumInfo(Map args) {
  int forumId = args["id"];

  assert(forumId != null, "forumId must be defined");

  var urlString = endpoint["forumInfo"] + "_$forumId";

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(ForumInfoResult.fromJson),
      preProcessor: numMapperBuiler(["membernum", "todayposts"]));
}

Future<Map> getUserInfo(Map args) {
  int uid = args["id"];
  bool forceRenew = args["forceRenew"] ?? false;

  assert(uid != null, "UserId must be defined");

  var urlString = endpoint["userInfo"] +
      "_$uid" +
      (forceRenew ? querify(defaultParameter()) : "");

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(UserInfo.fromJson));
}

Future<Map> getFollowList() {
  final httpAction = session.get("");
  return _handleHttp(
    httpAction,
    dataParser: _parseResponseBody(FollowList.fromJson),
    preProcessor: (data) {
      var result = data;
      RegExp divPattern =
          RegExp("<div\\s+id=\"setfollows\".*?>\\{\"uid\":.*?\\}</div>");
      final divMatch = divPattern.firstMatch(data);
      if (divMatch != null) {
        String divHtml = divMatch.group(0);
        RegExp jsonPattern = RegExp("\\{.*?\\}");
        final jsonMatch = jsonPattern.firstMatch(divHtml);
        if (jsonMatch != null) {
          result = jsonMatch.group(0);
        }
      }
      return result;
    },
  );
}

Future<Map> punchCard() {
  var urlString = endpoint["punchCard"];

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(PunchCardResult.fromJson));
}

Future<Map> getPersonalData(Map args) {
  int nexttime = args["nexttime"] ?? 0;
  int current = args["current"] ?? 0;
  int mode = args["mode"];

  assert(mode != null, "Must speicfy mode");

  String modeString;
  Function(String) parser;

  switch (mode) {
    case 0:
      modeString = "favorite";
      parser = StoryListResult.fromJson;
      break;
    case 1:
      modeString = "atme";
      parser = (json) {
        var result = StoryListResult.fromJson(json);
        result = result.rebuild((b) => b..data.replace(result.data.reversed));
        return result;
      };
      break;
    case 2:
    case 3:
    default:
      assert(false, "Unsupported Data mode $mode");
      break;
  }

  var params = getTimeParameter(nexttime, current);
  var urlString = endpoint["atMe"] + modeString + querify(params);

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(parser),
      preProcessor: numMapperBuiler(["uid", "score", "extcredits"]));
}

Future<Map> searchLKong(Map args) {
  int nexttime = args["nexttime"] ?? 0;
  int type = args["type"];
  String searchString = args["search"];

  assert(type != null, "Must speicfy type");

  String searchTypePrefix;
  Function(String) parser;

  switch (type) {
    case 0:
      searchTypePrefix = "";
      parser = StoryListResult.fromJson;
      break;
    case 1:
      searchTypePrefix = "@";
      parser = SearchUserResult.fromJson;
      break;
    case 2:
      searchTypePrefix = "#";
      parser = SearchForumResult.fromJson;
      break;
    default:
      assert(false, "Invalid Search Type $type");
      break;
  }

  var params = getTimeParameter(nexttime, 0);
  var urlString = endpoint["search"] +
      Uri.encodeComponent(searchTypePrefix + searchString) +
      querify(params);

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(parser),
      preProcessor: numMapperBuiler(["uid", "fid", "fansnum", "replynum"]));
}

String Function(String) numMapperBuiler(List<String> fields) {
  String Function(String) processor;
  processor = (String data) {
    String processed = data;

    var numMapper = (Match m) => "${m[1]}:${m[2]}";

    fields.forEach((field) {
      RegExp pattern = RegExp("(\"$field\")\\s*:\\s*\"(\\d+)\"");
      processed = processed.replaceAllMapped(pattern, numMapper);
    });

    return processed;
  };
  return processor;
}

Future<Map> apiDispatch(api, Map parameters) async {
  if (session.initialized == false) {
    return Future.delayed(
        Duration(milliseconds: 500), () => apiDispatch(api, parameters));
  }

  if (api == LOGIN_API) {
    return login(parameters);
  }

  if (api == LOGOUT_API) {
    return logout();
  }

  if (api == HOMELIST_API) {
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

  if (api == FORUM_INFO_API) {
    return getForumInfo(parameters);
  }

  if (api.startsWith(FORUM_THREADS_API)) {
    return getStoriesForForum(parameters);
  }

  if (api == FORUM_CHECKNEW_API) {
    return checkNewStories(parameters);
  }

  if (api == USERINFO_API) {
    return getUserInfo(parameters);
  }

  if (api == FOLLOWLIST_API) {
    return getFollowList();
  }

  if (api == PUNCHCARD_API) {
    return punchCard();
  }

  if (api == MYDATA_API) {
    return getPersonalData(parameters);
  }

  if (api == SEARCH_API) {
    return searchLKong(parameters);
  }

  return Future<Map>(null);
}

APIResponse createResponseAction(APIRequest action, Map response) {
  String api = action.api;
  APIResponse result = APIFailure(action, "Unimplemented API \"$api\"");

  if (response == null) {
    return result;
  }

  String error = response["error"];
  if (error != null) {
    return action.badResponse(error);
  }

  if (api == LOGIN_API) {
    User user = userParam(action.parameters);
    return LoginSuccess(action, user.rebuild((b) => b..uid = response["uid"]));
  }

  var output = response["result"];
  return action.goodResponse(output);

  if (api == HOMELIST_API) {
    StoryListResult list = response["result"] as StoryListResult;
    return HomeListSuccess(action, list);
  }

  if (api == STORY_CONTENT_API) {
    return result;
  }

  if (api == STORY_INFO_API) {
    return result;
  }

  if (api == FORUMLIST_API) {
    return result;
  }

  if (api.startsWith(FORUM_THREADS_API)) {
    return result;
  }

  return result;
}

void callAPI(Store<AppState> store, APIRequest action, NextDispatcher next) {
  next(action);
  store.dispatch((store) {
    apiDispatch(action.api, action.parameters).then((map) {
      APIResponse response = createResponseAction(action, map);
      store.dispatch(response);

      action.completer?.complete(response is APISuccess);
    });
  });
}
