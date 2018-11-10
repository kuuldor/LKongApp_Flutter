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
