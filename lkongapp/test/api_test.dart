import 'dart:async';

import 'package:lkongapp/actions/actions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lkongapp/models/user.dart';
import 'package:lkongapp/middlewares/api.dart';

void main() {
  test('Login Test', () async {
    UserBuilder builder = UserBuilder()
      ..identity = 'lkongapp@outlook.com'
      ..password = 'xxxxxxxxxxxx';

    User user = builder.build();
    final Completer<Null> completer = Completer<Null>();
    var request = LoginRequest(completer, user);

    await login({"user": user}).then((map) {
      print(map.toString());
      expect(map['uid'], 812695);
      expect(map['success'], true);
      LoginSuccess response = createResponseAction(request, map);
      expect(response.runtimeType, LoginSuccess);
      print(response.user.toString());

      print(session.cookies.toString());
    });
  });

  test('Get Home List Test', () async {
    await getHomeList({}).then((map) {
      print(map.toString());
      expect(map['error'], null);
      print(session.cookies.toString());
    });
  });

  test('Get Forum Story List Test', () async {
    await getStoriesForForum({"forumId": 60}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });

  test('Check New Forum Story Test', () async {
    await checkNewStories({"forumId": 60}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });

  test('Get Thread Info Test', () async {
    await getStoryInfo({"story": 2173241}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });

  test('Get Thread Content Test', () async {
    await contentsForStory({"story": 2173241, "page": 0}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });

  test('Get Forum List Test', () async {
    await getForumList().then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });

  test('Get Forum Info Test', () async {
    await getForumInfo({"id": 60}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
    await getForumInfo({"id": 1024}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });

  test('Logout Test', () async {
    await logout().then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
  });
}
