import 'package:shop_app/models/Product.dart';

class UserOrder {
  final int id;
  final int orderId;
  final int userId;
  final List<Product> products;
  int total;

  UserOrder(this.id, this.orderId, this.userId, this.products, this.total);
}
