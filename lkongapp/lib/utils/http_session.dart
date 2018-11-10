import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class HttpSession {
  Map<String, String> cookies = {};

  final String baseURL;
  http.Client client = http.Client();

  String get cookieLine {
    String line = "";
    String delim = "";
    cookies.forEach((key, value) {
      line += delim + "$key=$value";
      delim = "; ";
    });
    print("Send Cookie: $line");
    return line;
  }

  HttpSession({@required this.baseURL});

  Future<http.Response> get(String path) async {
    String url = baseURL + path;
    print("GET URL: $url");
    return client.get(url, headers: {'Cookie': cookieLine}).then((response) {
      updateCookie(response);
      return response;
    });
  }

  Future<http.Response> post(String path, {dynamic data}) async {
    String url = baseURL + path;
    print("POST URL: $url");
    return client.post(url, body: data, headers: {'Cookie': cookieLine}).then(
        (response) {
      updateCookie(response);
      return response;
    });
  }

  RegExp cookiePattern = RegExp("([^;,]*?=[^;,]*)", caseSensitive: false);
  RegExp attrPattern =
      RegExp("(Expires|Max-Age|Domain|Path|SameSite)", caseSensitive: false);

  void parseCookie(String rawCookie) {
    Iterable<Match> matches = cookiePattern.allMatches(rawCookie);
    matches.forEach((match) {
      String cookie = match.group(1);
      int index = cookie.indexOf('=');
      if (index > 0) {
        String key = cookie.substring(0, index);
        String value = cookie.substring(index + 1);
        if (!attrPattern.hasMatch(key)) {
          cookies[key] = value;
        }
      }
    });
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      print("Recv Cookie: $rawCookie");
      parseCookie(rawCookie);
    }
  }
}
