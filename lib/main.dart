import 'package:aquariusstore/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init('credentials');
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aquarius Store',
      theme: ThemeData(
        errorColor: Colors.red[200],
        primaryColor: Colors.blue[200],
        accentColor: Colors.purple[300],
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.blue[200],
          ),
          elevation: 0,
          color: ThemeData().scaffoldBackgroundColor,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
    ),
  );
}
