import 'dart:async';

import 'package:lkongapp/actions/actions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lkongapp/models/user.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'package:lkongapp/utils/globals.dart';

import 'test_user.dart' as TestUser;

Future<Null> loginTest() async {
  UserBuilder builder = UserBuilder()
    ..identity = TestUser.user['identity']
    ..password = TestUser.user['password'];

  User user = builder.build();

  await login({"user": user}).then((map) {
    expect(map['success'], true);
  });
}

void main() {
  initGlobals(testing: true);

  test('Login Test', () async {
    UserBuilder builder = UserBuilder()
      ..identity = TestUser.user['identity']
      ..password = TestUser.user['password'];

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

  test('Get Follow List Test', () async {
    await getFollowList().then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });

  test('Punch Card Test', () async {
    await loginTest();

    await punchCard().then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });

  test('Get Personal Data Test', () async {
    await loginTest();

    await getPersonalData({"mode": 0}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });

    await getPersonalData({"mode": 1}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });

  test('Search Test', () async {
    await searchLKong({"search": "iOS", "type": 0}).then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
    await searchLKong({"search": "小说", "type": 1}).then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
    await searchLKong({"search": "小说", "type": 2}).then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
  });

  test('Logout Test', () async {
    await logout().then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
  });
}
