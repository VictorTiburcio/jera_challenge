import '../screens/home_screen.dart';
import '../screens/index_screen.dart';
import '../screens/movie_screen.dart';
import '../screens/profiles_screen.dart';
import '../screens/search_screen.dart';
import '../screens/sign_in_screen.dart';
import '../screens/sign_up_screen.dart';
import '../screens/suggested_movies_screen.dart';
import '../screens/watch_list_screen.dart';

class MobileRouter {
  static const initialRoute = HomeScreen.route;
  static final routes = {
    HomeScreen.route: (context) => HomeScreen(),
    SignInScreen.route: (context) => SignInScreen(),
    SignUpScreen.route: (context) => SignUpScreen(),
    IndexScreen.route: (context) => IndexScreen(),
    WatchListScreen.route: (context) => WatchListScreen(),
    SearchScreen.route: (context) => SearchScreen(),
    SuggestedMoviesScreen.route: (context) => SuggestedMoviesScreen(),
    ProfilesScreen.route: (context) => ProfilesScreen(),
    MovieScreen.route: (context) => MovieScreen(),
  };
}
