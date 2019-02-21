import 'dart:convert';
import 'dart:io';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:lkongapp/utils/network_isolate.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
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
const GETBLACKLIST_API = "GETBLACKLIST";
const QUERY_API = "QUERY";
const FAVORITE_API = "FAVORITE";
const UPLOAD_IMAGE_API = "UPLOAD_IMAGE";
const UPLOAD_AVATAR_API = "UPLOAD_AVATAR";

const _endpoint = {
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
      var data = utf8.decode(response.bodyBytes);
      if (preProcessor != null) {
        data = preProcessor(data);
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

Future<Map> _login(Map args) {
  User user = _userParam(args);

  var httpAction = session.post(_endpoint["login"], data: {
    "action": "login",
    "email": user.identity,
    "password": user.password,
    "rememberme": "on"
  });
  return _handleHttp(httpAction, dataParser: (data) => json.decode(data));
}

Future<Map> _logout() {
  final urlString = _endpoint["logout"] + _querify(_defaultParameter());
  var httpAction = session.get(urlString);
  return _handleHttp(httpAction, dataParser: (data) => {"result": data});
}

User _userParam(Map args) {
  User user = args["user"];
  return user;
}

int _timeStamp = DateTime.now().millisecondsSinceEpoch;

Map _defaultParameter() {
  var param = new Map();
  param['_'] = _timeStamp++;
  return param;
}

Map _getTimeParameter(nexttime, current) {
  var param = _defaultParameter();

  if (nexttime != 0) {
    param['nexttime'] = nexttime;
  } else if (current != 0) {
    param['curtime'] = current;
  }

  return param;
}

String _querify(Map parameters) {
  var param = '';
  parameters.forEach((key, value) {
    param +=
        '&' + key.toString() + '=' + Uri.encodeQueryComponent(value.toString());
  });
  return param;
}

Future<Map> _fetchStories<T>(url, parameters, T fromJson(String json),
    [T proccessor(T t)]) {
  var urlString = url + _querify(parameters);

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
    preProcessor: _combinedProcessorBuilder([
      _numMapperBuiler(["uid"]),
      _tagStripperBuiler(["subject"])
    ]),
  );
}

Future<Map> _getStoriesForForum(Map args) {
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

  var urlString = _endpoint["forumStories"] + "$forumId" + modeString;
  var params = _getTimeParameter(nexttime, current);

  return _fetchStories<StoryListResult>(
      urlString,
      params,
      StoryListResult.fromJson,
      (stories) => reverse
          ? stories.rebuild((b) => b..data.replace(stories.data.reversed))
          : stories);
}

Future<Map> _checkNewStories(Map args) {
  int current = args["current"] ?? 0;
  int forumId = args["forumId"];

  String urlBase;

  var parameters = _getTimeParameter(0, current);
  parameters["checkrenew"] = 1;

  if (forumId != null) {
    //Check for new stories in a forum
    urlBase = _endpoint["forumStories"] + "$forumId";
  } else {
    //Check for the home list
    urlBase = _endpoint["stories"];
  }

  var urlString = urlBase + _querify(parameters);

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: (data) => {"result": int.parse(data)});
}

Future<Map> _getHomeList(Map args) {
  int nexttime = args["nexttime"] ?? 0;
  int current = args["current"] ?? 0;
  bool threadOnly = args["threadOnly"] ?? false;

  var urlString = _endpoint["stories"] + (threadOnly ? 'thread' : '');
  var params = _getTimeParameter(nexttime, current);

  return _fetchStories<StoryListResult>(
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

Future<Map> _contentsForStory(Map args) {
  int story = args["story"];
  int page = args["page"];

  assert(story != null, "Story must be defined");
  assert(page != null, "Page must be defined");

  var urlString =
      _endpoint["comments"] + "$story/$page" + _querify(_defaultParameter());

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(StoryContentResult.fromJson),
      preProcessor: _combinedProcessorBuilder([
        _numMapperBuiler(["pid", "id", "authorid"]),
        _strMapperBuiler(["extcredits"]),
        (data) {
          var mapper = (Match m) => "\"id\":${m[1]}";

          RegExp pattern =
              RegExp("\"_id\"\\s*:\\s*\\{\"\\\$id\"\\s*:\\s*(\".*?\")\\}");
          data = data.replaceAllMapped(pattern, mapper);

          return data;
        }
      ]));
}

Future<Map> _getStoryInfo(Map args) {
  int story = args["story"];

  assert(story != null, "Story must be defined");

  var urlString =
      _endpoint["threadInfo"] + "_$story" + _querify(_defaultParameter());

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(StoryInfoResult.fromJson),
      preProcessor: _tagStripperBuiler(["subject"]));
}

