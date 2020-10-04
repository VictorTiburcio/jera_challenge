import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/the_movie_db_controller.dart';
import '../models/movie.dart';
import '../screens/movie_screen.dart';
import 'movie_card.dart';
import 'movie_search_bar.dart';

class UpdatableMovieList extends StatefulWidget {
  final List<Movie> movies;

  UpdatableMovieList(this.movies);

  @override
  _UpdatableMovieListState createState() => _UpdatableMovieListState();
}

class _UpdatableMovieListState extends State<UpdatableMovieList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      double maxScrollExtent = _scrollController.position.maxScrollExtent;
      if (maxScrollExtent == _scrollController.offset) {
        setState(() {
          TheMovieDBController ctrl =
              Provider.of<TheMovieDBController>(context, listen: false);
          if (ctrl.searchMoviesList.isNotEmpty) {
            Provider.of<TheMovieDBController>(context, listen: false)
                .loadMoreSearchMovies(MovieSearchBar.searchCtrl.text.trim());
          } else {
            Provider.of<TheMovieDBController>(context, listen: false)
                .loadMorePopularMovies();
          }
        });
      }
    });

    return RefreshIndicator(
      onRefresh: () {
        return Provider.of<TheMovieDBController>(context, listen: false)
            .popularMovies();
      },
      child: GridView.count(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: widget.movies.map((movie) {
          return InkWell(
            child: MovieCard(movie),
            onTap: () {
              print(movie.id);
              Navigator.pushNamed(context, MovieScreen.route, arguments: movie);
            },
          );
        }).toList(),
      ),
    );
  }
}
