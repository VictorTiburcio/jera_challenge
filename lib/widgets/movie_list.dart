import 'package:flutter/material.dart';

import '../models/movie.dart';
import 'movie_card.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(16.0),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: movies.map((movie) {
        if (movie.posterPath != null) {
          return MovieCard(movie);
        } else {
          return Container();
        }
      }).toList(),
    );
  }
}
