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
        var batch = db.batch();
        _createTable(batch);
        await batch.commit();
      },
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  void _createTable(Batch batch) {
    batch.execute(
        '''CREATE TABLE input_text(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        body TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      ) '''
    );
  }
}