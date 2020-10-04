import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/watch_list_controller.dart';
import '../widgets/watch_list_movie_list.dart';

class WatchListScreen extends StatelessWidget {
  static const String route = '/watch_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Watch List',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Consumer<WatchListController>(
        builder: (context, controller, child) {
          switch (controller.state) {
            case WatchListState.ready:
              return WatchListMovieList(controller.movies);
            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
