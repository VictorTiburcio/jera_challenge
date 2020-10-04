import 'package:flutter/foundation.dart';

import '../models/account.dart';
import '../models/profile.dart';
import '../services/account_service.dart';
import '../services/profile_service.dart';

class ProfileController extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();
  ProfileState state = ProfileState.ready;
  List<Profile> profiles = [];
  Profile profileCurrentlyLogged = Profile('Loading', false, -1);

  void loadProfiles() async {
    state = ProfileState.loading;
    notifyListeners();

    AccountService accountService = AccountService();
    Account account = await accountService.accountLogged();

    if (account != null) {
      List<Profile> profileList = await _profileService.loadProfiles(account);
      if (profileList != null) {
        profiles = profileList;
        int id = await _profileService.profileCurrentlyLoggedId();
        profileCurrentlyLogged =
            profiles.firstWhere((profile) => profile.id == id);
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
    profileCurrentlyLogged = profile;

    notifyListeners();
  }

  void deleteProfile(Profile profile) async {
    profiles.remove(profile);
    _profileService.deleteProfile(profile);
    if (profile.id == profileCurrentlyLogged.id) {
      changeProfile(profiles.firstWhere((profile) => profile.main));
    }

    notifyListeners();
  }
}

enum ProfileState {
  loading,
  ready,
  error,
}
