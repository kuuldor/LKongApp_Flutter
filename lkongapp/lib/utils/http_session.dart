import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class LKongHttpSession {
  Map<String, String> cookies = {};

  final _storageFileName = 'coookie.jar';

  final String appDocDir;

  final bool persist;

  bool initialized = false;

  void saveCookies() {
    if (!persist) return;

    try {
      String appStoragePath = getStorageFile();

      String cookieJ = json.encode(cookies);
      File(appStoragePath).writeAsString(cookieJ);
    } catch (e) {
      print(e.toString());
    }
  }

  String getStorageFile() => appDocDir + "/" + _storageFileName;

  void loadCookies() {
    if (!persist) {
      initialized = true;
      return;
    }

    try {
      String appStoragePath = getStorageFile();

      File(appStoragePath).readAsString().then((String cookieJ) {
        cookies = Map<String, String>.from(json.decode(cookieJ));
        initialized = true;
      }).catchError((e) {
        print(e.toString());
        initialized = true;
      });
    } catch (e) {
      print(e.toString());
    }
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

  LKongHttpSession(
      {@required this.baseURL, @required this.appDocDir, this.persist: false}) {
    loadCookies();
  }

  Future<http.Response> get(String path) async {
    String url = baseURL + path;
    return getURL(url, headers: {'Cookie': cookieLine}).then((response) {
      updateCookie(response);
      return response;
    });
  }

  Future<http.Response> post(String path, {dynamic data}) async {
    String url = baseURL + path;
    // print("POST URL: $url");
    return postToURL(url, data: data, headers: {'Cookie': cookieLine})
        .then((response) {
      updateCookie(response);
      return response;
    });
  }

  Future<http.StreamedResponse> uploadFile(
      String url, String field, String file,
      {Map<String, String> headers, Map<String, String> fields}) async {
    // print("Upload URL: $url");
    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);
    final octects = await http.MultipartFile.fromPath(field, file);
    request.files.add(octects);
    request.headers.addAll({'Cookie': cookieLine});

    if (headers != null) {
      request.headers.addAll(headers);
    }

    if (fields != null) {
      request.fields.addAll(fields);
    }

    return request.send().then((response) {
      return response;
    });
  }

  Future<http.Response> getURL(String url,
      {Map<String, String> headers: const {}}) async {
    // print("GET URL: $url");
    return client.get(url, headers: headers);
  }

  Future<http.Response> postToURL(String url,
      {dynamic data, Map<String, String> headers: const {}}) async {
    // print("POST URL: $url");
    return client.post(url, body: data, headers: headers);
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
