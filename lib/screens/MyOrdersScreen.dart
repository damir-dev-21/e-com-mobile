import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/providers/AuthController.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  bool modalWindow = false;
  int showBox;

  void openShowBox(id) {
    setState(() {
      showBox = id;
      modalWindow = !modalWindow;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthControlller authControlller = Get.put(AuthControlller());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: headerProduct,
        title: Text('Мои заказы'),
        actions: [],
      ),
      body: Column(
        children: [
          GetBuilder<AuthControlller>(
              init: AuthControlller(),
              builder: (ctx) {
                return Expanded(
                    child: ListView.builder(
                        itemCount: authControlller.userOrders.length,
                        itemBuilder: (ctx, index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            width: MediaQuery.of(context).size.width,
                            height: authControlller.userOrders[index].orderId ==
                                        showBox &&
                                    modalWindow
                                ? 220
                                : 60,
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(6)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        "Заказ №" +
                                            authControlller
                                                .userOrders[index].orderId
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          openShowBox(authControlller
                                              .userOrders[index].orderId);
                                        },
                                        icon: Icon(
                                            authControlller.userOrders[index]
                                                            .orderId ==
                                                        showBox &&
                                                    modalWindow
                                                ? Icons.arrow_upward
                                                : Icons.arrow_downward,
                                            size: 18))
                                  ],
                                ),
                                authControlller.userOrders[index].orderId ==
                                            showBox &&
                                        modalWindow
                                    ? Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                            Expanded(
                                              child: ListView.builder(
                                                  itemCount: authControlller
                                                      .userOrders[index]
                                                      .products
                                                      .length,
                                                  itemBuilder: (ctx, i) {
                                                    return Container(
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      child: Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundImage: NetworkImage(
                                                                authControlller
                                                                    .userOrders[
                                                                        index]
                                                                    .products[i]
                                                                    .photo),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2,
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                              child: Text(
                                                                  authControlller
                                                                      .userOrders[
                                                                          index]
                                                                      .products[
                                                                          i]
                                                                      .name),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3),
                                                              color: Color(
                                                                  0xFFFFFFFF),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Кол-во: ' +
                                                                      authControlller
                                                                          .userOrders[
                                                                              index]
                                                                          .products[
                                                                              i]
                                                                          .count
                                                                          .toString(),
                                                                ),
                                                                Text(
                                                                  'Цена: ' +
                                                                      authControlller
                                                                          .userOrders[
                                                                              index]
                                                                          .products[
                                                                              i]
                                                                          .price
                                                                          .toString(),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: appBarColor,
                                                  borderRadius:
                                                      BorderRadius.circular(3)),
                                              child: Text(
                                                "Общая сумма: " +
                                                    authControlller
                                                        .userOrders[index].total
                                                        .toString() +
                                                    ' сум',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ]))
                                    : SizedBox()
                              ],
                            ),
                          );
                        }));
              })
        ],
      ),
    );
  }
}
