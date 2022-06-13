import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:shop_app/constants/config.dart';
import 'package:shop_app/models/Category.dart';
import 'package:shop_app/models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/providers/AuthController.dart';
import 'package:shop_app/services/database_helper.dart';
import 'package:sqflite/sqflite.dart';

DatabaseHelper db = DatabaseHelper();
AuthControlller authControlller = Get.put(AuthControlller());

class Products extends GetxController {
  final List<Product> _items = [];
  final List<Category> _categories = [];
  final List<String> _categoriesName = [];
  List<Product> _popularOrCategory = [];
  List<Product> _searchedItem = [];
  List<Product> _categoryItems = [];
  List<Product> _newItems = [];

  @override
  void onInit() {
    getProducts();
    getNewProducts();
    update();
    super.onInit();
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get searchedItem {
    return [..._searchedItem];
  }

  List<Product> get categoryItems {
    return [..._categoryItems];
  }

  List<Product> get search {
    return [..._items];
  }

  List<Product> get popularOrCategory {
    return [..._popularOrCategory];
  }

  List<Product> get newsItems {
    return [..._newItems];
  }

  List<Category> get categories {
    return [..._categories];
  }

  List<String> get categoriesName {
    return [..._categoriesName];
  }

  Product findById(id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addProduct(Product item) {
    _items.add(item);
    update();
  }

  void addPopularOrCategory(Product item) {
    _popularOrCategory.add(item);
    update();
  }

  void addNewItems(Product item) {
    _newItems.add(item);
    update();
  }

  void addCategoryItem(Product item) {
    _categoryItems.add(item);
    update();
  }

  void addCategory(Category item) {
    _categories.add(item);
    update();
  }

  void addCategoryName(String item) {
    _categoriesName.add(item);
    update();
  }

  void setCategoryItems(List<String> titles) {
    _popularOrCategory = [];
    titles.forEach((i) {
      items.forEach((j) {
        if (i == j.categoryName) {
          addPopularOrCategory(j);
        }
      });
    });
  }

  void searchedCart(String str) {
    _popularOrCategory = [];
    _items.forEach((element) {
      var item = element.name.contains(str);
      if (item) {
        addPopularOrCategory(element);
      }
    });
    update();
  }

  void getCategoryItem(String nameOfCategory) {
    _items.forEach((element) {
      if (element.subcategoryName == nameOfCategory) {
        addCategoryItem(element);
      }
    });
    update();
  }

  Future<void> getProducts() async {
    var url = mainUrl + '/products/';

    try {
      final responce = await http.get(Uri.parse(url));

      String body = utf8.decode(responce.bodyBytes);
      final extractedData = json.decode(body) as List<dynamic>;

      extractedData.forEach((element) {
        Product product = Product(
            element['id'],
            element["name"],
            element["photo"],
            element["description"],
            element["price"],
            element["category_name"],
            element["subcategory_name"],
            0);

        Category category = categories.firstWhere(
            (e) => e.categoryName == product.categoryName,
            orElse: () =>
                Category(id: 0, categoryName: 'false', subcategoryList: []));

        String categoryName = categoriesName.firstWhere(
            (element) => element == product.categoryName,
            orElse: () => 'false');

        if (categoryName == 'false') {
          addCategoryName(product.categoryName);
        }

        if (category.categoryName == 'false' &&
            category.subcategoryList.isEmpty) {
          List<String> subList = [];

          subList.add(product.subcategoryName);

          Category obj = Category(
              id: product.id,
              categoryName: product.categoryName,
              subcategoryList: subList);
          addCategory(obj);
        }
        if (category.categoryName == product.categoryName &&
            category.subcategoryList.isNotEmpty) {
          Category currentCategory = categories.firstWhere(
              (element) => element.categoryName == category.categoryName);
          if (!currentCategory.subcategoryList
              .contains(product.subcategoryName)) {
            currentCategory.subcategoryList.add(product.subcategoryName);
          }
          update();
        }

        addProduct(product);
      });

      authControlller.getUserOrders();

      update();
    } catch (e) {
      print(e);
    }

    int i = 0;

    while (i < 10) {
      Random random = new Random();
      int randomNumber = random.nextInt(items.length);
      addPopularOrCategory(items[randomNumber]);
      i = i + 1;
    }
  }

  Future<void> getNewProducts() async {
    var urlNew = mainUrl + '/status/';
    try {
      var responceNewProd = await http.get(Uri.parse(urlNew));

      String bodyNew = utf8.decode(responceNewProd.bodyBytes);
      final extractedDataNew = json.decode(bodyNew) as List<dynamic>;
      Database current_db = await DatabaseHelper().db;
      final newItems = await db.getNotif();

      if (newItems.isNotEmpty) {
        newItems.forEach((element) {
          addNewItems(element);
        });
      } else if (extractedDataNew.isNotEmpty) {
        extractedDataNew.forEach((element) async {
          Product product = Product(
              element['id'],
              element["name"],
              element["photo"],
              element["description"],
              element["price"],
              element["category_name"],
              element["subcategory_name"],
              0);
          update();
          await db.insertNotif(product);
          addNewItems(product);
        });
      } else {
        Random random = new Random();
        int randomNumber = random.nextInt(items.length);
        var i = 0;
        while (i < 3) {
          addNewItems(items[randomNumber]);
          update();
        }
        update();
      }
      update();
    } catch (e) {
      print(e);
    }
  }
}
