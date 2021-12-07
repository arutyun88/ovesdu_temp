import 'package:flutter/material.dart';
import 'package:ovesdu/provider/theme_provider.dart';
import 'package:ovesdu/util/constants/constants.dart';
import 'package:ovesdu/util/size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    @required this.themeProvider,
    @required this.text,
    @required this.imageAddress,
    @required this.functionText,
  }) : super(key: key);

  final ThemeProvider themeProvider;
  final String text;
  final String imageAddress;
  final String functionText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ThemeChangeButton(),
        Spacer(
          flex: 5,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: getProportionateScreenWidth(5)),
        ),
        Spacer(
          flex: 5,
        ),
        Image.asset(
          // сделать блок Stateful-виджетом (картинка должна меняться в зависимости от темы)
          imageAddress,
          width: getProportionateScreenWidth(100),
          color: themeProvider.isLightTheme
              ? lightThemeLogoAndThemeChangeColor
              : darkThemeLogoAndThemeChangeColor,
        ),
        Spacer(
          flex: 6,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            functionText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: getProportionateScreenWidth(5)),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
