import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/account_controller.dart';
import 'index_screen.dart';
import 'sign_in_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountController>(
      builder: (context, account, child) {
        switch (account.authState) {
          case AuthenticationState.authenticated:
            return IndexScreen();
          case AuthenticationState.unauthenticated:
            return SignInScreen();
          default:
            return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
