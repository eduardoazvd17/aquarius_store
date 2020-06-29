import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aquarius Store',
      theme: ThemeData(
        primaryColor: Colors.blue[200],
        accentColor: Colors.purple[200],
        appBarTheme: AppBarTheme(
          color: ThemeData().scaffoldBackgroundColor,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Container(),
    ),
  );
}
