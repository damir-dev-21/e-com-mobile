import 'dart:convert';

import 'package:get/get.dart';
import 'package:shop_app/constants/config.dart';
import 'package:shop_app/models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/providers/AuthController.dart';

class CartController extends GetxController {
  List<Product> products = [];

  var total = 0;

  List<Product> get items {
    return [...products];
  }

  void scaleTotal() {
    products.forEach((element) {
      var num = int.parse(element.price.split(',').join('')) * element.count;
      total = total + num;
      update();
    });
  }

  void addProduct(Product item) {
    var num = int.parse(item.price.split(',').join("")) * item.count;

    total = total + num;

    bool currentItem = false;

    for (var i in items) {
      currentItem = i.id == item.id;
      if (currentItem == true) {
        var findItem = i;
        findItem.count += item.count;
        break;
      }
    }

    if (currentItem == false) {
      products.add(item);
    }
    update();
  }

  void deleteProduct(int id) {
    Product item = products.firstWhere((element) => element.id == id);

    bool currentItem = false;

    for (var i in items) {
      currentItem = i.id == item.id;
      if (currentItem == true) {
        var findItem = i;
        if (findItem.count > 1) {
          findItem.count -= 1;
          total = 0;
        } else {
          products.removeWhere((element) => element.id == id);
          total = 0;
        }
        break;
      }
    }

    update();
    scaleTotal();
  }

  void sendOrder() async {
    var url = mainUrl + "/orders/create/";

    var productsList = [];

    final userController = Get.put(AuthControlller());

    items.forEach((element) {
      var newItem = {
        'product': element.id,
        'amount': element.price,
        'quantity': element.count
      };

      productsList.add(newItem);
    });

    Map<String, dynamic> body = {
      'buyer': userController.user.id,
      'cart': productsList,
      'success': false
    };

    print(userController.user.id);

    try {
      final request = await http.post(Uri.parse(url),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
            'token': userController.user.token
          });

      print(json.encode(body));

      products.clear();
      total = 0;
      update();
    } catch (e) {
      print(e);
    }
  }
}
