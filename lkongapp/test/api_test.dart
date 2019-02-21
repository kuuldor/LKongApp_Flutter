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

  await apiDispatchTest(LOGIN_API, {"user": user}).then((map) {
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

    await apiDispatchTest(QUERY_API, {"postId": 33776898}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> logoutTest() async {
  return test('Logout Test', () async {
    await apiDispatchTest(LOGOUT_API, {}).then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
  });
}

Future<void> followTest() async {
  return test('Follow Test', () async {
    await loginTestAccount();

    await apiDispatchTest(
            FOLLOW_API, {"type": "uid", "unfollow": true, "id": 807754})
        .then((map) {
      print(map.toString());
      expect(map['error'], null);
    });

    await apiDispatchTest(
            FOLLOW_API, {"type": "black", "unfollow": true, "id": 807754})
        .then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> userProfileTest() async {
  return test('UserProfile Test', () async {
    await apiDispatchTest(USER_PROFILE_API, {"uid": 445098, "type": 0})
        .then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
    await apiDispatchTest(USER_PROFILE_API, {"uid": 445098, "type": 1})
        .then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
    await apiDispatchTest(USER_PROFILE_API, {"uid": 445098, "type": 2})
        .then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
    await apiDispatchTest(USER_PROFILE_API, {"uid": 445098, "type": 3})
        .then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
  });
}

Future<void> searchTest() async {
  return test('Search Test', () async {
    await apiDispatchTest(SEARCH_API, {"search": "iOS", "type": 0, "sort": 0})
        .then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
    await apiDispatchTest(SEARCH_API, {"search": "小说", "type": 1, "sort": 0})
        .then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
    await apiDispatchTest(SEARCH_API, {"search": "小说", "type": 2, "sort": 0})
        .then((map) {
      print(map.toString());
      print(session.cookies.toString());
    });
  });
}

Future<void> personalDataTest() async {
  return test('Get Personal Data Test', () async {
    await loginTestAccount();

    await apiDispatchTest(MYDATA_API, {"mode": 0}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });

    await apiDispatchTest(MYDATA_API, {"mode": 1}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> punchCardTest() async {
  return test('Punch Card Test', () async {
    await loginTestAccount();

    await apiDispatchTest(PUNCHCARD_API, {}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> followListTest() async {
  return test('Get Follow List Test', () async {
    await apiDispatchTest(FOLLOWLIST_API, {}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> forumInfoTest() async {
  return test('Get Forum Info Test', () async {
    await apiDispatchTest(FORUM_INFO_API, {"id": 60}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
    await apiDispatchTest(FORUM_INFO_API, {"id": 1024}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> forumListTest() async {
  return test('Get Forum List Test', () async {
    await apiDispatchTest(FORUMLIST_API, {}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> threadContentTest() async {
  return test('Get Thread Content Test', () async {
    await apiDispatchTest(STORY_CONTENT_API, {"story": 2173241, "page": 0})
        .then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> threadInfoTest() async {
  return test('Get Thread Info Test', () async {
    await apiDispatchTest(STORY_INFO_API, {"story": 2173241}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> forumCheckNewTest() async {
  return test('Check New Forum Story Test', () async {
    await apiDispatchTest(FORUM_CHECKNEW_API, {"forumId": 60}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> forumStoryTest() async {
  return test('Get Forum Story List Test', () async {
    await apiDispatchTest(FORUM_THREADS_API, {"forumId": 60}).then((map) {
      print(map.toString());
      expect(map['error'], null);
    });
  });
}

Future<void> homelistTest() async {
  return test('Get Home List Test', () async {
    await apiDispatchTest(HOMELIST_API, {}).then((map) {
      print(map.toString());
      expect(map['error'], null);
      print(session.cookies.toString());
    });
  });
}

Future<void> checkNewTest() async {
  return test('Check New Notice Test', () async {
    await apiDispatchTest(CHECKNOTICE_API, {}).then((map) {
      print(map.toString());
      expect(map['error'], null);
      print(session.cookies.toString());
    });
  });
}

Future<void> hotlistTest() async {
  return test('Get Hot List Test', () async {
    await apiDispatchTest(HOTDIGEST_API, {}).then((map) {
      print(map.toString());
      expect(map['error'], null);
      print(session.cookies.toString());
    });
  });
}

Future<void> blacklistTest() async {
  return test('Get Blacklist Test', () async {
    await apiDispatchTest(GETBLACKLIST_API, {}).then((map) {
      print(map.toString());
      expect(map['error'], null);
      print(session.cookies.toString());
    });
  });
}

Future<void> pmSessionTest() async {
  return test('Get PM Session Test', () async {
    await apiDispatchTest(PMSESSION_API, {"pmid": 812695}).then((map) {
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

    await apiDispatchTest(LOGIN_API, {"user": user}).then((map) {
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
