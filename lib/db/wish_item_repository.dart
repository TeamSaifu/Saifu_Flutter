import 'package:saifu/db/db_provider.dart';
import 'package:saifu/model/wish_item.dart';

class WishItemRepository {
  static String table = 'wish';
  static DBProvider instance = DBProvider.instance;

  static Future<WishItem> create({
    int price,
    String name,
    String url,
    String picture
  }) async {
    final Map<String, dynamic> row = {
      'price': price,
      'name': name,
      'url': url,
      'picture': picture,
    };

    final db = await instance.database;
    final id = await db.insert(table, row);

    return WishItem(
      id: id,
      price: price,
      name: name,
      url: url,
      picture: picture,
    );
  }

  static Future<List<WishItem>> getAll() async {
    final db = await instance.database;
    final rows = await db.rawQuery('SELECT * FROM $table ORDER BY id');

    if (rows.isEmpty) return null;

    return rows.map((e) => WishItem.fromMap(e)).toList();
  }

  static Future<int> update ({
    int id,
    int price,
    String name,
    String url,
    String picture,
  }) async {
    final row = {
      'id': id,
      'price': price,
      'name': name,
      'url': url,
      'picture': picture,
    };
    final db = await instance.database;
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
