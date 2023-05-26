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
      if (Platform.isWindows) {
        WindowsDeviceInfo windowsDeviceInfo = await deviceInfo.windowsInfo;
        // print(windowsDeviceInfo);
        info = windowsDeviceInfo;
      }
      return info;
    }
  }

  String convertSubject(String subjectEnterString) {
    switch (subjectEnterString) {
      case SUBJECT.KO:
        return '국어';
      case SUBJECT.MATH:
        return '수학';
      case SUBJECT.SOCIAL:
        return '사회';
      case SUBJECT.SCIENCE:
        return '과학';
      case SUBJECT.EN:
        return '영어';
      case SUBJECT.MUSIC:
        return '음악';
      case SUBJECT.ART:
        return '미술';
      case SUBJECT.ETHICS:
        return '도덕';
      case SUBJECT.PHYSICALEDU:
        return '체육';
      case SUBJECT.PRACTICAL:
        return '실과';
      case SUBJECT.GENERAL:
        return '총창안';
    }
    return '';
  }
}
