import 'dart:async';

import 'package:lkongapp/actions/actions.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lkongapp/models/user.dart';
import 'package:lkongapp/utils/http_session.dart';

void main() {
  test('Cookie Test', () async {
    HttpSession session = HttpSession(baseURL: "");
    session.parseCookie(
        'dzsbhey=0Q0V002q; expires=Mon, 04-Nov-2019 08:27:01 GMT; path=/,auth=8278xNjrx3zTWKM9HcgidpRbrFX9PVVi612kEUBUM0CXEbLHOi5r8sWlQ02fYzWBvgYgRks3GEgMXS4mdmp9fnEZLjc; expires=Mon, 04-Nov-2019 08:27:01 GMT; path=/; httponly');

    print(session.cookies);
    print(session.cookieLine);
  });
}
