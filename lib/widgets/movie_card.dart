import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../utils/constants.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      '${Constants.lowQualityImageBaseUrl}/${movie.posterPath}',
      height: 500,
    );
  }
}
