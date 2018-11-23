import 'dart:core';
import 'package:intl/intl.dart';

String _avatarForID(id) {
  var padded = '0' * (9 - id.toString().length) + id.toString();
  return "${padded.substring(0, 3)}/${padded.substring(3, 5)}/${padded.substring(5, 7)}/${padded.substring(7)}_avatar_middle.jpg";
}

String avatarForUserID(id) {
  var avatar = "http://img.lkong.cn/avatar/${_avatarForID(id)}";
  return avatar;
}

String avatarForForumID(id) {
  var avatar = "http://img.lkong.cn/forumavatar/${_avatarForID(id)}";
  return avatar;
}

String parseLKTypeId(String storyId) {
  var id;
  var flds = storyId.split("_");
  if (flds.length > 1) {
    id = flds[1];
  } else {
    id = storyId;
  }
  return id;
}

DateTime parseDatetime(String dateline) {
  DateTime date;

  final unixTime = int.tryParse(dateline);
  if (unixTime != null) {
    date = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
  } else {
    date = dateFromString(dateline);
  }

  return date;
}

// final UniversalTimeFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
// final DefaultTimeZone = "Asia/Shanghai";
final LKongTimeFormat = "yyyy-MM-dd HH:mm:ss";

DateTime dateFromString(String dateStr) {
  var date = DateTime.tryParse(dateStr);
  if (date == null) {
    date = DateTime.fromMillisecondsSinceEpoch(0);
  }

  return date;
}

String stringFromDate(DateTime date) {
  String dateStr = "";
  if (date != null) {
    final format = DateFormat(LKongTimeFormat);
    dateStr = format.format(date);
  }

  return dateStr;
}

String timeAgoSinceDate(DateTime date) {
  DateTime now = DateTime.now();
  final diff = now.difference(date);
  final days = diff.inDays;
  final hours = diff.inHours;
  final minutes = diff.inMinutes;
  final seconds = diff.inSeconds;

  if (days >= 365) {
    return "${days ~/ 365}年前";
  } else if (days > 7) {
    return "${days ~/ 7}周前";
  } else if (days >= 2) {
    return "$days天前";
  } else if (days == 1) {
    return "昨天";
  } else if (hours >= 1) {
    return "$hours小时前";
  } else if (minutes >= 1) {
    return "$minutes分钟前";
  } else if (seconds >= 3) {
    return "$seconds秒前";
  } else {
    return "现在";
  }
}
