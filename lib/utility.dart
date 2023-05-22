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

  String convertSubject(String subjectEnString) {
    String subjectString = '';

    switch (subjectEnString) {
      case SUBJECT.KO:
        return subjectString = '국어';
      case SUBJECT.MATH:
        return subjectString = '수학';
      case SUBJECT.SOCIAL:
        return subjectString = '사회';
      case SUBJECT.SCIENCE:
        return subjectString = '과학';
      case SUBJECT.EN:
        return subjectString = '영어';
      case SUBJECT.MUSIC:
        return subjectString = '음악';
      case SUBJECT.ART:
        return subjectString = '미술';
      case SUBJECT.ETHICS:
        return subjectString = '도덕';
      case SUBJECT.PHYSICALEDU:
        return subjectString = '체육';
      case SUBJECT.PRACTICAL:
        return subjectString = '실과';
      case SUBJECT.GENERAL:
        return subjectString = '총/창/안';
    }

    return subjectString;
  }
}
