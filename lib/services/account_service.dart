import '../database/database_provider.dart';
import '../models/account.dart';

class AccountService {
  final DatabaseProvider database = DatabaseProvider.db;

  Future<bool> anAccountIsLogged() async {
    Account account = await database.selectAccount();

    return account != null;
  }

  void signUp({Map<String, dynamic> data}) {
    database.insertAccount(data);
  }
}
