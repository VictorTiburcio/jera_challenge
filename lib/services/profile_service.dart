import 'package:shared_preferences/shared_preferences.dart';

import '../database/database_provider.dart';
import '../models/account.dart';
import '../models/profile.dart';

class ProfileService {
  final DatabaseProvider database = DatabaseProvider.db;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<Profile>> loadProfiles(Account account) async {
    return await database.loadProfiles(account);
  }

  Future<Profile> insertNewProfile(Account account, String profileName) async {
    return await database.insertNewProfile(account, profileName);
  }

  void changeProfile(Profile profile) async {
    SharedPreferences prefs = await _prefs;
    prefs.setInt('current_profile_id', profile.id);
  }
}
