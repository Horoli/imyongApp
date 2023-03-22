part of 'common.dart';

// ignore: constant_identifier_names
enum TabItem { Home, Wish, ProcessRate, QnA }

const String baseURL = 'http://localhost:3000';

final HelperNavigator GHelperNavigator = HelperNavigator.getInstance();
final GlobalKey<NavigatorState> GNavigatorKey = GlobalKey<NavigatorState>();

Uri getRequestUri(String path) => Uri.parse(p.join(baseURL, path));

final ServiceTheme GServiceTheme = ServiceTheme.getInstance();
// late ServiceType GServiceType;
late ServiceGuest GServiceGuest;
late ServiceMGuestLogin GServiceGuestLogin;
late ServiceMainCategory GServiceMainCategory;
late ServiceSubCategory GServiceSubCategory;
late ServiceQuestion GServiceQuestion;

late final Box<MGuestLogin> hiveMGuestLogin;

Map<String, String> createHeaders({String? tokenKey, String? tokenValue}) {
  Map<String, String> headers = {
    HEADER.CONTENT_TYPE: HEADER.JSON,
  };
  if (tokenKey != null) {
    headers[tokenKey] = tokenValue!;
  }

  return headers;
}
