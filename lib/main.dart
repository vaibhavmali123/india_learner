import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/views/SplashScreen.dart';
import 'package:india_learner/views/widget/MyThemes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: SplashScreen(),
    );
  }
}
