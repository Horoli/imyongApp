import 'package:flutter/material.dart';
import 'package:imyong_app/common.dart';
import 'package:imyong_app/service/lib.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'preset/router.dart' as ROUTER;
// import 'preset/color.dart' as COLOR;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initService();
  await _initLocalStorage();
  runApp(AppRoot());
}

Future<void> _initLocalStorage() async {
  GSharedPreferences = await SharedPreferences.getInstance();
}

Future<void> _initService() async {
  GServiceGuestLogin = ServiceMGuestLogin.getInstance();
  GServiceGuest = ServiceGuest.getInstance();
  GServiceMainCategory = ServiceMainCategory.getInstance();
  GServiceSubCategory = ServiceSubCategory.getInstance();
  GServiceQuestion = ServiceQuestion.getInstance();
}
