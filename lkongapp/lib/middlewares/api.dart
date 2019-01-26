import 'dart:convert';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:lkongapp/utils/utils.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:built_value/built_value.dart';

import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/utils/tools.dart';
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
const REPLY_API = "REPLY";
const FOLLOW_API = "FOLLOW";
const UPVOTE_API = "UPVOTE";
const HOTDIGEST_API = "HOTDIGEST";
const PMSESSION_API = "PMSESSION";
const SENDPM_API = "SENDPM";
const CHECKNOTICE_API = "CHECKNOTICE";

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
  "checkNotice": "/index.php?mod=ajax&action=langloop",
  "upvote": "/index.php?mod=ajax&action=submitbox",
  "search": "/index.php?mod=data&sars=search/",
  "getBlacklist": "/index.php?mod=ajax&action=getblack",
  "favorite": "/index.php?mod=ajax&action=favorite",
  "hotthread": "/index.php?mod=ajax&action=hotthread",
  "digest": "/index.php?mod=ajax&action=digest",
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

      // print(data);
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
    param +=
        '&' + key.toString() + '=' + Uri.encodeQueryComponent(value.toString());
  });
  return param;
}

Future<Map> fetchStories<T>(url, parameters, T fromJson(String json),
    [T proccessor(T t)]) {
  var urlString = url + querify(parameters);

  var httpAction = session.get(urlString);
  return _handleHttp(
    httpAction,
    dataParser: (data) {
      Map result;

      T stories = fromJson(data);
      if (stories != null) {
        if (proccessor != null) {
          stories = proccessor(stories);
        }
        result = {"result": stories};
      }
      return result;
    },
    preProcessor: combinedProcessorBuilder([
      numMapperBuiler(["uid"]),
      tagStripperBuiler(["subject"])
    ]),
  );
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
      preProcessor: combinedProcessorBuilder([
        numMapperBuiler(["pid", "id", "authorid"]),
        strMapperBuiler(["extcredits"]),
        (data) {
          var mapper = (Match m) => "\"id\":${m[1]}";

          RegExp pattern =
              RegExp("\"_id\"\\s*:\\s*\\{\"\\\$id\"\\s*:\\s*(\".*?\")\\}");
          data = data.replaceAllMapped(pattern, mapper);

          return data;
        }
      ]));
}

Future<Map> getStoryInfo(Map args) {
  int story = args["story"];

  assert(story != null, "Story must be defined");

  var urlString =
      endpoint["threadInfo"] + "_$story" + querify(defaultParameter());

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(StoryInfoResult.fromJson),
      preProcessor: tagStripperBuiler(["subject"]));
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
      preProcessor: combinedProcessorBuilder([
        numMapperBuiler(["membernum", "todayposts"]),
        tagStripperBuiler(["description"])
      ]));
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
      dataParser: _parseResponseBody(UserInfo.fromJson),
      preProcessor: numMapperBuiler(["gender"]));
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
      modeString = "notice";
      parser = (json) {
        var result = NoticeResult.fromJson(json);
        // result = result.rebuild((b) => b..data.replace(result.data.reversed));
        return result;
      };
      break;
    case 3:
      modeString = "rate";
      parser = (json) {
        var result = RatelogResult.fromJson(json);
        // result = result
        //     .rebuild((b) => b..data.replace(result.data.reversed));
        return result;
      };
      break;
    case 4:
      modeString = "pm";
      parser = (json) {
        var result = PrivateMessageResult.fromJson(json);
        // result = result.rebuild((b) => b..data.replace(result.data.reversed));
        return result;
      };
      break;
    default:
      assert(false, "Unsupported Data mode $mode");
      break;
  }

  var params = getTimeParameter(nexttime, current);
  var urlString = endpoint["atMe"] + modeString + querify(params);

  var httpAction = session.get(urlString);
  return _handleHttp(
    httpAction,
    dataParser: _parseResponseBody(parser),
    preProcessor: combinedProcessorBuilder([
      numMapperBuiler(["uid", "score"]),
      tagStripperBuiler(["subject"])
    ]),
  );
}

