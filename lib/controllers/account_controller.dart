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

    account = await accountService.accountLogged();
    if (account != null) {
      authState = AuthenticationState.authenticated;
    } else {
      authState = AuthenticationState.unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> signUp({@required Map<String, dynamic> data}) async {
    authState = AuthenticationState.authenticating;
    notifyListeners();

    account = await accountService.signUp(data: data);
    if (account == null) {
      authState = AuthenticationState.unauthenticated;
    } else {
      authState = AuthenticationState.authenticated;
    }
    notifyListeners();
    return account == null;
  }

  void signIn({@required String email, @required String password}) async {
    authState = AuthenticationState.authenticating;
    notifyListeners();

    account = await accountService.signIn(email: email, password: password);
    if (account != null) {
      authState = AuthenticationState.authenticated;
    } else {
      authState = AuthenticationState.signInFailed;
    }

    notifyListeners();
  }

  void signOut() {
    authState = AuthenticationState.authenticating;
    notifyListeners();

    accountService.signOut();

    authState = AuthenticationState.unauthenticated;
    notifyListeners();
  }
}

enum AuthenticationState {
  undefined,
  authenticating,
  authenticated,
  unauthenticated,
  signInFailed,
}
