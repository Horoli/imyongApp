import 'package:flutter/material.dart';
import 'color.dart' as COLOR;

enum Type { green, dark, light }

final Map<Type, ThemeData> MAP = {
  Type.green: GREEN,
  Type.light: LIGHT,
  Type.dark: DARK,
};

List<Type> get TYPE_LIST => MAP.keys.toList();
List<ThemeData> get THEMEDATA_LIST => MAP.values.toList();

final ThemeData LIGHT = ThemeData.light().copyWith();

final ThemeData DARK = ThemeData.dark().copyWith(
  primaryColor: Colors.grey[500],
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.grey[700]),
    ),
  ),
);

final ThemeData GREEN = ThemeData.light().copyWith(
  primaryColor: COLOR.BASE_GREEN,
  appBarTheme: const AppBarTheme(color: COLOR.BASE_GREEN),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    // backgroundColor: COLOR.BASE_GREEN,
    selectedItemColor: COLOR.BASE_GREEN,
    // unselectedItemColor: Colors.white54,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(COLOR.BASE_GREEN),
    ),
  ),
);
