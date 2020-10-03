import 'package:flutter/material.dart';

import '../models/movie.dart';
import 'watch_list_movie_card.dart';

class WatchListMovieList extends StatelessWidget {
  final List<Movie> movies;
  WatchListMovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(16.0),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: movies.map((movie) {
        if (movie.posterPath != null) {
          return WatchListMovieCard(movie);
        } else {
          return Container();
        }
      }).toList(),
    );
  }
}
