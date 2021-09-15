import 'package:saifu/db/db_provider.dart';
import 'package:saifu/model/budget.dart';
import "package:intl/intl.dart";

class BudgetRepository {
  static String table = 'budget';
  static DBProvider instance = DBProvider.instance;

  static final _dateFormatter = DateFormat("y/M/d");
  static DateTime toDateTime(String datetimeStr){
    DateTime result;

    try {
      result = _dateFormatter.parseStrict(datetimeStr);
    } catch(e){
      // 変換に失敗した場合の処理
    }
    return result;
  }

  static Future<Budget> create({
    int price,
    String name,
    int sign
  }) async {
    final Map<String, dynamic> row = {
      'price': price,
      'name': name,
      'sign': sign,
    };

    final db = await instance.database;
    final id = await db.insert(table, row);

    return Budget(
      id: id,
      price: price,
      name: name,
      sign: sign,
    );
  }

  static Future<List<Budget>> getAll() async {
    final db = await instance.database;
    final rows = await db.rawQuery('SELECT * FROM $table ORDER BY id');

    if (rows.isEmpty) return null;

    return rows.map((e) => Budget.fromMap(e)).toList();
  }

  static Future<List<Budget>> getWhereSign({int sign}) async {
    final db = await instance.database;
    final rows = await db.rawQuery('SELECT * FROM $table WHERE sign = $sign ORDER BY id');

    if (rows.isEmpty) return null;

    return rows.map((e) => Budget.fromMap(e)).toList();
  }

  static Future<int> update ({
    int id,
    int price,
    String name,
    int sign
  }) async {
    final row = {
      'id': id,
      'price': price,
      'name': name,
      'sign': sign,
    };
    final db = await instance.database;
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
