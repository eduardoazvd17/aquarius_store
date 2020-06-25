import 'package:aquariusstore/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'Aquarius Store',
      theme: ThemeData(
        primaryColor: Colors.blue[200],
        accentColor: Colors.purple[200],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (_) => Home(),
      },
      initialRoute: '/',
    ),
  );
}
