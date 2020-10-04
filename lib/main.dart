import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'controllers/account_controller.dart';
import 'controllers/profile_controller.dart';
import 'controllers/the_movie_db_controller.dart';
import 'controllers/watch_list_controller.dart';
import 'utils/mobile_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  List<DeviceOrientation> orientations = [DeviceOrientation.portraitUp];
  SystemChrome.setPreferredOrientations(orientations)
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData defaultTheme = ThemeData(
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: Colors.grey.shade900,
      appBarTheme: AppBarTheme(
        color: Colors.grey.shade800,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey.shade800,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.green.shade700,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.grey.shade800,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AccountController()..init(),
        ),
        ChangeNotifierProvider(
          create: (_) => TheMovieDBController()..init(),
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
