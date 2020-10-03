import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/the_movie_db_controller.dart';
import '../widgets/movie_list.dart';

class SuggestedMoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Suggested Movies',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Consumer<TheMovieDBController>(
        builder: (context, controller, child) {
          switch (controller.suggestedMoviesState) {
            case SuggestedMoviesState.ready:
              return MovieList(controller.suggestedMoviesList);
            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
