import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:ovesdu/localization/localization.dart';
import 'package:ovesdu/provider/theme_provider.dart';
import 'package:ovesdu/routs.dart';
import 'package:ovesdu/screens/screens.dart';
import 'package:ovesdu/util/constants/constants.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';

void main() async {
  // Конфигурация получения профайдера тем в процессе работы
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  final settings = await Hive.openBox('settings');
  bool isLightTheme = settings.get('isLightTheme') ?? false;
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(isLightTheme: isLightTheme),
    child: AppStart(),
  ));
}

// to ensure we have the theme provider before the app starts lets make a few more changes
class AppStart extends StatefulWidget {
  const AppStart({Key key}) : super(key: key);

  @override
  _AppStartState createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return OvesDuApp(
      themeProvider: themeProvider,
      context: context,
    );
  }
}

class OvesDuApp extends StatefulWidget with WidgetsBindingObserver {
  final ThemeProvider themeProvider;
  final BuildContext context;

  const OvesDuApp(
      {Key key, @required this.themeProvider, @required this.context})
      : super(key: key);

  static void setLocale(BuildContext context, Locale locale) {
    _OvesDuAppState state = context.findAncestorStateOfType<_OvesDuAppState>();
    state.setLocale(locale);
  }

  @override
  _OvesDuAppState createState() => _OvesDuAppState();
}

class _OvesDuAppState extends State<OvesDuApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OvesDu App',
        theme: widget.themeProvider.themeData(),
        locale: _locale,
        supportedLocales: [
          Locale('hy', 'AM'),
          Locale('ru', 'RU'),
          Locale('en', 'US'),
          Locale('fr', 'FR')
        ],
        localizationsDelegates: [
          LocalizationApp.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        home: SplashScreen(),
        initialRoute: SplashScreen.routeName,
        routes: routes,
      );
    }
  }
}
