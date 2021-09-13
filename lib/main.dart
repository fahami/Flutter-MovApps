import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movapps/detail.dart';
import 'package:movapps/landing.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: '/',
      title: 'Movie App',
      getPages: [
        GetPage(name: '/', page: () => Landing()),
        GetPage(name: '/detail', page: () => DetailPage()),
      ],
    );
  }
}
