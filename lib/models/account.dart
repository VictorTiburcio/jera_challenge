class Account {
  int id;
  String email;
  String birthday;
  String name;

  Account(this.email, this.name, this.birthday);

  Account.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    email = map['email'];
    birthday = map['birthday'];
    name = map['name'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'email': email,
      'birthday': birthday,
      'name': name,
    };

    return map;
  }
}
