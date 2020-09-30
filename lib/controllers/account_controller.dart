import 'package:flutter/foundation.dart';

import '../models/account.dart';
import '../services/account_service.dart';

class AccountController extends ChangeNotifier {
  final AccountService accountService = AccountService();
  AuthenticationState authState = AuthenticationState.undefined;
  Account account;

  void init() async {
    authState = AuthenticationState.authenticating;
    notifyListeners();

    if (await accountService.anAccountIsLogged()) {
      authState = AuthenticationState.authenticated;
    } else {
      authState = AuthenticationState.unauthenticated;
    }
    notifyListeners();
  }

  void signUp({@required Map<String, dynamic> data}) async {
    authState = AuthenticationState.authenticating;
    notifyListeners();

    accountService.signUp(data: data);

    authState = AuthenticationState.authenticated;
    notifyListeners();
  }
}

enum AuthenticationState {
  undefined,
  authenticating,
  authenticated,
  unauthenticated,
}
