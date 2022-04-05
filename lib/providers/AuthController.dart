import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants/config.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/models/UserOrder.dart';
import 'package:shop_app/providers/Carts.dart';
import 'package:shop_app/providers/Products.dart';
import 'package:shop_app/screens/AuthScreen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/services/database_helper.dart';
import 'package:sqflite/sqflite.dart';

DatabaseHelper db = DatabaseHelper();
CartController cartController = Get.put(CartController());
Products productsController = Get.put(Products());

class AuthControlller extends GetxController {
  User user;

  bool isAuth = false;
  bool isLoad = false;

  List<UserOrder> userOrders = [];

  @override
  void onInit() {
    getStatus();
    getUserOrders();
    super.onInit();
  }

  void getUserOrders() async {
    var url = mainUrl + '/myorders/';
    try {
      var responce =
          await http.post(Uri.parse(url), body: {'id': user.id.toString()});
      String body = utf8.decode(responce.bodyBytes);

      final result = json.decode(body) as List<dynamic>;
      result.forEach((value) {
        final item = userOrders.firstWhere(
            (element) => element.orderId == value['order'],
            orElse: () => UserOrder(404, 404, 404, [], 0));

        if (item.id == 404) {
          var total = 0;
          List<Product> orderProducts = [];
          final Product product = productsController.items
              .firstWhere((element) => element.id == value['product']);
          product.count = value['quantity'];

          orderProducts.add(product);

          orderProducts.forEach((element) {
            var num =
                int.parse(element.price.split(',').join('')) * element.count;
            total = total + num;
            update();
          });

          UserOrder orderItem = UserOrder(
              value['id'], value["order"], value["user"], orderProducts, total);
          userOrders.add(orderItem);
        } else {
          final Product product = productsController.items
              .firstWhere((element) => element.id == value['product']);
          product.count = value['quantity'];
          var total =
              int.parse(product.price.split(',').join('')) * product.count;

          item.products.add(product);
          item.total = item.total + total;
          update();
        }

        update();
      });
    } catch (e) {
      print(e);
    }
  }

  void getStatus() async {
    List<User> users = await DatabaseHelper().getUser();

    if (users.first.token != null) {
      isAuth = true;

      user = User(
        id: users.first.id,
        name: users.first.name,
        email: users.first.email,
        password: users.first.password,
        token: users.first.token,
      );

      update();
    }
  }

  void login(String name, String email, String password) async {
    var url = mainUrl + "/login/";
    isLoad = true;
    update();
    try {
      final responce = await http.post(Uri.parse(url),
          body: {'name': name, 'email': email, 'password': password});

      String body = utf8.decode(responce.bodyBytes);

      final result = json.decode(body) as Map<String, dynamic>;

      if (result['message'] != null && result['jwt'] != null) {
        isAuth = true;
        isLoad = false;

        Database db = await DatabaseHelper().db;

        user = User(
            id: result['user']['id'],
            name: name,
            email: email,
            password: password,
            token: result['jwt']);

        await db.insert('user', user.toMap());

        Get.to(ProductsOverviewScreen());
        update();
      } else {
        isLoad = false;
        isAuth = false;
        update();
      }
    } catch (e) {
      isLoad = false;

      update();
      throw e;
    }
  }

  void reg(String name, String email, String password) async {
    var url = mainUrl + "/register/";
    isLoad = true;
    try {
      final responce = await http.post(Uri.parse(url),
          body: {'name': name, 'email': email, 'password': password});

      String body = utf8.decode(responce.bodyBytes);

      final result = json.decode(body) as Map<String, dynamic>;

      if (result['message'] == 'success') {
        isAuth = true;
        isLoad = false;
        Get.to(AuthScreen());
        update();
      } else {
        isLoad = false;
        update();
      }
    } catch (e) {
      isLoad = false;
      update();
      throw e;
    }
  }

  void logout() async {
    var url = mainUrl + "/logout/";
    Database db = await DatabaseHelper().db;
    try {
      final responce =
          await http.post(Uri.parse(url), headers: {'jwt': user.token});
      String body = utf8.decode(responce.bodyBytes);

      final result = json.decode(body) as Map<String, dynamic>;
      if (result['message'] == 'success') {
        isAuth = false;
        cartController.products = [];
        cartController.total = 0;
        await db.rawDelete('DELETE FROM user WHERE name = ?', [user.name]);
        Get.to(AuthScreen());

        update();
      }
    } catch (e) {}
  }
}

// [
//     {
//         "id": 12,
//         "order": 9,
//         "user": 1,
//         "product": 229,
//         "amount": "2,000,000",
//         "quantity": 1
//     },
//     {
//         "id": 13,
//         "order": 10,
//         "user": 1,
//         "product": 4,
//         "amount": "330,000",
//         "quantity": 2
//     },
//     {
//         "id": 14,
//         "order": 10,
//         "user": 1,
//         "product": 163,
//         "amount": "9,780,750",
//         "quantity": 1
//     },
//     {
//         "id": 15,
//         "order": 10,
//         "user": 1,
//         "product": 330,
//         "amount": "3,564,000",
//         "quantity": 1
//     }
// ]