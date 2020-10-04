import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/the_movie_db_controller.dart';
import '../widgets/movie_search_bar.dart';
import '../widgets/updatable_movie_list.dart';

class SearchScreen extends StatelessWidget {
  static const String route = '/search';

  @override
  Widget build(BuildContext context) {
    final MovieSearchBar _searchBar = MovieSearchBar();

    return Scaffold(
      appBar: AppBar(
        title: _searchBar,
      ),
      body: Consumer<TheMovieDBController>(
        builder: (context, controller, child) {
          switch (controller.searchMoviesState) {
            case SearchMoviesState.ready:
              if (controller.searchMoviesList.isNotEmpty) {
                return UpdatableMovieList(controller.searchMoviesList);
              }
              return UpdatableMovieList(controller.popularMoviesList);
            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
