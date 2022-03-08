class Product {
  final int id;
  final String name;
  final String photo;
  final String description;
  final String price;
  final String categoryName;
  final String subcategoryName;
  int count;

  Product(this.id, this.name, this.photo, this.description, this.price,
      this.categoryName, this.subcategoryName, this.count);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'description': description,
      'price': price,
      'categoryName': categoryName,
      'subcategoryName': subcategoryName,
      'count': count,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['id'] as int,
      json['name'] as String,
      json['photo'] as String,
      json['description'] as String,
      json['price'] as String,
      json['categoryName'] as String,
      json['subcategoryName'] as String,
      json['count'] as int,
    );
  }
}
