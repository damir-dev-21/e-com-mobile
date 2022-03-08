import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/providers/Carts.dart';
import 'package:shop_app/widgets/message_widget.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FToast ftoast;

  @override
  void initState() {
    super.initState();
    ftoast = FToast();
    ftoast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: headerProduct,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              child: Icon(Icons.arrow_back),
            ),
          ),
          title: Text('Корзина'),
          actions: [
            Center(
                child: Row(
              children: [
                Text(
                  "Общ сумма:",
                ),
                GetBuilder<CartController>(
                    init: CartController(),
                    builder: (_) {
                      return Container(
                          padding: EdgeInsets.all(3),
                          margin: EdgeInsets.all(3),
                          color: Colors.white,
                          child: Text(
                            ' ${cartController.total.toString()}',
                            style: TextStyle(color: Colors.black),
                          ));
                    })
              ],
            ))
          ],
        ),
        floatingActionButton: TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith((states) => newsButton)),
            onPressed: () {
              if (cartController.items.length > 0) {
                cartController.sendOrder();
                ftoast.showToast(
                    child: toast('ORDER', 'Заказ успешно оформлен'),
                    toastDuration: Duration(seconds: 4),
                    positionedToastBuilder: (context, child) {
                      return Align(
                        child: child,
                        alignment: Alignment.center,
                      );
                    });
              }
            },
            child: Text(
              "Оформить заказ",
              style: TextStyle(color: Colors.white),
            )),
        body: SafeArea(
          child: GetBuilder<CartController>(
              init: CartController(),
              builder: (_) {
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartController.items.length,
                      itemBuilder: (ctx, i) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(width: 0.5, color: Colors.grey)),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 3),
                          child: ListTile(
                            leading: Container(
                              child: Image.network(
                                cartController.items[i].photo,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(cartController.items[i].name,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                )),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Цена: ${cartController.items[i].price}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "Количество: ${cartController.items[i].count.toString()}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ]),
                            trailing: GestureDetector(
                              onTap: () {
                                cartController
                                    .deleteProduct(cartController.items[i].id);
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }),
        ),
      ),
    );
  }
}
