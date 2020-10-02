import 'package:shared_preferences/shared_preferences.dart';

import '../database/database_provider.dart';
import '../models/movie.dart';

class WatchListService {
  final DatabaseProvider _database = DatabaseProvider.db;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<Movie>> loadWatchList() async {
    SharedPreferences prefs = await _prefs;
    int profileId = prefs.getInt('current_profile_id');
    return await _database.selectWatchList(profileId);
  }

  void addToWatchList(Movie movie) async {
    SharedPreferences prefs = await _prefs;
    int profileId = prefs.getInt('current_profile_id');
    _database.addMovieToWatchList(movie, profileId);
  }

  void changeWatchedStatus(Movie movie, bool status) async {
    SharedPreferences prefs = await _prefs;
    int profileId = prefs.getInt('current_profile_id');
    _database.changeWatchedStatus(movie, profileId, status);
  }
}
