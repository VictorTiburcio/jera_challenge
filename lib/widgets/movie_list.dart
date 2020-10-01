import 'package:flutter/material.dart';

import '../models/movie.dart';
import 'movie_card.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.all(16.0),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          if (movies[index].posterPath != null) {
            return MovieCard(movies[index]);
          } else {
            return Container();
          }
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
