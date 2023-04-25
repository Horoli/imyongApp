part of 'common.dart';

// ignore: constant_identifier_names
enum TabItem { Home, Wish, ProcessRate, QnA }

final HelperNavigator GHelperNavigator = HelperNavigator.getInstance();
final GlobalKey<NavigatorState> GNavigatorKey = GlobalKey<NavigatorState>();

Uri getRequestUri(String path) => Uri.parse(p.join(PATH.URL, path));

Future<void> wait(int? milliseconds) {
  if (milliseconds == null) milliseconds = 0;
  return Future.delayed(Duration(milliseconds: milliseconds));
}

final ServiceTheme GServiceTheme = ServiceTheme.getInstance();
// late ServiceType GServiceType;
late ServiceGuest GServiceGuest;
late ServiceMGuestLogin GServiceGuestLogin;
late ServiceMainCategory GServiceMainCategory;
late ServiceSubCategory GServiceSubCategory;
late ServiceQuestion GServiceQuestion;

late final Box<MGuestLogin> hiveMGuestLogin;

TStream<bool> $loading = TStream<bool>()..sink$(false);

Map<String, String> createHeaders({String? tokenKey, String? tokenValue}) {
  Map<String, String> headers = {
    HEADER.CONTENT_TYPE: HEADER.JSON,
  };
  if (tokenKey != null) {
    headers[tokenKey] = tokenValue!;
  }

  return headers;
}
