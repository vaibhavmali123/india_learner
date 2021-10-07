import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/models/SubtestModel.dart';
import 'package:india_learner/views/TestInstructions.dart';

class TestInfoPage extends StatefulWidget {
  SubtestDetailsList subtestDetailsList;
  String testType;
  TestInfoPage(this.subtestDetailsList, this.testType);

  TestInfoPageState createState() => TestInfoPageState(subtestDetailsList, testType);
}

class TestInfoPageState extends State<TestInfoPage> {
  List<String> strList = ['Syllabus', 'Question Paper', 'Question paper Hindi', 'Answer Format', 'Answer Format Hindi', 'Discussion'];
  List<String> strListSubtitle = ['Click to see the syllabus', 'Click to Download', 'Click to Download', 'Click to Download', 'Click to Download', 'Click to View'];
  SubtestDetailsList subtestDetailsList;
  String testType;

  TestInfoPageState(this.subtestDetailsList, this.testType);

  List<IconData> listIcons = [
    Icons.paste,
    Icons.library_books,
    Icons.library_books,
    Icons.edit,
    Icons.edit,
    Icons.mic,
  ];
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
        title: Text(subtestDetailsList.subtest, style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      bottomNavigationBar: Container(
        width: Get.size.width,
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
        child: SizedBox(
          height: 50,
          child: RaisedButton(
            onPressed: () {
              Get.to(TestInstructions(
                subtestDetailsList: subtestDetailsList,
                testType: testType,
              ));
            },
            color: Colors.cyan,
            child: Text(
              'Take Test',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                  child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    leading: Icon(
                      listIcons[index],
                      size: 34,
                      color: Colors.black.withOpacity(0.6),
                    ),
                    title: Text(
                      strList[index],
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.cyan),
                    ),
                    subtitle: Text(
                      strListSubtitle[index],
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic, color: Colors.black54),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 1,
                    color: Colors.black12,
                  )
                ],
              ));
            }),
      ),
    );
  }
}
