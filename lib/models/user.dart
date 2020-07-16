import 'dart:convert';
import 'package:aquariusstore/models/product.dart';
import 'package:flutter/material.dart';

class User {
  String fullName;
  String email;
  String password;
  List<Product> cart;
  bool isAdm;

  User({
    @required this.fullName,
    @required this.email,
    @required this.password,
    this.isAdm = false,
    this.cart = const [],
  });

  String toJson() {
    Map<String, dynamic> userMap = {};
    userMap.putIfAbsent('fullName', () => fullName);
    userMap.putIfAbsent('email', () => email);
    userMap.putIfAbsent('password', () => password);
    userMap.putIfAbsent('isAdm', () => isAdm);
    List<String> pList = [];
    for (var p in cart) {
      pList.add(p.toJson());
    }
    userMap.putIfAbsent('cart', () => pList);
    return json.encode(userMap);
  }

  User.fromJson(String userJSON) {
    Map<String, dynamic> userMap = json.decode(userJSON);
    this.fullName = userMap['fullName'];
    this.email = userMap['email'];
    this.password = userMap['password'];
    this.isAdm = userMap['isAdm'];
    List<Product> pList = [];
    for (var p in userMap['cart']) {
      pList.add(Product.fromJson(p));
    }
    this.cart = pList;
  }
}
