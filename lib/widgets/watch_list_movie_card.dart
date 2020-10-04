import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/the_movie_db_controller.dart';
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
    String posterPath =
        '${Constants.lowQualityImageBaseUrl}/${widget.movie.posterPath}';

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(posterPath),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                  onTap: () => removeMovie(context, widget.movie)),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                InkWell(
                  child: widget.movie.watched
                      ? Icon(
                          Icons.visibility_off,
                          color: Theme.of(context).primaryColor,
                        )
                      : Icon(
                          Icons.visibility,
                          color: Theme.of(context).primaryColor,
                        ),
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
                Spacer(),
                InkWell(
                  child: Icon(
                    Icons.share,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () {
                    sharePoster(posterPath, context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sharePoster(String posterPath, BuildContext context) async {
    loadingDialog(context);
    var request = await HttpClient().getUrl(Uri.parse(posterPath));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    Navigator.of(context).pop();
    await Share.file('What does the fox say?', 'image.jpg', bytes, 'image/jpg');
  }

  void loadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          content: Container(
            width: 150,
            height: 150,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  void removeMovie(BuildContext context, Movie movie) {
    Provider.of<WatchListController>(context, listen: false).removeMovie(movie);
    Provider.of<TheMovieDBController>(context, listen: false).suggestedMovies();
  }
}
