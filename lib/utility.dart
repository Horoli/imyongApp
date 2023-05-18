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

  Future<BaseDeviceInfo> getPlatformInfo() async {
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      // print(webBrowserInfo.data);
      return webBrowserInfo;
    } else {
      late BaseDeviceInfo info;
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
        // print(androidDeviceInfo);
        info = androidDeviceInfo;
      }
      if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        // print(iosDeviceInfo);
        info = iosDeviceInfo;
      }
      // print('asd $info');
      return info;
    }
  }
}
