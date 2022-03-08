class User {
  int id;
  String name;
  String email;
  String password;
  String token;

  User({this.id, this.name, this.email, this.password, this.token});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'token': token
    };
  }
}
