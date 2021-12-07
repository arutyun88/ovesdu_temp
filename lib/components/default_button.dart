import 'package:flutter/material.dart';
import 'package:ovesdu/provider/theme_provider.dart';
import 'package:ovesdu/util/size_config.dart';

import '../util/constants/constants.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function press;
  final ThemeProvider themeProvider;

  const DefaultButton({
    Key key,
    @required this.themeProvider,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(4))),
      color: themeProvider.isLightTheme
          ? lightThemeLogoAndThemeChangeColor
          : darkThemeLogoAndThemeChangeColor,
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
            fontSize: getProportionateScreenWidth(5),
            color: !themeProvider.isLightTheme
                ? lightThemeLogoAndThemeChangeColor
                : darkThemeLogoAndThemeChangeColor),
      ),
    );
  }
}
