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

  static const String _createTableWatchList = '''
  CREATE TABLE WatchList (
    id INTEGER,
    title TEXT,
    overview TEXT,
    release_date TEXT,
    vote_average TEXT,
    poster_path TEXT,
    watched BOOL,
    profile_id INTEGER NOT NULL,
    PRIMARY KEY (id, profile_id),
    FOREIGN KEY (profile_id) REFERENCES Profiles(id) ON DELETE CASCADE
  );
  ''';

  static const List<String> queries = [
    _createTableAccounts,
    _createTableProfiles,
    _createTableWatchList,
  ];
}
