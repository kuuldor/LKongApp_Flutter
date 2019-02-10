import 'dart:async';

import 'package:lkongapp/actions/actions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lkongapp/models/user.dart';
import 'package:lkongapp/middlewares/api.dart';
import 'package:lkongapp/utils/globals.dart';

import 'test_user.dart' as TestUser;

Future<Null> loginTestAccount() async {
  UserBuilder builder = UserBuilder()
    ..identity = TestUser.user['identity']
    ..password = TestUser.user['password'];

  User user = builder.build();

  await login({"user": user}).then((map) {
    expect(map['success'], true);
  });
}

Future main() async {
  initGlobals(testing: true);

  await loginTest();

  await homelistTest();

  await forumStoryTest();

  await forumCheckNewTest();

  await threadInfoTest();

  await threadContentTest();

  await forumListTest();

  await forumInfoTest();

  await followListTest();

  await punchCardTest();

  await personalDataTest();

  await searchTest();

  await userProfileTest();

  await followTest();

  await quoteLocationTest();

  await hotlistTest();

  await pmSessionTest();

  await checkNewTest();

  await blacklistTest();

  await logoutTest();
}

Future<void> quoteLocationTest() async {
  return test('Get Quote Location Test', () async {
    await loginTestAccount();

    await queryMetaData({"postId": 33776898}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> logoutTest() async {
  return test('Logout Test', () async {
    await logout().then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
  });
}

Future<void> followTest() async {
  return test('Follow Test', () async {
    await loginTestAccount();

    await followAction({"type": "uid", "unfollow": true, "id": 807754})
        .then((map) {
      print(map.toString());
      expect(map['error'], null);
    });

    await followAction({"type": "black", "unfollow": true, "id": 807754})
        .then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> userProfileTest() async {
  return test('UserProfile Test', () async {
    await getUserProfile({"uid": 445098, "type": 0}).then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
    await getUserProfile({"uid": 445098, "type": 1}).then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
    await getUserProfile({"uid": 445098, "type": 2}).then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
    await getUserProfile({"uid": 445098, "type": 3}).then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
  });
}

Future<void> searchTest() async {
  return test('Search Test', () async {
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
}

Future<void> personalDataTest() async {
  return test('Get Personal Data Test', () async {
    await loginTestAccount();

    await getPersonalData({"mode": 0}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });

    await getPersonalData({"mode": 1}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> punchCardTest() async {
  return test('Punch Card Test', () async {
    await loginTestAccount();

    await punchCard().then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> followListTest() async {
  return test('Get Follow List Test', () async {
    await getFollowList().then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> forumInfoTest() async {
  return test('Get Forum Info Test', () async {
    await getForumInfo({"id": 60}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
    await getForumInfo({"id": 1024}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> forumListTest() async {
  return test('Get Forum List Test', () async {
    await getForumList().then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> threadContentTest() async {
  return test('Get Thread Content Test', () async {
    await contentsForStory({"story": 2173241, "page": 0}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> threadInfoTest() async {
  return test('Get Thread Info Test', () async {
    await getStoryInfo({"story": 2173241}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> forumCheckNewTest() async {
  return test('Check New Forum Story Test', () async {
    await checkNewStories({"forumId": 60}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> forumStoryTest() async {
  return test('Get Forum Story List Test', () async {
    await getStoriesForForum({"forumId": 60}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> homelistTest() async {
  return test('Get Home List Test', () async {
    await getHomeList({}).then((map) {
      print(map.toString());
      expect(map['error'], null);
      print(session.cookies.toString());
    });
  });
}

Future<void> checkNewTest() async {
  return test('Check New Notice Test', () async {
    await checkNewNotice().then((map) {
      print(map.toString());
      expect(map['error'], null);
      print(session.cookies.toString());
    });
  });
}

Future<void> hotlistTest() async {
  return test('Get Hot List Test', () async {
    await getHotDigest({}).then((map) {
      print(map.toString());
      expect(map['error'], null);
      print(session.cookies.toString());
    });
  });
}

Future<void> blacklistTest() async {
  return test('Get Blacklist Test', () async {
    await getBlacklist().then((map) {
      print(map.toString());
      expect(map['error'], null);
      print(session.cookies.toString());
    });
  });
}

Future<void> pmSessionTest() async {
  return test('Get PM Session Test', () async {
    await getPMSession({"uid": 812695}).then((map) {
      print(map.toString());
      expect(map['error'], null);
      print(session.cookies.toString());
    });
  });
}

Future<void> loginTest() async {
  return test('Login Test', () async {
    UserBuilder builder = UserBuilder()
      ..identity = TestUser.user['identity']
      ..password = TestUser.user['password'];

    User user = builder.build();
    final Completer<Null> completer = Completer<Null>();
    var request = LoginRequest(completer, user);

    await login({"user": user}).then((map) {
      print(map.toString());
      // expect(map['uid'], 812695);
      expect(map['success'], true);
      LoginSuccess response = createResponseAction(request, map);
      expect(response.runtimeType, LoginSuccess);
      print(response.user.toString());

      print(session.cookies.toString());
    });
  });
}
