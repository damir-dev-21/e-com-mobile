import 'package:path/path.dart';
import 'package:shop_app/models/Notif.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/User.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database _database;

  Future<Database> get db async => _database ??= await init();

  Future<Database> init() async {
    String dbPath = join(await getDatabasesPath(), 'user.db');
    var database = openDatabase(dbPath, version: 1, onCreate: _onCreateTables);
    return database;
  }

  void _onCreateTables(Database db, int version) {
    db.execute("""
        CREATE TABLE user(
          id INTEGER,
          name TEXT, 
          email TEXT, 
          password TEXT, 
          token TEXT
        ) 
    """);

    db.execute("""
        CREATE TABLE newProducts(
          id INTEGER,
          name TEXT,
          photo TEXT,
          description TEXT,
          price TEXT,
          categoryName TEXT,
          subcategoryName TEXT,
          count INTEGER
        ) 
    """);

    print('Tables was created!');
  }

  Future<void> insertNotif(Product product) async {
    Database _db = await init();
    await _db.insert('newProducts', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteUsers() async {
    Database _db = await init();
    await _db.delete('user');
  }

  Future<List<User>> getUser() async {
    var database = await db;
    List<Map<String, dynamic>> userMap = await database.query('user');

    return List.generate(userMap.length, (index) {
      return User(
        id: userMap[index]['id'],
        name: userMap[index]['name'],
        email: userMap[index]['email'],
        password: userMap[index]['password'],
        token: userMap[index]['token'],
      );
    });
  }

  Future<List<Product>> getNotif() async {
    var database = await db;
    List<Map<String, dynamic>> notifMap = await database.query('newProducts');

    return List.generate(notifMap.length, (index) {
      Product prod = Product(
          notifMap[index]['id'],
          notifMap[index]['name'],
          notifMap[index]['photo'],
          notifMap[index]['description'],
          notifMap[index]['price'],
          notifMap[index]['categoryName'],
          notifMap[index]['subcategoryName'],
          notifMap[index]['count']);

      return prod;
    });
  }
}
