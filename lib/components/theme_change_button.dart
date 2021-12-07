import 'package:flutter/material.dart';
import 'package:ovesdu/provider/theme_provider.dart';
import 'package:ovesdu/util/constants/color_constants.dart';
import 'package:ovesdu/util/size_config.dart';
import 'package:provider/provider.dart';

class ThemeChangeButton extends StatefulWidget {
  const ThemeChangeButton({Key key}) : super(key: key);

  @override
  _ThemeChangeButtonState createState() => _ThemeChangeButtonState();
}

class _ThemeChangeButtonState extends State<ThemeChangeButton> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      width: getProportionateScreenWidth(20),
      height: getProportionateScreenWidth(20),
      child: GestureDetector(
        onTap: () async {
          await themeProvider.toggleThemeData();
          setState(() {});
        },
        child: themeProvider.isLightTheme
            ? Icon(
                Icons.wb_sunny,
                color: lightThemeLogoAndThemeChangeColor,
                size: getProportionateScreenWidth(20),
              )
            : Icon(
                Icons.circle,
                color: darkThemeLogoAndThemeChangeColor,
                size: getProportionateScreenWidth(12),
              ),
      ),
    );
  }
}
