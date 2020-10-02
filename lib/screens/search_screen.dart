import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/the_movie_db_controller.dart';
import '../widgets/movie_list.dart';
import '../widgets/movie_search_bar.dart';

class SearchScreen extends StatefulWidget {
  static const String route = '/search';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final MovieSearchBar _searchBar = MovieSearchBar(_searchCtrl);

    return Scaffold(
      appBar: AppBar(
        title: _searchBar,
      ),
      body: Consumer<TheMovieDBController>(
        builder: (context, controller, child) {
          switch (controller.popularMoviesState) {
            case PopularMoviesState.ready:
              return MovieList(controller.popularMoviesList);
            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
