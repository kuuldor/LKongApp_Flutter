import 'package:flutter/material.dart';
import 'package:lkongapp/models/lkong_jsons/lkong_json.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/ui/tools/item_handler.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

List<String> _parseLKongURLPath(String path, String prefix) {
  if (path.startsWith(prefix)) {
    final stripPath = path.substring(prefix.length);
    final head = stripPath.substring(0, 1);
    final tail = stripPath.substring(1);
    return <String>[head, tail];
  }
  return null;
}

bool _handleLKongLinks(BuildContext context, List<String> flds) {
  bool handled = false;
  switch (flds[0]) {
    case "thread":
      int tid;
      try {
        tid = int.parse(flds[1]);
      } catch (_) {}
      if (tid != null) {
        openThreadView(context, tid);
        handled = true;
      }
      break;
    case "user":
      int uid;
      try {
        uid = int.parse(flds[1]);
      } catch (_) {}
      if (uid != null) {
        onUserTap(context, UserInfo().rebuild((b) => b..uid = uid));
        handled = true;
      }
      break;
    case "name":
    case "lkonguser":
      final name = stripHtmlTag(flds[1]);
      openUserView(context, name);
      handled = true;
      break;
    case "post":
      int pid;
      try {
        pid = int.parse(flds[1]);
      } catch (_) {}
      if (pid != null) {
        openThreadView(context, null, postId: pid);
        handled = true;
      }
      break;
    default:
      break;
  }

  return handled;
}

handleURL(BuildContext context, String url) async {
  bool handled = false;

  print("URL is cliked: $url");
  if (url.startsWith("#!/")) {
    final typeID = url.substring(3); // strip prefix
    final flds = typeID.split("/");
    handled = _handleLKongLinks(context, flds);
  } else if (url.startsWith("lkong://")) {
    final typeID = url.substring(8); // strip lkong://
    final flds = parseTypeAndId(typeID);
    handled = _handleLKongLinks(context, flds);
    if (!handled && typeID.startsWith("forum")) {
      final idWithoutType = typeID.substring(5);
      int fid;
      try {
        fid = int.parse(idWithoutType);
      } catch (_) {}
      if (fid != null) {
        onForumTap(context, Forum().rebuild((b) => b..fid = fid));
        handled = true;
      }
    }
  } else if (url.startsWith("http")) {
    [
      "http://lkong.cn/",
      "http://www.lkong.net/",
      "http://www.lk2000.net/",
      "http://forum.lkong.net/",
      "http://forum.lk2000.net/"
    ].forEach((prefix) {
      if (url.startsWith(prefix)) {
        final path = url.substring(prefix.length);
        List<String> parsed;
        if (path.startsWith("thread")) {
          parsed = _parseLKongURLPath(path, "thread");
          int thread = 0;
          int post;
          int page = 1;

          if (parsed[0] == "/") {
            final arr = parsed[1].split(".");
            final arr2 = arr[0].split("/");
            thread = int.tryParse(arr2[0]) ?? 0;
            if (arr2.length > 1) {
              page = int.tryParse(arr2[1]) ?? 1;
            }
            if (arr.length > 1) {
              final arr2 = arr[1].split("_");
              if (arr2.length > 1) {
                post = int.tryParse(arr2[1]);
              }
            }
          } else if (parsed[0] == "-") {
            final arr = parsed[1].split("-");
            thread = int.tryParse(arr[0]) ?? 0;
          }
          if (thread != 0) {
            openThreadView(context, thread, postId: post, page: page);
            handled = true;
          }
        } else if (path.startsWith("forum.php")) {
          final uri = Uri.parse(url);
          final params = uri.queryParameters;
          if (params.length > 0) {
            final thread = int.tryParse(params["tid"] ?? "0");
            final page = int.tryParse(params["page"] ?? "1");
            if (thread != 0) {
              handled = true;
              openThreadView(context, thread, page: page);
            }
          }
        } else if (path.startsWith("forum")) {
          parsed = _parseLKongURLPath(path, "forum");
          int fid = 0;
          if (parsed[0] == "/") {
            fid = int.tryParse(parsed[1]) ?? 0;
          }

          if (fid != 0) {
            onForumTap(context, Forum().rebuild((b) => b..fid = fid));

            handled = true;
          }
        } else if (path.startsWith("user")) {
          parsed = _parseLKongURLPath(path, "user");
          int uid = 0;
          if (parsed[0] == "/") {
            uid = int.tryParse(parsed[1]) ?? 0;
          }

          if (uid != 0) {
            onUserTap(context, UserInfo().rebuild((b) => b..uid = uid));

            handled = true;
          }
        }
      }
    });

    if (!handled) {
      if (await canLaunch(url)) {
        await launch(url);
      }
    }
  }
}
