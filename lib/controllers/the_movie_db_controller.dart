import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/movie.dart';
import '../services/the_movie_db_service.dart';

class TheMovieDBController extends ChangeNotifier {
  final TheMovieDBService theMovieDBService = TheMovieDBService();
  TheMovieDBState theMovieDBState = TheMovieDBState.ready;
  List<Movie> movies = [];

  void popularMovies() async {
    theMovieDBState = TheMovieDBState.loading;
    notifyListeners();

    Response response = await theMovieDBService.popularMovies();
    if (response.statusCode == 200) {
      movies.clear();
      for (Map<String, dynamic> movie in response.data['results']) {
        movies.add(Movie.fromMap(movie));
      }
    }

    theMovieDBState = TheMovieDBState.ready;
    notifyListeners();
  }

  void search(String search) async {
    theMovieDBState = TheMovieDBState.loading;
    notifyListeners();

    if (search == '') {
      popularMovies();
    } else {
      Response response = await theMovieDBService.search(search);
      if (response.statusCode == 200) {
        movies.clear();
        for (Map<String, dynamic> movie in response.data['results']) {
          movies.add(Movie.fromMap(movie));
        }
      }
    }

    theMovieDBState = TheMovieDBState.ready;
    notifyListeners();
  }
}

enum TheMovieDBState {
  loading,
  ready,
  error,
}
