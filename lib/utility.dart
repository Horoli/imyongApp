part of 'common.dart';

class Utility {
  Uri getRequestUri(String path) => Uri.parse(p.join(PATH.URL, path));

  Future<void> wait(int? milliseconds) {
    milliseconds ??= 0;
    return Future.delayed(Duration(milliseconds: milliseconds));
  }

  Map<String, String> createHeaders({String? tokenKey, String? tokenValue}) {
    Map<String, String> headers = {
      HEADER.CONTENT_TYPE: HEADER.JSON,
    };
    if (tokenKey != null) {
      headers[tokenKey] = tokenValue!;
    }

    return headers;
  }
}
