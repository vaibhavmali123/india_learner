import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/TestTypeBloc.dart';
import 'package:india_learner/models/TestTypeModel.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/views/TestListPage.dart';

class TestsNav extends StatefulWidget {
  TestsNavState createState() => TestsNavState();
}

class TestsNavState extends State<TestsNav> {
  List<String> listTestName = ['Free Test', 'Paid Test', 'Quiz', 'Written/Mains'];
  List<IconData> listIcons = [Icons.paste, Icons.monetization_on_outlined, Icons.notes, Icons.edit];
  String theme;

  @override
  Widget build(BuildContext context) {
    theme = MediaQuery.of(context).platformBrightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme;
    testTypeBloc.getAllTestTypes();
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
//          height: Get.size.height,
            child: Expanded(
                child: StreamBuilder(
              stream: testTypeBloc.testTypeStream,
              builder: (context, AsyncSnapshot<List<TestTypeList>> snapshot) {
                if (snapshot.hasData) {
                  return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    childAspectRatio: 1.8,
                    children: List.generate(snapshot.data.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          index != 3
                              ? Get.to(TestListPage(
                                  testTypeId: snapshot.data[index].id,
                                ))
                              : Get.to(WrittenTestWidget());
                        },
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: theme == Constants.lightTheme ? Colors.white : color.darkCard, boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: const Offset(
                                5.0,
                                0.5,
                              ),
                              blurRadius: 10.4,
                              spreadRadius: 0.4,
                            )
                          ]),
                          child: Center(
                            child: Row(
                              //mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 18,
                                ),
                                Icon(
                                  listIcons[index],
                                  color: theme == Constants.lightTheme ? Colors.black87 : color.darkText,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  snapshot.data[index].testType,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: theme == Constants.lightTheme ? Colors.black87 : color.darkText,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                } else {
                  return Utils.loader;
                }
              },
            )),
          )
        ],
      ),
    ));
  }
}

class WrittenTestWidget extends StatelessWidget {
  String theme;

  @override
  Widget build(BuildContext context) {
    theme = MediaQuery.of(context).platformBrightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme == Constants.lightTheme ? Colors.white : color.darkAppBar,
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
        title: Text('Written test/Mains', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text("Under Development"),
          ),
        ),
      ),
    );
  }
}
