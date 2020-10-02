import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/watch_list_controller.dart';
import '../models/movie.dart';
import '../utils/constants.dart';

class WatchListMovieCard extends StatefulWidget {
  final Movie movie;
  WatchListMovieCard(this.movie);

  @override
  _WatchListMovieCardState createState() => _WatchListMovieCardState();
}

class _WatchListMovieCardState extends State<WatchListMovieCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            '${Constants.lowQualityImageBaseUrl}/${widget.movie.posterPath}',
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
                  child: widget.movie.watched
                      ? Icon(Icons.visibility_off, color: Colors.redAccent)
                      : Icon(Icons.visibility, color: Colors.redAccent),
                  onTap: () {
                    setState(() {
                      Provider.of<WatchListController>(
                        context,
                        listen: false,
                      ).changeWatchedStatus(
                        widget.movie,
                        !widget.movie.watched,
                      );
                      widget.movie.watched = !widget.movie.watched;
                    });
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
