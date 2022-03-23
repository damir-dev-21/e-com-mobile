import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/providers/Products.dart';
import 'package:shop_app/providers/PushNotifications.dart';
import 'package:shop_app/screens/PushNotificationScreen.dart';
import 'package:shop_app/screens/product_page.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String title = Get.arguments as String;
  TextEditingController _textSearch = TextEditingController();

  Products productsController = Get.put(Products());
  List<Product> items = [];
  List<Product> searchedItems = [];

  void addItems() {
    productsController.items.forEach((element) {
      if (element.subcategoryName == title) {
        setState(() {
          items.add(element);
        });
      }
    });
  }

  void searchItem(String str) {
    setState(() {
      items = items
          .where((element) =>
              element.name.toLowerCase().contains(str.toLowerCase()))
          .toList();
      if (items.isEmpty) {
        addItems();
      }
      if (str == '') {
        items.clear();
        addItems();
      }
    });
  }

  @override
  void initState() {
    addItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PushNotificationsController pNotController =
        Get.put(PushNotificationsController());
    return ThemeSwitchingArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: headerProduct,
          title: Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      Get.to(PushNotificationScreen());
                    }),
                GetBuilder<PushNotificationsController>(
                    init: PushNotificationsController(),
                    builder: (_) {
                      return Positioned(
                        top: 15,
                        right: 7,
                        child: pNotController.items.isNotEmpty
                            ? Container(
                                alignment: Alignment.topCenter,
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  '!',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Container(
                                alignment: Alignment.topCenter,
                                width: 15,
                                height: 10,
                              ),
                      );
                    }),
              ],
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    controller: _textSearch,
                    onChanged: (e) {
                      searchItem(e);
                    },
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.black),
                        labelText: 'Поиск',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        )),
                  )),
              Flexible(
                  child: GridView.builder(
                      padding: EdgeInsets.all(20),
                      itemCount: searchedItems.length > 0
                          ? searchedItems.length
                          : items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.5,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 25,
                      ),
                      itemBuilder: (ctx, i) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            child: GridTile(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      pageBuilder: (context, animation, _) {
                                    return ProductPage(
                                      id: items[i].id,
                                    );
                                  }));
                                },
                                child: Image.network(
                                  items[i].photo,
                                ),
                              ),
                              footer: GridTileBar(
                                backgroundColor: Colors.white,
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      items[i].name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      items[i].price.toString() + '\$',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
