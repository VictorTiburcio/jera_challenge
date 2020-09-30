import '../screens/home_screen.dart';
import '../screens/sign_up_screen.dart';

class MobileRouter {
  static const initialRoute = HomeScreen.route;
  static final routes = {
    HomeScreen.route: (context) => HomeScreen(),
    SignUpScreen.route: (context) => SignUpScreen(),
  };
}
