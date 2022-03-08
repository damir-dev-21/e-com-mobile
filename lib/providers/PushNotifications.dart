import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/constants/config.dart';
import 'package:shop_app/models/Notif.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/services/database_helper.dart';

DatabaseHelper db = DatabaseHelper();

class PushNotificationsController extends GetxController {
  List<Notif> _items = [];

  @override
  void onInit() {
    getLastNewProd();
    super.onInit();
  }

  List<Notif> get items {
    return [..._items];
  }

  void addNotif(Notif item) {
    _items.add(item);

    update();
  }

  void setItems(items) async {
    Future.forEach(
        items, (element) => _items.removeWhere((el) => element.id == el.id));

    Future.forEach(items, (element) => addNotif(element));
    update();
  }

  void getLastNewProd() async {
    var url = mainUrl + '/status/';
    final items = await db.getNotif();
    if (items.isEmpty) {
      try {
        var responce = await http.get(Uri.parse(url));
        String body = utf8.decode(responce.bodyBytes);
        final extractedData = json.decode(body) as List<dynamic>;

        extractedData.forEach((element) async {
          Product product = Product(
              element['id'],
              element["name"],
              element["photo"],
              element["description"],
              element["price"],
              element["category_name"],
              element["subcategory_name"],
              0);

          Notif notif = Notif(
              product.id,
              DateFormat('dd.MM.yyyy kk:mm').format(DateTime.now()),
              product,
              'New Item');

          var obj = {
            product.id,
            DateTime.now().toString(),
            product.toMap().toString(),
            'New Item'
          };

          addNotif(notif);
          await db.insertNotif(obj);
        });
        update();
      } catch (e) {
        print(e);
      }
    } else {
      setItems(items);
    }
  }
}
