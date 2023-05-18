import 'package:flutter/material.dart';
import 'package:imyong_app/common.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imyong_app/service/lib.dart';
import 'package:imyong_app/model/lib.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tnd_pkg_widget/tnd_pkg_widget.dart';
import 'preset/router.dart' as ROUTER;
// import 'preset/color.dart' as COLOR;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initService();
  await _initLocalStorage();
  runApp(AppRoot());
}

Future<void> _initLocalStorage() async {
  localStorage = LocalStorage('local.json');
}

Future<void> _initService() async {
  GServiceGuestLogin = ServiceMGuestLogin.getInstance();
  GServiceGuest = ServiceGuest.getInstance();
  GServiceMainCategory = ServiceMainCategory.getInstance();
  GServiceSubCategory = ServiceSubCategory.getInstance();
  GServiceQuestion = ServiceQuestion.getInstance();
}
