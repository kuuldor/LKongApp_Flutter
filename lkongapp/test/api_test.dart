import 'dart:async';

import 'package:lkongapp/actions/actions.dart';
import 'package:test/test.dart';

import 'package:lkongapp/models/user.dart';
import 'package:lkongapp/middlewares/api.dart';

void main() {
  test('Login Test', () async {
    UserBuilder builder = UserBuilder()
      ..identity = 'lkongapp@outlook.com'
      ..password = 'LKong!5app';

    User user = builder.build();
    final Completer<Null> completer = new Completer<Null>();
    var request = LoginRequest(completer, user);

    await login({"user": user}).then((map) {
      print(map.toString());
      expect(map['uid'], 812695);
      expect(map['success'], true);
      LoginSuccess response = createResponseAction(request, map);
      expect(response.runtimeType, LoginSuccess);
      print(response.user.toString());
    });
  });

    test('Get Home List Test', () async {
    final Completer<Null> completer = new Completer<Null>();

    await getHomeList({}).then((map) {
      print(map.toString());
    });
  });
}
