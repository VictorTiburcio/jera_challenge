import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/account_controller.dart';
import 'controllers/profile_controller.dart';
import 'controllers/the_movie_db_controller.dart';
import 'controllers/watch_list_controller.dart';
import 'utils/mobile_router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData defaultTheme = ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AccountController()..init(),
        ),
        ChangeNotifierProvider(
          create: (_) => TheMovieDBController()..popularMovies(),
        ),
        ChangeNotifierProvider(
          create: (_) => WatchListController()..loadWatchList(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileController()..loadProfiles(),
        ),
      ],
      child: MaterialApp(
        title: 'Jera Challenge',
        theme: defaultTheme,
        initialRoute: MobileRouter.initialRoute,
        routes: MobileRouter.routes,
      ),
    );
  }
}
