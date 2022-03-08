import 'package:shop_app/models/Product.dart';

class Notif {
  final int id;
  final String date;
  final Product product;
  final String message;

  Notif(this.id, this.date, this.product, this.message);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'product': product.toMap(),
      'message': message,
    };
  }

  factory Notif.fromJson(Map<String, dynamic> json) {
    return Notif(json['id'] as int, json['date'] as String,
        json['product'] as Product, json['message'] as String);
  }
}
