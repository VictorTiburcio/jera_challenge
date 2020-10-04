import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/the_movie_db_controller.dart';
import '../controllers/watch_list_controller.dart';
import '../models/movie.dart';
import '../utils/constants.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    if (movie.posterPath == null) {
      return Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: InkWell(
              child: Icon(
                Icons.watch_later,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () => addToWatchList(context),
            ),
          ),
          Center(
            child: Icon(
              Icons.broken_image,
              size: 70,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            '${Constants.lowQualityImageBaseUrl}/${movie.posterPath}',
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                InkWell(
                  child: Icon(
                    Icons.watch_later,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () => addToWatchList(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addToWatchList(BuildContext context) {
    final WatchListController ctrl =
        Provider.of<WatchListController>(context, listen: false);

    if (!ctrl.movies.any((movie) => movie.id == this.movie.id)) {
      ctrl.addToWatchList(movie);
      Provider.of<TheMovieDBController>(context, listen: false)
          .suggestedMovies();
    }
  }
}