Future<Map> _getForumList() {
  var urlString = _endpoint["forumList"] + _querify(_defaultParameter());

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(ForumListResult.fromJson));
}

Future<Map> _getForumInfo(Map args) {
  int forumId = args["id"];

  assert(forumId != null, "forumId must be defined");

  var urlString = _endpoint["forumInfo"] + "_$forumId";

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(ForumInfoResult.fromJson),
      preProcessor: _combinedProcessorBuilder([
        _numMapperBuiler(["membernum", "todayposts"]),
        _tagStripperBuiler(["description"])
      ]));
}

Future<Map> _getUserInfo(Map args) {
  int uid = args["id"];
  bool forceRenew = args["forceRenew"] ?? false;

  assert(uid != null, "UserId must be defined");

  var urlString = _endpoint["userInfo"] +
      "_$uid" +
      (forceRenew ? _querify(_defaultParameter()) : "");

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(UserInfo.fromJson),
      preProcessor: _numMapperBuiler(["gender"]));
}

Future<Map> _getFollowList() {
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

Future<Map> _punchCard() {
  var urlString = _endpoint["punchCard"];

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(PunchCardResult.fromJson));
}

Future<Map> _getPersonalData(Map args) {
  int nexttime = args["nexttime"] ?? 0;
  int current = args["current"] ?? 0;
  int mode = args["mode"];

  assert(mode != null, "Must speicfy mode");

  String modeString;
  Function(String) parser;

  switch (mode) {
    case 0:
      modeString = "favorite";
      parser = (json) {
        var result = StoryListResult.fromJson(json);
        result = result.rebuild((b) => b..data.replace(result.data.reversed));
        return result;
      };
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

  var params = _getTimeParameter(nexttime, current);
  var urlString = _endpoint["atMe"] + modeString + _querify(params);

  var httpAction = session.get(urlString);
  return _handleHttp(
    httpAction,
    dataParser: _parseResponseBody(parser),
    preProcessor: _combinedProcessorBuilder([
      _numMapperBuiler(["uid", "score"]),
      _tagStripperBuiler(["subject"])
    ]),
  );
}

Future<Map> _getPMSession(Map args) {
  int nexttime = args["nexttime"] ?? 0;
  int current = args["current"] ?? 0;
  int pmid = args["pmid"];

  assert(pmid != null, "Must speicfy pmid");

  var params = _getTimeParameter(nexttime, current);
  var urlString = _endpoint["pmSession"] + "$pmid" + _querify(params);
  final parser = (json) {
    var result = PMSession.fromJson(json);
    result = result.rebuild((b) => b..data.replace(result.data.reversed));
    return result;
  };
  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(parser),
      preProcessor: _combinedProcessorBuilder([
        _numMapperBuiler(["uid"]),
        _tagStripperBuiler(["message"])
      ]));
}

Future<Map> _searchLKong(Map args) {
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

  var params = _getTimeParameter(nexttime, 0);
  var urlString = _endpoint["search"] +
      Uri.encodeComponent(searchTypePrefix + searchString) +
      sortSuffix +
      _querify(params);

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(parser),
      preProcessor: _combinedProcessorBuilder([
        _numMapperBuiler(["uid", "fid", "fansnum", "replynum"]),
        _tagStripperBuiler(["subject", "username", "name", "verifymessage"])
      ]));
}

Future<Map> _getUserProfile(Map args) {
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

  var params = _getTimeParameter(nexttime, 0);
  var urlString =
      _endpoint["userProfile"] + "$uid$typeString" + _querify(params);

  var httpAction = session.get(urlString);
  return _handleHttp(httpAction,
      dataParser: _parseResponseBody(parser),
      preProcessor: _combinedProcessorBuilder([
        _numMapperBuiler(["uid", "curtime", "nexttime", "sortkey"]),
        _tagStripperBuiler(["subject"])
      ]));
}

Future<Map> _replyWithParameter(Map args) {
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

  var httpAction = session.post(_endpoint["reply"], data: params);
  return _handleHttp(httpAction, dataParser: (data) => json.decode(data));
}

Future<Map> _followAction(Map args) {
  int id = args["id"];
  String type = args["type"];
  bool unfollow = args["unfollow"];

  Map params = {
    "followtype": (unfollow ? "unfollow" : "follow"),
    "followid": "$type-$id"
  };

  var httpAction = session.post(_endpoint["follow"], data: params);
  return _handleHttp(httpAction, dataParser: (data) => json.decode(data));
}

