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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                InkWell(
                  child: Icon(Icons.watch_later, color: Colors.redAccent),
                  onTap: () {
                    Provider.of<WatchListController>(context, listen: false)
                        .addToWatchList(movie);

                    Provider.of<TheMovieDBController>(context, listen: false)
                        .suggestedMovies();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
