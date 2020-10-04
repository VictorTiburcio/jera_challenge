import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/movie.dart';
import '../services/the_movie_db_service.dart';

class TheMovieDBController extends ChangeNotifier {
  final TheMovieDBService theMovieDBService = TheMovieDBService();
  SearchMoviesState searchMoviesState = SearchMoviesState.ready;
  SuggestedMoviesState suggestedMoviesState = SuggestedMoviesState.ready;
  List<Movie> popularMoviesList = [];
  List<Movie> searchMoviesList = [];
  List<Movie> suggestedMoviesList = [];
  int page = 1;

  void init() {
    popularMovies();
    suggestedMovies();
  }

  Future<void> popularMovies() async {
    searchMoviesState = SearchMoviesState.loading;
    notifyListeners();

    page = 1;
    Response response = await theMovieDBService.popularMovies(page);
    if (response.statusCode == 200) {
      popularMoviesList.clear();
      searchMoviesList.clear();
      for (Map<String, dynamic> movie in response.data['results']) {
        popularMoviesList.add(Movie.fromMap(movie));
      }
    }

    searchMoviesState = SearchMoviesState.ready;
    notifyListeners();
  }

  void search(String search) async {
    searchMoviesState = SearchMoviesState.loading;
    notifyListeners();

    if (search.isEmpty) {
      popularMovies();
    } else {
      page = 1;
      Response response = await theMovieDBService.search(search, page);
      if (response.statusCode == 200) {
        searchMoviesList.clear();
        for (Map<String, dynamic> movie in response.data['results']) {
          searchMoviesList.add(Movie.fromMap(movie));
        }
      }
    }

    searchMoviesState = SearchMoviesState.ready;
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

  void loadMorePopularMovies() async {
    page += 1;
    Response response = await theMovieDBService.popularMovies(page);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> movie in response.data['results']) {
        popularMoviesList.add(Movie.fromMap(movie));
      }
    }
  }

  void loadMoreSearchMovies(String search) async {
    page += 1;
    Response response = await theMovieDBService.search(search, page);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> movie in response.data['results']) {
        searchMoviesList.add(Movie.fromMap(movie));
      }
    }
  }
}

enum SearchMoviesState {
  loading,
  ready,
  error,
}

enum SuggestedMoviesState {
  loading,
  ready,
  error,
}
