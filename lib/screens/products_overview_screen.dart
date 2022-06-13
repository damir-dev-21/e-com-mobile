import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/providers/AuthController.dart';
import 'package:shop_app/providers/Carts.dart';
import 'package:shop_app/providers/Products.dart';
import 'package:shop_app/providers/PushNotifications.dart';
import 'package:shop_app/screens/CartScreen.dart';
import 'package:shop_app/screens/PushNotificationScreen.dart';
import 'package:shop_app/services/ui_builders.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/home/category_filter.dart';
import 'package:shop_app/widgets/home/product_grid_overview.dart';
import 'package:shop_app/widgets/home/search_input.dart';
import 'package:shop_app/widgets/home/slider_widget.dart';

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final Products productsController = Get.put(Products());

  @override
  void initState() {
    Get.put(AuthControlller()).getUserOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Products pNotController = Get.put(Products());
    final cartController = Get.put(CartController());

    return ThemeSwitchingArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: buildAppBar(cartController, pNotController),
          drawer: AppDrawer(),
          body: Column(children: [
            SliderWidget(productsController: productsController),
            CategoryFilter(),
            SearchInput(),
            TopItems(),
            Flexible(child: ProductsGridOverview()),
          ])),
    );
  }

  AppBar buildAppBar(CartController cartController, Products pNotController) {
    return AppBar(
      backgroundColor: appBarColor,
      title: Text('Магазин'),
      iconTheme: IconThemeData(color: Colors.black),
      actions: [
        Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Get.to(CartScreen());
                  }),
              GetBuilder<CartController>(
                  init: CartController(),
                  builder: (_) {
                    return Positioned(
                      top: 15,
                      right: 5,
                      child: Container(
                        alignment: Alignment.topCenter,
                        width: 15,
                        height: 10,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          cartController.items.length.toString(),
                          style: TextStyle(color: Colors.black, fontSize: 7.5),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Get.to(PushNotificationScreen());
                }),
            GetBuilder<Products>(
                init: Products(),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
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
    );
  }
}
