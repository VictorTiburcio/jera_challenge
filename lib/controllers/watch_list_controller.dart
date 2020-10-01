import 'package:flutter/foundation.dart';

import '../models/movie.dart';
import '../services/watch_list_service.dart';

class WatchListController extends ChangeNotifier {
  final WatchListService _watchListService = WatchListService();
  WatchListState state = WatchListState.ready;
  List<Movie> movies = [];

  void loadWatchList() async {
    state = WatchListState.loading;
    notifyListeners();

    List<Movie> watchList = await _watchListService.loadWatchList();
    if (watchList != null) {
      movies = watchList;
    }

    state = WatchListState.ready;
    notifyListeners();
  }

  void addToWatchList(Movie movie) async {
    state = WatchListState.loading;
    notifyListeners();

    _watchListService.addToWatchList(movie);
    movies.add(movie);

    state = WatchListState.ready;
    notifyListeners();
  }
}

enum WatchListState {
  loading,
  ready,
  error,
}
