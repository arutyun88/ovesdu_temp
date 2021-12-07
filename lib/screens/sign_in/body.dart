import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ovesdu/components/custom_suffix_icon.dart';
import 'package:ovesdu/components/default_button.dart';
import 'package:ovesdu/components/form_error.dart';
import 'package:ovesdu/provider/theme_provider.dart';
import 'package:ovesdu/util/constants/constants.dart';
import 'package:ovesdu/util/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(5),
          ),
          child: Column(
            children: [
              Text(
                "Welcome Back",
                style: TextStyle(
                    color: themeProvider.isLightTheme
                        ? lightThemeLogoAndThemeChangeColor
                        : darkThemeLogoAndThemeChangeColor,
                    fontSize: getProportionateScreenWidth(5),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Sigh in with your email and password\nor continue with social media',
                textAlign: TextAlign.center,
              ),
              SignForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignForm extends StatefulWidget {
  SignForm({Key key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          buildEmailFormField(
            themeProvider,
            "Email",
            "Enter your email",
            "assets/icons/email.svg",
          ),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          buildPasswordFormField(
            themeProvider,
            "Password",
            "Enter your password",
            "assets/icons/padlock.svg",
          ),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          FormError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DefaultButton(
                themeProvider: themeProvider,
                text: 'Continue',
                press: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  TextFormField buildEmailFormField(ThemeProvider themeProvider,
      String labelText, String hintText, String svgIcon) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        }
        if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
          });
        }
        return null;
      },
      decoration:
          buildInputDecoration(labelText, hintText, themeProvider, svgIcon),
    );
  }

  TextFormField buildPasswordFormField(ThemeProvider themeProvider,
      String labelText, String hintText, String svgIcon) {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.length >= 8 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
        } else if (value.length < 8 && !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
        }
        return null;
      },
      decoration:
          buildInputDecoration(labelText, hintText, themeProvider, svgIcon),
    );
  }

  InputDecoration buildInputDecoration(
    String labelText,
    String hintText,
    ThemeProvider themeProvider,
    String svgIcon,
  ) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(15),
        vertical: getProportionateScreenWidth(5),
      ),
      enabledBorder: _buildOutlineInputBorder(themeProvider),
      focusedBorder: _buildOutlineInputBorder(themeProvider),
      suffixIcon: CustomSuffixIcon(
        themeProvider: themeProvider,
        svgIcon: svgIcon,
      ),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder(ThemeProvider themeProvider) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(getProportionateScreenWidth(25)),
      borderSide: BorderSide(
          color: themeProvider.isLightTheme
              ? lightThemeLogoAndThemeChangeColor
              : darkThemeLogoAndThemeChangeColor),
      gapPadding: 10,
    );
  }
}
