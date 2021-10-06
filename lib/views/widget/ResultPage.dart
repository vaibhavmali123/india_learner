import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ResultPage extends StatefulWidget {
  int total;

  ResultPage({this.total});

  ResultPageState createState() => ResultPageState(total: total);
}

class ResultPageState extends State<ResultPage> {
  int total;

  ResultPageState({this.total});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text(
          'Result',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black87),
        ),
      ),
      body: Container(
        width: Get.size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Lottie.asset('assets/jsonassets/congrats.json'),
            Text(
              'Result:  ${total} marks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
