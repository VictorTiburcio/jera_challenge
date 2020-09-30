class Profile {
  int id;
  String name;
  bool main;
  int accountId;

  Profile(this.name, this.main, this.accountId);

  Profile.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    main = map['main'];
    accountId = map['account_id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'main': main,
      'account_id': accountId,
    };

    return map;
  }
}
