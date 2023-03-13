part of 'common.dart';

// ignore: constant_identifier_names
enum TabItem { Home, Wish, ProcessRate, QnA }

const String baseURL = 'http://localhost:3000';

final HelperNavigator GHelperNavigator = HelperNavigator.getInstance();
final GlobalKey<NavigatorState> GNavigatorKey = GlobalKey<NavigatorState>();

Uri getRequestUri(String path) => Uri.parse(p.join(baseURL, path));

// final ServiceTheme GServiceTheme = ServiceTheme.getInstance();
// late ServiceType GServiceType;
// late ServiceLogin GServiceLogin;
// late ServiceGuest GServiceGuest;
// late ServiceMainCategory GServiceMainCategory;
// late ServiceSubCategory GServiceSubCategory;

// late final Box<MLogin> hiveMLogin;
