import 'package:lkongapp/utils/http_session.dart';

HttpSession session;

String appVersion = "1.1.3";

void initGlobals({bool testing: false}) {
  session = HttpSession(baseURL: 'http://lkong.cn', persist: !testing);
}
