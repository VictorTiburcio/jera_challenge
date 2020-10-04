import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/account_controller.dart';

class Logged extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Logged'),
          ),
          RaisedButton(
            child: Text('Logout'),
            onPressed: () {
              Provider.of<AccountController>(context, listen: false).signOut();
            },
          ),
        ],
      ),
    );
  }
}