Future<Map> _queryMetaData(Map args) {
  int postId = args["postId"];
  String userName = args["userName"];

  String dataitem;
  if (postId != null) {
    dataitem = "post_$postId";
  } else if (userName != null) {
    dataitem = "name_$userName";
  }

  Map params = _defaultParameter();

  params["dataitem"] = dataitem;

  final urlString = _endpoint["query"] + _querify(params);

  var httpAction = session.get(urlString);
  return _handleHttp(
    httpAction,
    dataParser: (data) => json.decode(data),
  );
}

Future<Map> _favoriteThread(Map args) {
  int threadId = args["threadId"];
  bool unfavorite = args["unfavorite"];

  Map params = _defaultParameter();
  params["tid"] = "$threadId";
  if (unfavorite == true) {
    params["type"] = "-1";
  }

  final urlString = _endpoint["favorite"] + _querify(params);

  var httpAction = session.get(urlString);
  return _handleHttp(
    httpAction,
    dataParser: (data) => json.decode(data),
  );
}

Future<Map> _upvoteComment(Map args) {
  int commentId = args["id"];
  int coins = args["coins"];
  String reason = args["reason"];

  var httpAction = session.post(_endpoint["upvote"], data: {
    "request": "rate_post_$commentId",
    "num": "$coins",
    "reason": reason,
  });
  return _handleHttp(
    httpAction,
    dataParser: _parseResponseBody(UpvoteResult.fromJson),
    preProcessor: _strMapperBuiler(["extcredits"]),
  );
}

Future<Map> _sendPM(Map args) {
  int pmId = args["pmid"];
  String message = args["message"];

  var httpAction = session.post(_endpoint["message"], data: {
    "request": "pm_$pmId",
    "message": message,
  });
  return _handleHttp(httpAction, dataParser: (data) => json.decode(data));
}

