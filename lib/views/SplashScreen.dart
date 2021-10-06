import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/utils/AppStrings.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/DashBoard.dart';
import 'package:india_learner/views/WelcomeScreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Database.initDatabase();
    Timer(Duration(seconds: 2), () {
      Get.off(Database.getUserID() == null ? WelcomeScreen() : DashBoard());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon.png',
              scale: 0.6,
              height: 120,
              width: 120,
            ),
            SizedBox(
              height: 30,
            ),
            Text.rich(TextSpan(
                text: 'India',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: 'Learner',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ])),
            SizedBox(
              height: 6,
            ),
            Text(
              AppSrings.appQuote,
              style: TextStyle(
                fontSize: 10,
                color: Colors.black54,
                fontWeight: FontWeight.w900,
              ),
            )
          ],
        ),
      ),
    );
  }
}
