import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/models/CourseListModel.dart';
import 'package:india_learner/networking/ApiHandler.dart';
import 'package:india_learner/networking/ApiProvider.dart';
import 'package:india_learner/networking/EndApi.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/PricingWidget.dart';

class SubscriptionPage extends StatefulWidget {
  SubscriptionPageState createState() => SubscriptionPageState();
}

class SubscriptionPageState extends State<SubscriptionPage> {
  List<dynamic> listFaqs = [];
  List<bool> isSelectedList = [];
  int indexQue;
  String categoryName;
  List<CourseList> listCourse = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Database.initDatabase();
    print("SUBID ${Database.getSubcategoryId()}");
    getCourses();
    categoryName = Database.getSelectedCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: Get.size.width,
        child: SizedBox(
          height: 50,
          child: RaisedButton(
            onPressed: () {
              Get.to(PricingWidget());
            },
            color: Colors.cyan,
            child: Text(
              'Get subscription',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
        ),
      ),
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
        title: Text(categoryName + ' subscription', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: listCourse != null
                    ? ListView.builder(
                        itemCount: listCourse.length,
                        itemBuilder: (context, index) {
                          indexQue = index + 1;
                          return listCourse[index].isFree == '1'
                              ? Container(
                                  margin: EdgeInsets.only(left: 18, right: 14, top: 18),
                                  decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(5.0, 0.5), blurRadius: 10.4, spreadRadius: 0.4)]),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                            height: 70,
                                            padding: EdgeInsets.symmetric(horizontal: 5),
                                            width: Get.size.width / 1.1,
                                            decoration: BoxDecoration(color: Colors.white),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 5,
                                                        child: Container(
                                                          child: Text(listCourse[index].courseName, overflow: TextOverflow.ellipsis, maxLines: 3, style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w600)),
                                                        )),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Icon(
                                                          Icons.download_outlined,
                                                          size: 28,
                                                          color: Colors.blue,
                                                        ))
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              : Container();
                        })
                    : Center(
                        child: Text('No courses available for this category'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getCourses() {
    Database.initDatabase();

    var obj = {'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId()};
    ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.courseList, map: obj).then((value) {
      setState(() {
        listCourse = CourseListModel.fromJson(value).courseList;
      });
      print("RESPONSE VVVVVVVVVVV ${listCourse.length}");
    });
  }
}