Future<Map> getPMSession(Map args) {
  int nexttime = args["nexttime"] ?? 0;
  int current = args["current"] ?? 0;
  int pmid = args["pmid"];

  assert(pmid != null, "Must speicfy pmid");

  var params = getTimeParameter(nexttime, current);
  var urlString = endpoint["pmSession"] + "$pmid" + querify(params);
  final parser = (json) {
    var result = PMSession.fromJson(json);
    result = result.rebuild((b) => b..data.replace(result.data.reversed));
    return result;
  };
  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(parser),
      preProcessor: combinedProcessorBuilder([
        numMapperBuiler(["uid"]),
        tagStripperBuiler(["message"])
      ]));
}

Future<Map> searchLKong(Map args) {
  int nexttime = args["nexttime"] ?? 0;
  int type = args["type"];
  int sort = args["sort"];
  String searchString = args["search"];

  assert(type != null, "Must speicfy type");

  String searchTypePrefix;
  String sortSuffix;
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

  switch (sort) {
    case 0:
      sortSuffix = "";
      break;
    case 1:
      sortSuffix = "/hot";
      break;
    case 2:
      sortSuffix = "/time";
      break;
    default:
      assert(false, "Invalid Search Sort $type");
      break;
  }

  var params = getTimeParameter(nexttime, 0);
  var urlString = endpoint["search"] +
      Uri.encodeComponent(searchTypePrefix + searchString) +
      sortSuffix +
      querify(params);

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(parser),
      preProcessor: combinedProcessorBuilder([
        numMapperBuiler(["uid", "fid", "fansnum", "replynum"]),
        tagStripperBuiler(["subject", "username", "name", "verifymessage"])
      ]));
}

Future<Map> getUserProfile(Map args) {
  int nexttime = args["nexttime"] ?? 0;
  int uid = args["uid"];
  int type = args["type"];

  assert(uid != null, "Must speicfy userID");
  assert(type != null, "Must speicfy fetch Type");

  String typeString;
  Function(String) parser;

  switch (type) {
    case 0:
      typeString = "/thread";
      parser = StoryListResult.fromJson;
      break;
    case 1:
      typeString = "/fans";
      parser = SearchUserResult.fromJson;
      break;
    case 2:
      typeString = "/follow";
      parser = SearchUserResult.fromJson;
      break;
    case 3:
      typeString = "/digest";
      parser = StoryListResult.fromJson;
      break;
    case 4:
      typeString = "";
      parser = (data) {
        final stories = StoryListResult.fromJson(data);
        return stories.rebuild((b) => b..data.replace(stories.data.reversed));
      };
      break;
    default:
      assert(false, "Unsupported Data mode $type");
      break;
  }

  var params = getTimeParameter(nexttime, 0);
  var urlString = endpoint["userProfile"] + "$uid$typeString" + querify(params);

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(parser),
      preProcessor: combinedProcessorBuilder([
        numMapperBuiler(["uid", "curtime", "nexttime", "sortkey"]),
        tagStripperBuiler(["subject"])
      ]));
}

Future<Map> replyWithParameter(Map args) {
  Map params = Map();

  ReplyType type = args["type"];
  StoryInfoResult story = args["story"];
  Comment comment = args["comment"];
  Forum forum = args["forum"];
  String subject = args["subject"];
  String content = args["content"];

  params["content"] = content;
  switch (type) {
    case ReplyType.Forum:
      params["type"] = "new";
      params["fid"] = "${forum.fid}";
      params["title"] = subject;
      break;
    case ReplyType.Story:
      params["type"] = "reply";
      params["tid"] = "${story.tid}";
      params["myrequestid"] = "thread_${story.tid}";
      break;
    case ReplyType.Comment:
      params["type"] = "reply";
      params["tid"] = "${story.tid}";
      params["replyid"] = "${comment.id}";
      params["myrequestid"] = "post_${comment.id}";
      break;
    case ReplyType.EditStory:
      params["type"] = "edit";
      params["tid"] = "${story.tid}";
      params["pid"] = "${comment.id}";
      params["title"] = subject;
      params["ac"] = "thread";
      break;
    case ReplyType.EditComment:
      params["type"] = "edit";
      params["tid"] = "${story.tid}";
      params["pid"] = "${comment.id}";
      params["ac"] = "post";
      break;
  }

  var httpAction = session.post(endpoint["reply"], data: params);
  return _handleHttp(httpAction, dataParser: (data) => json.decode(data));
}

