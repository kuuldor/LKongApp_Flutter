import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

class HttpSession {
  Map<String, String> cookies = {};

  final _storageFileName = 'coookie.jar';

  final bool persist;

  bool initialized = false;

  void saveCookies() {
    if (!persist) return;

    getApplicationDocumentsDirectory().then((Directory appDocDir) {
      String appStoragePath = getStorageFile(appDocDir);

      String cookieJ = json.encode(cookies);
      File(appStoragePath).writeAsString(cookieJ);
    }).catchError((e) {
      print(e.toString());
    });
  }

  String getStorageFile(Directory appDocDir) =>
      appDocDir.path + "/" + _storageFileName;

  void loadCookies() {
    if (!persist) return;

    getApplicationDocumentsDirectory().then((Directory appDocDir) {
      String appStoragePath = getStorageFile(appDocDir);
      return File(appStoragePath).readAsString();
    }).then((String cookieJ) {
      cookies = Map<String, String>.from(json.decode(cookieJ));
      initialized = true;
    }).catchError((e) {
      print(e.toString());
      initialized = true;
    });
  }

  final String baseURL;
  http.Client client = http.Client();

  String get cookieLine {
    String line = "";
    String delim = "";
    cookies.forEach((key, value) {
      line += delim + "$key=$value";
      delim = "; ";
    });
    // print("Send Cookie: $line");
    return line;
  }

  HttpSession({@required this.baseURL, this.persist}) {
    loadCookies();
  }

  Future<http.Response> get(String path) async {
    String url = baseURL + path;
    // print("GET URL: $url");
    return client.get(url, headers: {'Cookie': cookieLine}).then((response) {
      updateCookie(response);
      return response;
    });
  }

  Future<http.Response> post(String path, {dynamic data}) async {
    String url = baseURL + path;
    // print("POST URL: $url");
    return client.post(url, body: data, headers: {'Cookie': cookieLine}).then(
        (response) {
      updateCookie(response);
      return response;
    });
  }

  Future<http.StreamedResponse> uploadFile(String url, String file) async {
    // print("POST URL: $url");
    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);
    final octects = await http.MultipartFile.fromPath('image', file);
    request.files.add(octects);
    request.headers.addAll({'Cookie': cookieLine});
    return request.send().then((response) {
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
      // print("Recv Cookie: $rawCookie");
      parseCookie(rawCookie);
      saveCookies();
    }
  }
}
