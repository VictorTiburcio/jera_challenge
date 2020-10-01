import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/database_provider.dart';
import '../models/account.dart';

class AccountService {
  final DatabaseProvider database = DatabaseProvider.db;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future accountLogged() async {
    SharedPreferences prefs = await _prefs;
    if (prefs.get('email') != null) {
      String email = prefs.getString('email');
      String password = prefs.getString('password');
      return await database.signIn(email: email, password: password);
    }

    return null;
  }

  Future signUp({@required Map<String, dynamic> data}) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString('email', data['email']);
    prefs.setString('password', data['password']);
    prefs.setInt('current_profile_id', 1);
    print('created');
    return await database.signUp(data);
  }

  Future signIn({@required String email, @required String password}) async {
    SharedPreferences prefs = await _prefs;
    Account account = await database.signIn(email: email, password: password);
    if (account != null) {
      prefs.setString('email', email);
      prefs.setString('password', password);
      prefs.setInt('current_profile_id', 1);
      return account;
    }
    return null;
  }

  void signOut() async {
    SharedPreferences prefs = await _prefs;
    prefs.clear();
  }
}
