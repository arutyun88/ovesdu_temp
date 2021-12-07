import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalizationApp {
  final Locale locale;

  LocalizationApp(this.locale);

  static LocalizationApp of(BuildContext context) {
    return Localizations.of<LocalizationApp>(context, LocalizationApp);
  }

  static Map<String, String> _localizedValues;

  Future load() async {
    String jsonStringValues = await rootBundle
        .loadString('assets/translations/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslatedValue(String key) {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<LocalizationApp> delegate =
      _LocalizationAppDelegate();
}

class _LocalizationAppDelegate extends LocalizationsDelegate<LocalizationApp> {
  const _LocalizationAppDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['hy', 'ru', 'en', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<LocalizationApp> load(Locale locale) async {
    LocalizationApp localization = new LocalizationApp(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_LocalizationAppDelegate old) => false;
}