Future<Map> _getHotDigest(Map args) {
  final forums = args["forums"] as List<Forum>;

  var hotUrlString = _endpoint["hotthread"] + _querify(_defaultParameter());
  var hotHttpAction = session.get(hotUrlString);

  final hotConnection = _handleHttp(
    hotHttpAction,
    dataParser: _parseResponseBody(HotDigestResult.fromJson),
    preProcessor: _numMapperBuiler(["tid"]),
  );

  var connections = <Future>[hotConnection];

  if (forums != null && forums.length > 0) {
    forums.forEach((forum) {
      var url = _endpoint["hotthread"] +
          "_${forum.fid}" +
          _querify(_defaultParameter());
      var action = session.get(url);

      final connection = _handleHttp(
        action,
        dataParser: _parseResponseBody(HotDigestResult.fromJson),
        preProcessor: _numMapperBuiler(["tid"]),
      );

      connections.add(connection);
    });
  }

  var digestUrlString = _endpoint["digest"] + _querify(_defaultParameter());
  var digestHttpAction = session.get(digestUrlString);

  final digestConnection = _handleHttp(
    digestHttpAction,
    dataParser: _parseResponseBody(HotDigestResult.fromJson),
    preProcessor: _numMapperBuiler(["tid"]),
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

Future<Map> _getBlacklist() {
  var urlString = _endpoint["getBlacklist"] + _querify(_defaultParameter());
  var httpAction = session.get(urlString);

  return _handleHttp(httpAction, dataParser: _parseBlacklist);
}

Map _parseBlacklist(String htmlString) {
  var users = List<UserInfo>();
  if (htmlString != null && htmlString.length > 0) {
    final pattern =
        RegExp('<td><a.*?dataitem="user_([0-9]*)".*?>(.*?)</a></td>');
    if (pattern.hasMatch(htmlString)) {
      final List matches = pattern.allMatches(htmlString).toList();
      if (matches.length > 0) {
        matches.forEach((m) => users.add(UserInfo().rebuild((b) => b
          ..uid = int.parse(m[1])
          ..username = m[2])));
      }
    }
  }

  return {"result": users};
}

Future<Map> _uploadImage(Map args) async {
  String file = args["file"];

  if (file == null) {
    return {"error": "File cannot be null"};
  }

  final urlString = "http://lkong.cn:1345/upload";

  var httpAction = session.uploadFile(urlString, "image", file);
  return httpAction.then((response) async {
    if (response.statusCode == 200) {
      final body = await response.stream.toBytes();
      return json.decode(utf8.decode(body));
    } else {
      return {"error": "Status ${response.statusCode}"};
    }
  });
}

const _avatarSizeLimit = 1153433;
Future<Map> _uploadAvatar(Map args) async {
  String file = args["file"];

  if (file == null) {
    return {"error": "File cannot be null"};
  }

  File fp = File(file);
  final len = await fp.length();

  if (len > _avatarSizeLimit) {
    return {"error": "头像大小超出限制"};
  }

  final urlString = "http://img.lkong.cn/respond/upavatar.php";

  final idCookie = session.cookies["identity"];
  if (idCookie == null) {
    return {"error": "未发现登录信息"};
  }

  final idenity = Uri.decodeFull(idCookie);
  var headers = Map<String, String>();
  headers["Referer"] = "http://lkong.cn/setting";
  headers["Origin"] = "http://lkong.cn";

  var fields = Map<String, String>();
  fields["Filename"] = basename(file);
  fields["folder"] = "/uploads";
  fields["fileext"] = extension(file);
  fields["identity"] = idenity;
  fields["fid"] = "0";
  fields["Upload"] = "Submit Query";

  var httpAction = session.uploadFile(urlString, "picdata", file,
      headers: headers, fields: fields);
  return httpAction.then((response) async {
    if (response.statusCode == 200) {
      final body = await response.stream.toBytes();
      return json.decode(utf8.decode(body));
    } else {
      return {"error": "Status ${response.statusCode}"};
    }
  });
}

Future<Map> _checkNewNotice() {
  final urlString = _endpoint["checkNotice"] + _querify(_defaultParameter());

  var httpAction = session.get(urlString);
  return _handleHttp(
    httpAction,
    dataParser: _parseResponseBody(CheckNoticeResult.fromJson),
  );
}

String Function(String) _combinedProcessorBuilder(
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

String Function(String) _numMapperBuiler(List<String> fields) {
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

String Function(String) _strMapperBuiler(List<String> fields) {
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

String Function(String) _tagStripperBuiler(List<String> fields) {
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
  if (isolateReady == null) {
    return Future.delayed(
        Duration(milliseconds: 500), () => apiDispatch(api, parameters));
  }

  Map params = Map();
  params.addAll(parameters);
  params["API"] = api;
  var result = await sendReceive(params);

  return result as Map;
}

Future<Map> handleAPIRequest(Map params) {
  if (session == null || session.initialized == false) {
    return Future.delayed(
        Duration(milliseconds: 500), () => handleAPIRequest(params));
  }

  final api = params["API"];
  Map parameters = params;

  if (api == LOGIN_API) {
    return _login(parameters);
  }

  if (api == LOGOUT_API) {
    return _logout();
  }

  if (api == HOMELIST_API) {
    return _getHomeList(parameters);
  }

  if (api == STORY_CONTENT_API) {
    return _contentsForStory(parameters);
  }

  if (api == STORY_INFO_API) {
    return _getStoryInfo(parameters);
  }

  if (api == FORUMLIST_API) {
    return _getForumList();
  }

  if (api == FORUM_INFO_API) {
    return _getForumInfo(parameters);
  }

  if (api.startsWith(FORUM_THREADS_API)) {
    return _getStoriesForForum(parameters);
  }

  if (api == FORUM_CHECKNEW_API) {
    return _checkNewStories(parameters);
  }

  if (api == USERINFO_API) {
    return _getUserInfo(parameters);
  }

  if (api == FOLLOWLIST_API) {
    return _getFollowList();
  }

  if (api == PUNCHCARD_API) {
    return _punchCard();
  }

  if (api == MYDATA_API) {
    return _getPersonalData(parameters);
  }

  if (api == SEARCH_API) {
    return _searchLKong(parameters);
  }

  if (api == USER_PROFILE_API) {
    return _getUserProfile(parameters);
  }

  if (api == REPLY_API) {
    return _replyWithParameter(parameters);
  }

  if (api == FOLLOW_API) {
    return _followAction(parameters);
  }

  if (api == UPVOTE_API) {
    return _upvoteComment(parameters);
  }

  if (api == HOTDIGEST_API) {
    return _getHotDigest(parameters);
  }

  if (api == PMSESSION_API) {
    return _getPMSession(parameters);
  }

  if (api == SENDPM_API) {
    return _sendPM(parameters);
  }

  if (api == CHECKNOTICE_API) {
    return _checkNewNotice();
  }

  if (api == GETBLACKLIST_API) {
    return _getBlacklist();
  }

  if (api == QUERY_API) {
    return _queryMetaData(parameters);
  }

  if (api == FAVORITE_API) {
    return _favoriteThread(parameters);
  }

  if (api == UPLOAD_IMAGE_API) {
    return _uploadImage(parameters);
  }
  if (api == UPLOAD_AVATAR_API) {
    return _uploadAvatar(parameters);
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

  var output;
  if (api == LOGIN_API) {
    User user = _userParam(action.parameters);
    output = user.rebuild((b) => b..uid = response["uid"]);
  } else {
    output = response["result"] ?? response;
  }

  return action.goodResponse(output);
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
