import 'package:flutter/material.dart';
import 'package:ovesdu/main.dart';
import 'package:ovesdu/provider/theme_provider.dart';
import 'package:ovesdu/screens/sign_in/sign_in_screen.dart';
import 'package:ovesdu/screens/splash/components/splash_content.dart';
import 'package:ovesdu/util/constants/constants.dart';
import 'package:ovesdu/components/default_button.dart';
import 'package:ovesdu/util/language.dart';
import 'package:ovesdu/util/size_config.dart';
import 'package:ovesdu/util/constants/text_constants.dart';
import 'package:ovesdu/components/theme_change_button.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "welcome",
      "image": "assets/images/ararat2.png",
      "description": "language_choise",
    },
    {
      "text": "color_description",
      "image": "assets/images/ararat2.png",
      "description": "theme_choise",
    },
    {
      "text": "other_description",
      "image": "assets/images/ararat2.png",
      "description": "other_info",
    },
  ];

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    OvesDuApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Spacer(
                      // flex: 5,
                      ),
                  Text(
                    getTranslated(context, 'app_name'),
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                        color: themeProvider.isLightTheme
                            ? lightThemeLogoAndThemeChangeColor
                            : darkThemeLogoAndThemeChangeColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  themeProvider: themeProvider,
                  text: getTranslated(context, splashData[index]["text"]),
                  imageAddress: splashData[index]["image"],
                  functionText:
                      getTranslated(context, splashData[index]["description"]),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: DropdownButton<Language>(
                            iconSize: 20,
                            hint: Text(
                              getTranslated(context, 'change_language'),
                              style: TextStyle(color: lightAndDarkHintColor),
                            ),
                            onChanged: (Language language) {
                              _changeLanguage(language);
                            },
                            items: Language.languageList()
                                .map<DropdownMenuItem<Language>>(
                                    (e) => DropdownMenuItem<Language>(
                                          value: e,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                e.name,
                                                style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenWidth(
                                                          5),
                                                ),
                                              ),
                                              // Text(e.flag)
                                            ],
                                          ),
                                        ))
                                .toList(),
                          ),
                        ),
                        ThemeChangeButton(),
                      ],
                    ),
                  ),
                  _buildDot(themeProvider),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DefaultButton(
                          themeProvider: themeProvider,
                          text: 'Continue',
                          press: () {
                            Navigator.pushNamed(
                                context, SignInScreen.routeName);
                          },
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Image.asset(
                    // сделать блок Stateful-виджетом (картинка должна меняться в зависимости от темы)
                    "assets/images/ararat5.png",
                    width: getProportionateScreenWidth(100),
                    color: themeProvider.isLightTheme
                        ? lightThemeLogoAndThemeChangeColor
                        : darkThemeLogoAndThemeChangeColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildDot(ThemeProvider themeProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        splashData.length,
        (index) => AnimatedContainer(
          duration: kThemeAnimationDuration,
          margin: EdgeInsets.only(
              right: getProportionateScreenHeight(0.3),
              left: getProportionateScreenHeight(0.3)),
          height: getProportionateScreenHeight(2),
          width: currentPage == index
              ? getProportionateScreenHeight(8)
              : getProportionateScreenHeight(4),
          decoration: BoxDecoration(
              color: themeProvider.isLightTheme
                  ? getColorsDotLight(currentPage, index)
                  : getColorsDotDark(currentPage, index),
              borderRadius:
                  BorderRadius.circular(getProportionateScreenHeight(1))),
        ),
      ),
    );
  }

  Color getColorsDotLight(int currentPage, int index) => currentPage == index
      ? lightThemeLogoAndThemeChangeColor
      : lightAndDarkHintColor;

  Color getColorsDotDark(int currentPage, int index) => currentPage == index
      ? darkThemeLogoAndThemeChangeColor
      : lightAndDarkHintColor;
}
