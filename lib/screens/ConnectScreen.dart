import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/providers/AuthController.dart';
import 'package:shop_app/screens/AuthScreen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/services/background_fetch.dart';
import 'package:workmanager/workmanager.dart';

class ConnectScreen extends StatefulWidget {
  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  @override
  void initState() {
    super.initState();
    Workmanager.initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );

    Workmanager.registerPeriodicTask(
      "1",
      fetchBackground,
      frequency: Duration(minutes: 20),
    );

    Workmanager.registerPeriodicTask(
      "2",
      dropUser,
      frequency: Duration(hours: 3),
    );

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Разрешить уведомление'),
            content: Text('Приложение поддерживает фоновое уведомление'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Не разрешить',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Разрешить',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthControlller authControlller = Get.put(AuthControlller());

    return GetBuilder<AuthControlller>(
        init: AuthControlller(),
        builder: (_) =>
            authControlller.isAuth ? ProductsOverviewScreen() : AuthScreen());
  }
}
