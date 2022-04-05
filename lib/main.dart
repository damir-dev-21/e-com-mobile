import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constants/theme.dart';
import 'package:shop_app/screens/ConnectScreen.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

void main() {
  AwesomeNotifications()
      .initialize('resource://drawable/ic_launcher_foreground', [
    NotificationChannel(
        channelKey: 'basic_chanel',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: ''),
  ]);
  runApp(MyApp());
}

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
