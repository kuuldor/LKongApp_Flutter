import 'package:lkongapp/utils/http_session.dart';

HttpSession session;

void initGlobals({bool testing: false}) {
  session = HttpSession(baseURL: 'http://lkong.cn' , persist: !testing);
}
