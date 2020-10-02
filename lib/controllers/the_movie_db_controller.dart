import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/movie.dart';
import '../services/the_movie_db_service.dart';

class TheMovieDBController extends ChangeNotifier {
  final TheMovieDBService theMovieDBService = TheMovieDBService();
  PopularMoviesState popularMoviesState = PopularMoviesState.ready;
  SuggestedMoviesState suggestedMoviesState = SuggestedMoviesState.ready;
  List<Movie> popularMoviesList = [];
  List<Movie> suggestedMoviesList = [];

  void init() {
    popularMovies();
    suggestedMovies();
  }

  void popularMovies() async {
    popularMoviesState = PopularMoviesState.loading;
    notifyListeners();

    Response response = await theMovieDBService.popularMovies();
    if (response.statusCode == 200) {
      popularMoviesList.clear();
      for (Map<String, dynamic> movie in response.data['results']) {
        popularMoviesList.add(Movie.fromMap(movie));
      }
    }

    popularMoviesState = PopularMoviesState.ready;
    notifyListeners();
  }

  void search(String search) async {
    popularMoviesState = PopularMoviesState.loading;
    notifyListeners();

    if (search.isEmpty) {
      popularMovies();
    } else {
      Response response = await theMovieDBService.search(search);
      if (response.statusCode == 200) {
        popularMoviesList.clear();
        for (Map<String, dynamic> movie in response.data['results']) {
          popularMoviesList.add(Movie.fromMap(movie));
        }
      }
    }

    popularMoviesState = PopularMoviesState.ready;
    notifyListeners();
  }

  void suggestedMovies() async {
    suggestedMoviesState = SuggestedMoviesState.loading;
    notifyListeners();

    List<Response> responses = await theMovieDBService.suggestedMovies();
    suggestedMoviesList.clear();
    for (Response response in responses) {
      for (Map<String, dynamic> movie in response.data['results']) {
        suggestedMoviesList.add(Movie.fromMap(movie));
      }
    }

    suggestedMoviesState = SuggestedMoviesState.ready;
    notifyListeners();
  }
}

enum PopularMoviesState {
  loading,
  ready,
  error,
}

enum SuggestedMoviesState {
  loading,
  ready,
  error,
}
