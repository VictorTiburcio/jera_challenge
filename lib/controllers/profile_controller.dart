import 'package:flutter/foundation.dart';

import '../models/account.dart';
import '../models/profile.dart';
import '../services/account_service.dart';
import '../services/profile_service.dart';

class ProfileController extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();
  ProfileState state = ProfileState.ready;
  List<Profile> profiles = [];

  void loadProfiles() async {
    state = ProfileState.loading;
    notifyListeners();

    AccountService accountService = AccountService();
    Account account = await accountService.accountLogged();

    if (account != null) {
      List<Profile> profileList = await _profileService.loadProfiles(account);
      if (profileList != null) {
        profiles = profileList;
      }
    }

    state = ProfileState.ready;
    notifyListeners();
  }

  void insertNewProfile(String profileName) async {
    state = ProfileState.loading;
    notifyListeners();

    AccountService accountService = AccountService();
    Account account = await accountService.accountLogged();

    if (account != null) {
      Profile profile = await _profileService.insertNewProfile(
        account,
        profileName,
      );
      profiles.add(profile);
    }

    state = ProfileState.ready;
    notifyListeners();
  }

  void changeProfile(Profile profile) {
    _profileService.changeProfile(profile);
  }
}

enum ProfileState {
  loading,
  ready,
  error,
}