Future<Map> followAction(Map args) {
  int id = args["id"];
  String type = args["type"];
  bool unfollow = args["unfollow"];

  Map params = {
    "followtype": (unfollow ? "unfollow" : "follow"),
    "followid": "$type-$id"
  };

  var httpAction = session.post(endpoint["follow"], data: params);
  return _handleHttp(httpAction, dataParser: (data) => json.decode(data));
}

Future<Map> queryMetaData(Map args) {
  int postId = args["postId"];
  String userName = args["userName"];

  String dataitem;
  if (postId != null) {
    dataitem = "post_$postId";
  } else if (userName != null) {
    dataitem = "name_$userName";
  }

  Map params = defaultParameter();

  params["dataitem"] = dataitem;

  final urlString = endpoint["query"] + querify(params);

  var httpAction = session.get(urlString);
  return _handleHttp(
    httpAction,
    dataParser: (data) => json.decode(data),
  );
}

Future<Map> favoriteThread(Map args) {
  int threadId = args["threadId"];
  bool unfavorite = args["unfavorite"];

  Map params = defaultParameter();
  params["tid"] = "$threadId";
  if (unfavorite == true) {
    params["type"] = "-1";
  }

  final urlString = endpoint["favorite"] + querify(params);

  var httpAction = session.get(urlString);
  return _handleHttp(
    httpAction,
    dataParser: (data) => json.decode(data),
  );
}

Future<Map> upvoteComment(Map args) {
  int commentId = args["id"];
  int coins = args["coins"];
  String reason = args["reason"];

  var httpAction = session.post(endpoint["upvote"], data: {
    "request": "rate_post_$commentId",
    "num": "$coins",
    "reason": reason,
  });
  return _handleHttp(
    httpAction,
    dataParser: _parseResponseBody(UpvoteResult.fromJson),
    preProcessor: strMapperBuiler(["extcredits"]),
  );
}

Future<Map> sendPM(Map args) {
  int pmId = args["pmid"];
  String message = args["message"];

  var httpAction = session.post(endpoint["message"], data: {
    "request": "pm_$pmId",
    "message": message,
  });
  return _handleHttp(httpAction, dataParser: (data) => json.decode(data));
}

Future<Map> getHotDigest(Map args) {
  final forums = args["forums"] as List<Forum>;

  var hotUrlString = endpoint["hotthread"] + querify(defaultParameter());
  var hotHttpAction = session.get(hotUrlString);

  final hotConnection = _handleHttp(
    hotHttpAction,
    dataParser: _parseResponseBody(HotDigestResult.fromJson),
    preProcessor: numMapperBuiler(["tid"]),
  );

  var connections = <Future>[hotConnection];

  if (forums != null && forums.length > 0) {
    forums.forEach((forum) {
      var url =
          endpoint["hotthread"] + "_${forum.fid}" + querify(defaultParameter());
      var action = session.get(url);

      final connection = _handleHttp(
        action,
        dataParser: _parseResponseBody(HotDigestResult.fromJson),
        preProcessor: numMapperBuiler(["tid"]),
      );

      connections.add(connection);
    });
  }

  var digestUrlString = endpoint["digest"] + querify(defaultParameter());
  var digestHttpAction = session.get(digestUrlString);

  final digestConnection = _handleHttp(
    digestHttpAction,
    dataParser: _parseResponseBody(HotDigestResult.fromJson),
    preProcessor: numMapperBuiler(["tid"]),
  );

  connections.add(digestConnection);

  return Future.wait(connections).then((results) {
    var resultList = <HotDigestResult>[];
    results.forEach((result) {
      var hotlist = result["result"] as HotDigestResult;
      if (hotlist != null) {
        int fid = parseLKTypeId(hotlist.id);
        if (fid != null) {
          final forum = forums.firstWhere((forum) => forum.fid == fid);
          hotlist =
              hotlist.rebuild((b) => b..title = "${b.title} - ${forum.name}");
        }
        resultList.add(hotlist);
      }
    });
    return {"result": resultList};
  });
}

