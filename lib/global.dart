part of 'common.dart';

// ignore: constant_identifier_names
enum TabItem { Home, Wish, ProcessRate, QnA }

final HelperNavigator GHelperNavigator = HelperNavigator.getInstance();
final GlobalKey<NavigatorState> GNavigatorKey = GlobalKey<NavigatorState>();

// TODO : 유틸리티 class
final Utility GUtility = Utility();

// TODO : theme는 global에서 instance 생성
final ServiceTheme GServiceTheme = ServiceTheme.getInstance();

// TODO : 나머지 서비스들은 splash에서 instance 생성
late ServiceGuest GServiceGuest;
late ServiceMGuestLogin GServiceGuestLogin;
late ServiceMainCategory GServiceMainCategory;
late ServiceSubCategory GServiceSubCategory;
late ServiceQuestion GServiceQuestion;

late final SharedPreferences GSharedPreferences;

final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
AndroidId androidId = AndroidId();

TStream<bool> $loading = TStream<bool>()..sink$(false);
