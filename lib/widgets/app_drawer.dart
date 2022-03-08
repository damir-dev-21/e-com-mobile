import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/providers/AuthController.dart';
import 'package:shop_app/providers/Products.dart';
import 'package:shop_app/screens/AccountScreen.dart';
import 'package:shop_app/screens/CategoryScreen.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final Products productController = Get.put(Products());
  final AuthControlller authControlller = Get.put(AuthControlller());
  int showBox;
  bool openMenu = false;

  void openShowBox(id) {
    setState(() {
      showBox = id;
      openMenu = true;
    });
  }

  // ignore: missing_return
  Widget getIcon(String name) {
    if (name == 'Электроника') {
      return Icon(Icons.devices_rounded);
    }
    if (name == 'Мебель') {
      return Icon(Icons.weekend_rounded);
    }
    if (name == 'Бытовая техника') {
      return Icon(Icons.kitchen_rounded);
    }
    if (name == 'Дом и сад') {
      return Icon(Icons.other_houses_sharp);
    }
    if (name == 'Детские товары') {
      return Icon(Icons.child_friendly);
    }
    if (name == 'Строительство и ремонт') {
      return Icon(Icons.build_rounded);
    }
    if (name == 'Мототранспорт') {
      return Icon(Icons.motorcycle_rounded);
    }
    if (name == 'Оборудование') {
      return Icon(Icons.tv);
    }
    if (name == 'Спортивные товары') {
      return Icon(Icons.fitness_center_sharp);
    }
    if (name == 'Автотовары') {
      return Icon(Icons.drive_eta_rounded);
    }
    if (name == 'Одежда, обувь и аксессуары') {
      return Icon(Icons.spa);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(
                        height: 550,
                        child: ListView.builder(
                            itemCount: productController.categories.length,
                            itemBuilder: (ctx, i) {
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: productController.categories[i].id ==
                                              showBox &&
                                          openMenu
                                      ? Color(0xFFEAEBEB)
                                      : Colors.transparent,
                                ),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (productController
                                                    .categories[i].id ==
                                                showBox &&
                                            openMenu == true) {
                                          setState(() {
                                            openMenu = false;
                                          });
                                        } else {
                                          openShowBox(productController
                                              .categories[i].id);
                                        }
                                      },
                                      child: ListTile(
                                        leading: getIcon(productController
                                            .categories[i].categoryName),
                                        title: Text(productController
                                            .categories[i].categoryName),
                                        trailing: GestureDetector(
                                            onTap: () {
                                              if (productController
                                                          .categories[i].id ==
                                                      showBox &&
                                                  openMenu == true) {
                                                setState(() {
                                                  openMenu = false;
                                                });
                                              } else {
                                                openShowBox(productController
                                                    .categories[i].id);
                                              }
                                            },
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: productController
                                                              .categories[i]
                                                              .id ==
                                                          showBox &&
                                                      openMenu
                                                  ? Color(0xFFF6846A)
                                                  : Color(0xFFA6A6AD),
                                            )),
                                      ),
                                    ),
                                    showBox ==
                                                productController
                                                    .categories[i].id &&
                                            openMenu
                                        ? AnimatedContainer(
                                            duration: Duration(seconds: 2),
                                            height: 150,
                                            child: ListView.builder(
                                                itemCount: productController
                                                    .categories[i]
                                                    .subcategoryList
                                                    .length,
                                                itemBuilder: (ctx, j) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Get.to(CategoryScreen(),
                                                          arguments:
                                                              productController
                                                                  .categories[i]
                                                                  .subcategoryList[j]);
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                        left: 50,
                                                        top: 10,
                                                      ),
                                                      child: Text(
                                                        productController
                                                            .categories[i]
                                                            .subcategoryList[j],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          )
                                        : SizedBox.shrink()
                                  ],
                                ),
                              );
                            }))
                  ],
                ),
              ),
              Divider(
                height: 2,
              ),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Get.to(AccountScreen());
                      },
                      leading: Image.asset(
                        'assets/images/иконки/account.png',
                        color: Colors.grey,
                        width: 30,
                        height: 30,
                      ),
                      title: Text('Профиль'),
                    ),
                    ListTile(
                      leading: Image.asset(
                        'assets/images/иконки/settings.png',
                        color: Colors.grey,
                        width: 30,
                        height: 30,
                      ),
                      title: Text('Настройки'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: ListTile(
                        onTap: () {
                          authControlller.logout();
                        },
                        leading: Image.asset(
                          'assets/images/logout.png',
                          color: Colors.grey,
                          width: 30,
                          height: 30,
                        ),
                        title: Text('Выйти'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
