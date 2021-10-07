import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:get/get.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:india_learner/utils/database.dart';

class PaymentScreen extends StatefulWidget {
  String amount, duration;

  PaymentScreen({this.amount, this.duration});

  PaymentScreenState createState() => PaymentScreenState(amount: amount, duration: duration);
}

class PaymentScreenState extends State<PaymentScreen> {
  String categoryName, subcategoryName, amount, duration;

  PaymentScreenState({this.amount, this.duration});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryName = Database.getSelectedCategory();
    subcategoryName = Database.getSubcategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black87,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Payment', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.only(left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text.rich(
              TextSpan(
                  text: 'Selected category: ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '' + categoryName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Text.rich(
              TextSpan(
                  text: 'Selected Subcategory: ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '' + subcategoryName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Text.rich(
              TextSpan(
                  text: 'Amount: ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '' + amount,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Text.rich(
              TextSpan(
                  text: 'Course Duration: ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '' + duration,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: SizedBox(
                    height: 40,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        _restartApp();
                        Database.saveSubscribitionPlan(amount, duration);
                        Repository.subscribe(planName: duration);
                      },
                      color: Colors.cyan,
                      child: Text(
                        'Pay',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  void _restartApp() async {
    FlutterRestart.restartApp();
  }
}
