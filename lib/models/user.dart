import 'dart:convert';

import 'package:flutter/material.dart';

class User {
  String fullName;
  String email;
  String password;

  User({
    @required this.fullName,
    @required this.email,
    @required this.password,
  });

  String toJson() {
    Map<String, dynamic> userMap = {};
    userMap.putIfAbsent('fullName', () => fullName);
    userMap.putIfAbsent('email', () => email);
    userMap.putIfAbsent('password', () => password);
    return json.encode(userMap);
  }

  User.fromJson(String userJSON) {
    Map<String, dynamic> userMap = json.decode(userJSON);
    this.fullName = userMap['fullName'];
    this.email = userMap['email'];
    this.password = userMap['password'];
  }
}
