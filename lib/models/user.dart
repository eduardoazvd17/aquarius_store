import 'dart:convert';
import 'package:flutter/material.dart';

class User {
  String fullName;
  String email;
  String password;
  bool isAdm;

  User({
    @required this.fullName,
    @required this.email,
    @required this.password,
    this.isAdm = false,
  });

  String toJson() {
    Map<String, dynamic> userMap = {};
    userMap.putIfAbsent('fullName', () => fullName);
    userMap.putIfAbsent('email', () => email);
    userMap.putIfAbsent('password', () => password);
    userMap.putIfAbsent('isAdm', () => isAdm);
    return json.encode(userMap);
  }

  User.fromJson(String userJSON) {
    Map<String, dynamic> userMap = json.decode(userJSON);
    this.fullName = userMap['fullName'];
    this.email = userMap['email'];
    this.password = userMap['password'];
    this.isAdm = userMap['isAdm'];
  }
}
