import 'package:shop_app/models/Product.dart';

class Cart {
  List<Product> products;
  int userId;
  int total;
  bool success;

  Cart({this.products, this.userId, this.total, this.success});
}
