import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  final _databaseName = "Saifu.db";
  final _databaseVersion = 1;

  // make this singleton class
  DBProvider._();
  static final DBProvider instance = DBProvider._();

  // only have a single app-wide reference to the database
  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  //this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        print('ok');
        var batch = db.batch();
        await _createTable(batch);
        await batch.commit();
      },
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  void _createTable(Batch batch) {
    batch.execute('''
      CREATE TABLE category(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        picture TEXT
      )
    ''');
    batch.execute('''
      CREATE TABLE log(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        input_date TEXT NOT NULL,
        pay_date TEXT NOT NULL,
        name TEXT,
        price INTEGER NOT NULL,
        category INTEGER,
        picture TEXT,
        sign INTEGER NOT NULL,
        split_count INTEGER NOT NULL,
        FOREIGN KEY(category) REFERENCES category(id) ON DELETE SET NULL
      )
    ''');
    batch.execute('''
      CREATE TABLE budget(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        sign INTEGER,
        price INTEGER
      )
    ''');
    batch.execute('''
      CREATE TABLE shortcut(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price INTEGER NOT NULL,
        category INTEGER,
        sign INTEGER NOT NULL
      )
    ''');
    batch.execute('''
      CREATE TABLE wish(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price INTEGER,
        url TEXT,
        picture TEXT
      )
    ''');
    batch.execute('''
      CREATE TABLE notification(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT,
        picture TEXT
      )
    ''');
    batch.execute('''
      INSERT INTO category VALUES(1, '食費', '%')
    ''');
  }
}