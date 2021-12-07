import 'package:flutter/widgets.dart';
import 'package:ovesdu/screens/screens.dart';
import 'package:ovesdu/screens/sign_in/sign_in_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
};
