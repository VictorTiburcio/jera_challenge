import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/account.dart';
import '../models/movie.dart';
import '../models/profile.dart';
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

  // INSERT INTO Accounts(...) VALUES(...);
  Future signUp(Map<String, dynamic> account) async {
    final Database db = await database;
    int id = await db.insert('Accounts', account);

    insertFirstProfile(account, id);

    return signIn(email: account['email'], password: account['password']);
  }

  // SELECT * FROM Accounts where id = ?;
  Future<Account> selectAccount() async {
    final Database db = await database;
    final List<Map<String, dynamic>> queryResult = await db.query('Accounts');

    if (queryResult.isNotEmpty) {
      Map<String, dynamic> account = Map.from(queryResult.first);

      return Account.fromMap(account);
    } else {
      return null;
    }
  }

  Future signIn({@required String email, @required String password}) async {
    final Database db = await database;
    final List<Map<String, dynamic>> queryResult = await db.query(
      'Accounts',
      where: 'email = ? and password = ?',
      whereArgs: [email, password],
    );
    if (queryResult == null) {
      return null;
    }
    return Account.fromMap(queryResult.first);
  }

  // INSERT INTO Profiles(...) VALUES(...);
  void insertFirstProfile(Map<String, dynamic> account, int id) async {
    final Database db = await database;
    Profile profile = Profile(account['name'], true, id);
    await db.insert('Profiles', profile.toMap());
  }

  // INSERT INTO Profiles(...) VALUES(...);
  void insertNewProfile(Account account) async {
    final Database db = await database;
    Profile profile = Profile(account.name, false, account.id);
    await db.insert('Profiles', profile.toMap());
  }

  void addMovieToWatchList(Movie movie, int profileId) async {
    final Database db = await database;
    Map<String, dynamic> movieMap = movie.toMap();
    movieMap.addAll({'profile_id': profileId});
    await db.insert('WatchList', movieMap);
  }

  Future<List<Movie>> selectWatchList(int profileId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> queryResult = await db.query(
      'WatchList',
      where: 'profile_id = ?',
      whereArgs: [profileId],
    );

    if (queryResult.isNotEmpty) {
      List<Movie> movies = [];
      for (Map<String, dynamic> movie in queryResult) {
        movies.add(Movie.fromMap(movie));
      }
      return movies;
    } else {
      return null;
    }
  }
}
