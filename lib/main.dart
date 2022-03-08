import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constants/theme.dart';
import 'package:shop_app/screens/ConnectScreen.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: themeData,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: ConnectScreen(),
      ),
    );
  }
}
