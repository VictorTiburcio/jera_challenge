import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../utils/constants.dart';

class WatchListMovieCard extends StatelessWidget {
  final Movie movie;
  WatchListMovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            '${Constants.lowQualityImageBaseUrl}/${movie.posterPath}',
          ),
        ),
      ),
    );
  }
}
