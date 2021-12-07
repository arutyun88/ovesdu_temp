import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ovesdu/provider/theme_provider.dart';
import 'package:ovesdu/components/left_menu_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // Получение свойств темы
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: themeProvider.themeData().appBarTheme.color,
          ),
          LeftMenu(),
          //
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: value),
            duration: Duration(milliseconds: 200),
            curve: Curves.decelerate,
            builder: (_, double val, __) {
              return (Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..setEntry(0, 3, 200 * val)
                  ..rotateY((pi / 6) * val),
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(
                      'OvesDu',
                      style: TextStyle(
                          fontSize: width * 0.07, fontWeight: FontWeight.bold),
                    ),
                  ),
                  body: Column(
                    children: [
                      SizedBox(
                        height: width * 0.5,
                      ),
                      Center(
                        child: Text(
                          'Hello, my friend!',
                          style: TextStyle(
                            fontSize: width * .1,
                            color: themeProvider.themeData().primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
            },
          ),
          GestureDetector(
            onHorizontalDragUpdate: (e) {
              if (e.delta.dx > 0) {
                setState(() {
                  value = 1;
                });
              } else {
                setState(() {
                  value = 0;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
