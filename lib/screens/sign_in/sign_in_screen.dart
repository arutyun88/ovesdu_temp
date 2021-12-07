import 'package:flutter/material.dart';
import 'package:ovesdu/screens/sign_in/body.dart';
import 'package:ovesdu/util/size_config.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(fontSize: getProportionateScreenWidth(5)),
        ),
      ),
      body: Body(),
    );
  }
}
