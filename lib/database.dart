import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// -----------------------------------------------
//  データベースクラス
// -----------------------------------------------
//
//  読み取り専用で呼び出す場合
//  val database = SQLiteDB.readableDatabase
//  書き込みありで呼び出す場合
//  val database = SQLiteDB.writableDatabase
//
//  SELECTやINSERTやUPDATEとかは
//
//  https://qiita.com/NaoSekig/items/0d95d631378040c1961a
//
//  ここをみてね

//データの定義
class Memo {
  final int id;
  final String name;
  final String category;
  final String inputDate;
  final String payDate;
  final int price;
  final int splitCount;

  Memo(
      {this.id,
      this.name,
      this.category,
      this.inputDate,
      this.payDate,
      this.price,
      this.splitCount});

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
    return 'Memo{id: $id, name: $name, category: $category, inputDate: $inputDate, payDate: $payDate, price: $price, splitCount: $splitCount}';
  }

//データベース作成

  static Future<Database> get database async {
    final Future<Database> _database = openDatabase(
      join(await getDatabasesPath(), 'memo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "create table if not exists log (inputDate primary key,payDate,name,price,category,splitCount,picture,sign)",
        );
      },
      version: 1,
    );
    return _database;
  }
}
