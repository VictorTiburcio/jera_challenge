import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/account_controller.dart';
import '../screens/sign_up_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountController>(
      builder: (context, account, child) {
        switch (account.authState) {
          case AuthenticationState.unauthenticated:
            return SignUpScreen();
          default:
            return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
