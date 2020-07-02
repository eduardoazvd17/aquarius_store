import 'dart:convert';

class User {
  String email;
  String password;

  String toJson() {
    Map<String, dynamic> userMap = {};
    userMap.putIfAbsent('email', () => email);
    userMap.putIfAbsent('password', () => password);
    return json.encode(userMap);
  }

  User.fromJson(String userJSON) {
    Map<String, dynamic> userMap = json.decode(userJSON);
    this.email = userMap['email'];
    this.password = userMap['password'];
  }
}
