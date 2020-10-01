import '../screens/home_screen.dart';
import '../screens/index_screen.dart';
import '../screens/search_screen.dart';
import '../screens/sign_in_screen.dart';
import '../screens/sign_up_screen.dart';

class MobileRouter {
  static const initialRoute = HomeScreen.route;
  static final routes = {
    HomeScreen.route: (context) => HomeScreen(),
    SignUpScreen.route: (context) => SignUpScreen(),
    SignInScreen.route: (context) => SignInScreen(),
    IndexScreen.route: (context) => IndexScreen(),
    SearchScreen.route: (context) => SearchScreen(),
  };
}
