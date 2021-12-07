import 'package:flutter/cupertino.dart';
import 'package:ovesdu/localization/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getTranslated(BuildContext context, String key) {
  return LocalizationApp.of(context).getTranslatedValue(key);
}

const String ARMENIAN = 'hy';
const String RUSSIAN = 'ru';
const String ENGLISH = 'en';
const String FRANCE = 'fr';

const String LANGUAGE_CODE = 'language_code';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale _temp;
  switch (languageCode) {
    case ARMENIAN:
      _temp = Locale(languageCode, 'AM');
      break;
    case RUSSIAN:
      _temp = Locale(languageCode, 'RU');
      break;
    case ENGLISH:
      _temp = Locale(languageCode, 'US');
      break;
    case FRANCE:
      _temp = Locale(languageCode, 'FR');
      break;
    default:
      _temp = Locale(ENGLISH, 'US');
  }
  return _temp;
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LANGUAGE_CODE) ?? ENGLISH;
  return _locale(languageCode);
}

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final String kEmailNullError = "Please enter your email";
final String kInvalidEmailError = "Please enter valid email";
final String kPassNullError = "Please enter your password";
final String kShortPassError = "Password is too short";
final String kMatchPassError = "Password don't match";
