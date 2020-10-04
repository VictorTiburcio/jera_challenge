class Profile {
  int id;
  String name;
  bool main;
  int accountId;

  Profile(this.name, this.main, this.accountId);

  Profile.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    main = map['main'] == 1 ? true : false;
    accountId = map['account_id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'main': main == true ? 1 : 0,
      'account_id': accountId,
    };

    return map;
  }
}
