import 'package:flutter/material.dart';
import 'package:ovesdu/provider/theme_provider.dart';
import 'package:ovesdu/util/constants/constants.dart';
import 'package:ovesdu/util/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSuffixIcon extends StatelessWidget {
  const CustomSuffixIcon({
    Key key,
    @required this.themeProvider,
    @required this.svgIcon,
  }) : super(key: key);

  final ThemeProvider themeProvider;
  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(5),
        getProportionateScreenWidth(5),
        getProportionateScreenWidth(5),
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: getProportionateScreenWidth(5),
        color: themeProvider.isLightTheme
            ? lightThemeLogoAndThemeChangeColor
            : darkThemeLogoAndThemeChangeColor,
      ),
    );
  }
}
