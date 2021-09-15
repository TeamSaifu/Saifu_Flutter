import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saifu/db/db_provider.dart';
import 'package:saifu/model/log.dart';
import "package:intl/intl.dart";

class LogRepository {
  static String table = 'log';
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

  static Future<PayLog> create({
    @required int price,
    @required int sign,
    DateTime payDay,
    String name,
    int category,
    String picture,
    int splitCount
  }) async {
    final DateTime now = DateTime.now();
    final Map<String, dynamic> row = {
      'input_date': now.toString(),
      'pay_date': payDay != null ? payDay.toString() : now.toString(),
      'price': price,
      'name': name != null ? name : '',
      'category': category != null ? category : 0,
      'picture': picture != null ? picture : '',
      'sign': sign,
      'split_count': splitCount != null ? splitCount : 1
    };

    final db = await instance.database;
    final id = await db.insert(table, row);

    return PayLog(
      id: id,
      inputDate: now,
      // payDate: toDateTime(row["pay_date"]),
      payDate: DateTime.parse(row["pay_date"]).toLocal(),
      price: price,
      name: row["name"],
      category: row["category"],
      picture: row["picture"],
      sign: sign,
      splitCount: row["splitCount"],
    );
  }
  
  static Future<List<PayLog>> getAll() async {
    final db = await instance.database;
    final rows = await db.rawQuery('SELECT * FROM $table ORDER BY pay_date DESC');

    if (rows.isEmpty) return null;

    return rows.map((e) => PayLog.fromMap(e)).toList();
  }

  static Future<List<PayLog>> getToday() async {
    String startToday = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final db = await instance.database;
    final rows = await db.rawQuery('SELECT * FROM $table WHERE pay_date >= $startToday  ORDER BY pay_date DESC');

    if (rows.isEmpty) return null;

    return rows.map((e) => PayLog.fromMap(e)).toList();
  }

  static Future<int> update ({
    int id,
    int price,
    DateTime payDay,
    String name,
    int category,
    String picture,
    int sign,
    int splitCount
  }) async {
    final DateTime now = DateTime.now();
    final row = {
      'id': id,
      'input_date': now.toString(),
      'pay_date': payDay,
      'price': price,
      'name': name,
      'category': category,
      'picture': picture != null ? picture : '',
      'sign': sign,
      'split_count': splitCount
    };
    final db = await instance.database;
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
