import 'package:sqflite/sqflite.dart';

//データの定義
class SaifuDB {
  final int id;
  final String name;
  final String category;
  final String inputDate;
  final String payDate;
  final int price;
  final int splitCount;

  SaifuDB(
      {this.id,
      this.name,
      this.category,
      this.inputDate,
      this.payDate,
      this.price,
      this.splitCount});

  static get path => null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'inputDate': inputDate,
      'payDate': payDate,
      'price': price,
      'splitCount': splitCount
    };
  }

  @override
  String toString() {
    return 'SaifuDB{id: $id, name: $name, category: $category, inputDate: $inputDate, payDate: $payDate, price: $price, splitCount: $splitCount}';
  }

//データベース作成
//   static Future<Database> get database async {
//     final Future<Database> _database = openDatabase(
//       join(await getDatabasesPath(), 'memo_database.db'),
//       onCreate: (db, version) {
//         return db.execute(
//           "create table if not exists log (inputDate primary key,payDate,name,price,category,splitCount,picture,sign)",
//         );
//       },
//       version: 1,
//     );
//     return _database;
//   }
// }

  static Future<Database> get databese async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      path.join(dbPath, 'saifu_db'),
      onCreate: (db, version) async {
        await db.execute(
            'create table if not exists log (inputDate primary key,payDate,name,price,category,splitCount,picture,sign)');
        await db.execute(
            'create table if not exists category (id INTEGER primary key AUTOINCREMENT,name,picture)');
        await db.execute(
            'create table if not exists notification (id INTEGER primary key AUTOINCREMENT,content,picture)');
        await db.execute(
            'create table if not exists shortcut (id INTEGER primary key AUTOINCREMENT,name,price,category,sign)');
        await db.execute(
            'create table if not exists wish (id INTEGER primary key AUTOINCREMENT,name,price,url,picture)');
      },
      version: 1,
    );
  }
}
