import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_queries.dart';

class DatabaseProvider {
  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;

  const DatabaseProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _init();
      return _database;
    }
  }

  Future<Database> _init() async {
    final String documentsDirectory = await getDatabasesPath();
    final String path = join(documentsDirectory, 'JeraChallenge.db');
    final Function onCreateFunction = (Database db, int version) async {
      for (String query in DatabaseQueries.queries) {
        await db.execute(query);
      }
    };

    return await openDatabase(path, version: 1, onCreate: onCreateFunction);
  }
}
