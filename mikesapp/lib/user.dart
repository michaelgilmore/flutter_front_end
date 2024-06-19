class User {
  String? dbId;
  final String name;
  final String email;
  final String password;

  User({
    required this.name,
    required this.email,
    required this.password,
  });

  Object? toJson() {
    //Any need to add dbId here?
    return {
      'username': name,
      'email': email,
      'password': password,
    };
  }

  static fromJson(user) {
    //print('fromJson()');
    User userFromJson = User(
      name: user['username'],
      email: user['email'],
      password: user['password'],
    );

    if(user['_id'] != null) {
      userFromJson.dbId = user['_id'];
    }
    return userFromJson;
  }
}
