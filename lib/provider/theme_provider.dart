import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:ovesdu/util/constants/color_constants.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;

  ThemeProvider({this.isLightTheme});

  // Переключение темы
  toggleThemeData() async {
    final settings = await Hive.openBox('settings');
    settings.put('isLightTheme', !isLightTheme);
    isLightTheme = !isLightTheme;
    notifyListeners();
  }

  // Глобальная тема. Проверка, включена ли светлая тема
  ThemeData themeData() {
    return isLightTheme ? _lightTheme : _darkTheme;
  }
}

ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: lightThemePrimaryColor,
  iconTheme: IconThemeData(color: lightThemeIconThemeColor),
  appBarTheme: AppBarTheme(
    color: darkThemeLogoAndThemeChangeColor,
    textTheme: TextTheme(
        headline6: TextStyle(
      color: lightThemeLogoAndThemeChangeColor,
      fontWeight: FontWeight.bold,
    )),
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: lightThemeLogoAndThemeChangeColor),
  ),
  // fontFamily: "Custom",
);

ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: darkThemePrimaryColor,
  iconTheme: IconThemeData(color: darkThemeIconThemeColor),
  appBarTheme: AppBarTheme(
    color: lightThemeLogoAndThemeChangeColor,
    textTheme: TextTheme(
        headline6: TextStyle(
      color: darkThemeLogoAndThemeChangeColor,
      fontWeight: FontWeight.bold,
    )),
    elevation: 0,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: darkThemeLogoAndThemeChangeColor),
  ),
  // fontFamily: "Custom",
);
