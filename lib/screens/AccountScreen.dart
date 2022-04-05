import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/providers/AuthController.dart';
import 'package:shop_app/screens/MyOrdersScreen.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AuthControlller authControlller = Get.put(AuthControlller());
  bool switcher = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User user = authControlller.user;
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: headerProduct,
          title: Text('Профиль'),
          actions: [
            ThemeSwitcher(builder: (context) {
              return IconButton(
                  onPressed: () {
                    setState(() {
                      switcher = !switcher;
                    });
                    if (switcher == false) {
                      ThemeSwitcher.of(context)
                          .changeTheme(theme: ThemeData.light());
                    } else {
                      ThemeSwitcher.of(context)
                          .changeTheme(theme: ThemeData.dark());
                    }
                  },
                  icon: Icon(switcher ? Icons.light_mode : Icons.dark_mode));
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Get.to(MyOrdersScreen());
            },
            label: Text("Мои заказы")),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: TextFormField(
                  onChanged: (e) {},
                  decoration: InputDecoration(labelText: 'Имя'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: TextFormField(
                  onChanged: (e) {},
                  decoration: InputDecoration(
                    labelText: 'Фамилия',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: TextFormField(
                  onChanged: (e) {},
                  initialValue: user.name,
                  decoration: InputDecoration(
                    labelText: 'Nickname',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Container(
                      child: Icon(Icons.email),
                      margin: EdgeInsets.only(right: 30),
                    ),
                    Expanded(
                      child: TextFormField(
                        onChanged: (e) {},
                        initialValue: user.email,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Container(
                        child: Icon(Icons.phone),
                        margin: EdgeInsets.only(right: 30)),
                    Expanded(
                      child: TextFormField(
                        onChanged: (e) {},
                        decoration:
                            InputDecoration(labelText: 'Номер телефона'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
