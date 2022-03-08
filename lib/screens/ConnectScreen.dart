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
      isInDebugMode: true,
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
