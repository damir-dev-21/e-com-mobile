import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/providers/Carts.dart';
import 'package:shop_app/providers/Products.dart';
import 'package:shop_app/screens/CartScreen.dart';
import 'package:shop_app/services/ui_builders.dart';
import 'package:shop_app/widgets/message_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({this.id}) : super();

  final int id;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool openDesc = false;
  FToast fToast;

  var count = 1;

  void changeOpen() {
    setState(() {
      openDesc = !openDesc;
    });
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final productsController = Get.put(Products());
    final product = productsController.findById(widget.id);
    final cartController = Get.put(CartController());
    Product currentProduct = Product(
        product.id,
        product.name,
        product.photo,
        product.description,
        product.price,
        product.categoryName,
        product.subcategoryName,
        count);
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: headerProduct,
          title: Text(product.name.toString()),
          actions: [
            GetBuilder<CartController>(
                init: CartController(),
                builder: (_) {
                  return Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        IconButton(
                            color: Color(0xFF2D3A40),
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Get.to(CartScreen());
                            }),
                        Positioned(
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 7.5),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(color: headerProduct),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                        minWidth: 170,
                        height: 45,
                        color: Color(0xFF2D3A40),
                        onPressed: () {},
                        child: Text(
                          'Добавить в желаемое',
                          style: TextStyle(color: Colors.white),
                        )),
                    FlatButton(
                        minWidth: 170,
                        height: 45,
                        color: newsButton,
                        onPressed: () {
                          cartController.addProduct(currentProduct);
                        },
                        child: Text(
                          'Добавить в корзину',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  children: [
                    Hero(
                      tag: product.name,
                      child: Container(
                          width: double.infinity,
                          // width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.amber),
                          child: Image.network(
                            product.photo,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )),
                    ),
                    Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            Container(
                              color: Colors.grey,
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 13),
                              child: Text('${product.price.toString()} сум',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            onPressed: changeOpen),
                        Text('Описание',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16))
                      ],
                    ),
                    openDesc
                        ? Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(25),
                            color: Colors.white,
                            child: Text(
                              product.description,
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                            ),
                          )
                        : SizedBox.shrink()
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Количество:',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          color: Colors.white,
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        if (count != 1) {
                                          count = count - 1;
                                        }
                                      });
                                    },
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.black),
                                    )),
                                Center(
                                  child: Text(
                                    count.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        count = count + 1;
                                      });
                                    },
                                    child: Center(
                                      child: Text(
                                        "+",
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.black),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  cartController.addProduct(currentProduct);

                  fToast.showToast(
                      child: toast('CART', 'Товар добавлен в корзину'),
                      toastDuration: Duration(seconds: 2),
                      positionedToastBuilder: (context, child) {
                        return Align(
                          alignment: Alignment.center,
                          child: child,
                        );
                      });
                },
                child: Container(
                    width: 200,
                    height: 50,
                    color: headerProduct,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Добавить в корзину',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ),
              ShareBuilder()
            ],
          ),
        )),
      ),
    );
  }
}
