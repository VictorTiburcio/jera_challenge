class DatabaseQueries {
  static const String _createTableAccounts = '''
  CREATE TABLE Accounts (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    birthday TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL
  );
  ''';

  static const String _createTableProfiles = '''
  CREATE TABLE Profiles (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    main BOOL NOT NULL,
    account_id INTEGER NOT NULL,
    FOREIGN KEY (account_id) REFERENCES Accounts(id) ON DELETE CASCADE
  );
  ''';

  static const List<String> queries = [
    _createTableAccounts,
    _createTableProfiles,
  ];
}
