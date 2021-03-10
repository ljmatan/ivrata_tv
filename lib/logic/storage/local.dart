/// Used to save videos either as favorites or in order to watch them later.
/// jsonEncode function is used to encode all parameter data to a string object,
/// while images are saved in byte format.

import 'package:sqflite/sqflite.dart';

abstract class DB {
  static Database _instance;
  static Database get instance => _instance;

  static Future<void> init() async {
    final String dbPath = (await getDatabasesPath()) + 'db.dart';
    _instance = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Saved ('
          'id INTEGER PRIMARY KEY, '
          'videoID INTEGER, '
          'savedVideoEncoded TEXT, '
          'image BLOB'
          ')',
        );
      },
    );
  }
}
