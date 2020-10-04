import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../screens/movie_screen.dart';
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
        return InkWell(
          child: MovieCard(movie),
          onTap: () {
            Navigator.pushNamed(context, MovieScreen.route, arguments: movie);
          },
        );
      }).toList(),
    );
  }
}