Future<Map> checkNewNotice() {
  final urlString = endpoint["checkNotice"] + querify(defaultParameter());

  var httpAction = session.get(urlString);
  return _handleHttp(
    httpAction,
    dataParser: _parseResponseBody(CheckNoticeResult.fromJson),
  );
}

String Function(String) combinedProcessorBuilder(
    List<String Function(String)> processors) {
  String Function(String) processor;
  processor = (String data) {
    String processed = data;

    processors.forEach((processor) {
      processed = processor(processed);
    });

    return processed;
  };
  return processor;
}

String Function(String) numMapperBuiler(List<String> fields) {
  String Function(String) processor;
  processor = (String data) {
    String processed = data;

    var numMapper = (Match m) => "${m[1]}:${m[2]}";

    fields.forEach((field) {
      RegExp pattern = RegExp("(\"$field\")\\s*:\\s*\"[+-]?(\\d+)\"");
      processed = processed.replaceAllMapped(pattern, numMapper);
    });

    return processed;
  };
  return processor;
}

String Function(String) strMapperBuiler(List<String> fields) {
  String Function(String) processor;
  processor = (String data) {
    String processed = data;

    var strMapper = (Match m) => "${m[1]}:\"${m[2]}\"${m[3]}";

    fields.forEach((field) {
      RegExp pattern = RegExp("(\"$field\")\\s*:\\s*(.*?)([,}])");
      processed = processed.replaceAllMapped(pattern, strMapper);
    });

    return processed;
  };
  return processor;
}

String Function(String) tagStripperBuiler(List<String> fields) {
  String Function(String) processor;
  processor = (String data) {
    String processed = data;
    final stripTag = (String string) {
      RegExp tagPattern = RegExp(r'<[!\\/a-z].*?>');
      RegExp spacePattern = RegExp(r'\n');
      RegExp escapePattern = RegExp(r'\\\\');

      string = string.replaceAll(tagPattern, "");
      string = string.replaceAll(spacePattern, "");
      string = string.replaceAll(escapePattern, r"\\");
      string = HtmlUnescape().convert(string);
      string = string.replaceAll('"', r'\"');

      return string.trim();
    };
    final tagStripper = (Match m) => "${m[1]}:\"${stripTag(m[2])}\"${m[3]}";

    fields.forEach((field) {
      RegExp pattern = RegExp("(\"$field\")\\s*:\\s*\"(.*?)\"([,}])");
      processed = processed.replaceAllMapped(pattern, tagStripper);
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

  if (api == USER_PROFILE_API) {
    return getUserProfile(parameters);
  }

  if (api == REPLY_API) {
    return replyWithParameter(parameters);
  }

  if (api == FOLLOW_API) {
    return followAction(parameters);
  }

  if (api == UPVOTE_API) {
    return upvoteComment(parameters);
  }

  if (api == HOTDIGEST_API) {
    return getHotDigest(parameters);
  }

  if (api == PMSESSION_API) {
    return getPMSession(parameters);
  }

  if (api == SENDPM_API) {
    return sendPM(parameters);
  }

  if (api == CHECKNOTICE_API) {
    return checkNewNotice();
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

  var output = response["result"] ?? response;
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
      String error;
      if (response is APIFailure) {
        error = response.error;
      }

      action.completer?.complete(error);
    });
  });
}
