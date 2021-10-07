import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/CourseBloc.dart';
import 'package:india_learner/models/CourseListModel.dart';
import 'package:india_learner/models/TeacherListModel.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/views/ClassesOrCoursesScreen.dart';
import 'package:india_learner/views/FreeLiveClass.dart';
import 'package:india_learner/views/SubscriptionPage.dart';
import 'package:intl/intl.dart';

class TeachersDetails extends StatefulWidget {
  TeacherList teacherList = TeacherList();

  TeachersDetails({this.teacherList});

  TeachersDetailsState createState() => TeachersDetailsState(teacherList: teacherList);
}

class TeachersDetailsState extends State<TeachersDetails> {
  TeacherList teacherList = TeacherList();

  TeachersDetailsState({this.teacherList});
  String theme;
  List<CourseList> listCourse = [];

  @override
  Widget build(BuildContext context) {
    theme = MediaQuery.of(context).platformBrightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme;
    courseBloc.featchAllCourses();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Teacher Details",
          style: TextStyle(fontSize: 15, color: Colors.black87),
        ),
      ),
      body: Container(
        // color: Colors.white,
        width: Get.size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: 150,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/teachers.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(teacherList.name, style: TextStyle(fontSize: 16, color: Colors.black87.withOpacity(0.6), fontWeight: FontWeight.w600)),
            SizedBox(
              height: 8,
            ),
            Text("Teacher BIO", style: TextStyle(fontSize: 16, color: Colors.black87.withOpacity(0.6), fontWeight: FontWeight.w600)),
            SizedBox(
              height: 14,
            ),
            Container(
              color: Colors.black12,
              height: 1,
            ),
            SizedBox(
              height: 14,
            ),
            Expanded(
              //height:Get.size.height/1.4,
              child: Column(
                children: [Expanded(flex: 1, child: getOngoingBatchesList()), Expanded(flex: 1, child: getOnGoingCoursesList()), Expanded(flex: 1, child: getUpcomingCourses()), Expanded(flex: 1, child: getCompletedCourses())],
              ),
            )
          ],
        ),
      ),
    );
  }

  getOngoingBatchesList() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(left: 15, top: 20), child: Text('- Batches ongoing', style: TextStyle(fontSize: 16, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w800))),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder(
              stream: courseBloc.courseFetcher,
              builder: (context, AsyncSnapshot<List<CourseList>> snapshot) {
                if (snapshot.hasData == false) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  print("RESSSS ${snapshot.data}");

                  listCourse = snapshot.data;

                  print("Date ${DateTime.parse(listCourse[0].startDate)} ${DateTime.parse(listCourse[0].endDate)}");

                  print("Date Diff ${DateTime.parse(listCourse[0].startDate).difference(DateTime.parse(listCourse[0].endDate))}");
                  return listCourse != null
                      ? Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: listCourse.length > 0
                                    ? ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: (listCourse.length),
                                        itemBuilder: (context, index) {
                                          DateFormat formater = DateFormat('yyyy-MM-dd');

//

                                          DateTime now = DateTime.now();
                                          print("DIFFF isAfter ${now.isAfter(DateTime.parse(listCourse[index].startDate))}");
                                          print("DIFFF isBefore ${now.isBefore(DateTime.parse(listCourse[index].endDate))}");
                                          print("TTTTTTTTTTTTTTT ${now.isAfter(DateTime.parse(listCourse[index].startDate)) && now.isBefore(DateTime.parse(listCourse[index].endDate))}");

                                          return now.isAfter(DateTime.parse(listCourse[index].startDate)) && now.isBefore(DateTime.parse(listCourse[index].endDate))
                                              ? GestureDetector(
                                                  onTap: () {
                                                    print("PLAN NAME ${listCourse[index].planName}");
                                                    listCourse[index].planName != "" ? Get.to(FreeLiveClass()) : Get.to(SubscriptionPage());
                                                  },
                                                  child: Container(
                                                    width: 140,
                                                    margin: EdgeInsets.only(left: 10),
                                                    height: 100,
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(width: 1, color: Colors.black12)),
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                            flex: 3,
                                                            child: listCourse[index].file == null || listCourse[index].file == ''
                                                                ? Image.asset(
                                                                    'assets/images/teachers.jpg',
                                                                    //height: 90,
                                                                    fit: BoxFit.contain,
                                                                    width: 120,
                                                                  )
                                                                : Image.network(
                                                                    listCourse[index].file,
                                                                    fit: BoxFit.cover,
                                                                    width: 130,
                                                                  )),
                                                        Container(
                                                          height: 1,
                                                          color: Colors.black12,
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Expanded(flex: 1, child: Text(listCourse[index].courseName, style: TextStyle(fontSize: 16, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w600)))
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container();
                                        })
                                    : Center(
                                        child: Text('No data'),
                                      ),
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: Text('No data'),
                        );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  getOnGoingCoursesList() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(left: 15, top: 20), child: Text('Courses ongoing', style: TextStyle(fontSize: 16, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w800))),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder(
              stream: courseBloc.courseFetcher,
              builder: (context, AsyncSnapshot<List<CourseList>> snapshot) {
                if (snapshot.hasData == false) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  listCourse = snapshot.data;
                  if (listCourse != null) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: listCourse.length > 0
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: (listCourse.length),
                                    itemBuilder: (context, index) {
                                      DateFormat formater = DateFormat('yyyy-MM-dd');

                                      DateTime now = DateTime.now();
                                      print("DIFFF isAfter ${now.isAfter(DateTime.parse(listCourse[index].startDate))}");
                                      print("DIFFF isBefore ${now.isBefore(DateTime.parse(listCourse[index].endDate))}");
                                      print("TTTTTTTTTTTTTTT ${now.isAfter(DateTime.parse(listCourse[index].startDate)) && now.isBefore(DateTime.parse(listCourse[index].endDate))}");

                                      return now.isAfter(DateTime.parse(listCourse[index].startDate)) && now.isBefore(DateTime.parse(listCourse[index].endDate))
                                          ? GestureDetector(
                                              onTap: () {
                                                listCourse[index].planName != "" ? Get.to(FreeLiveClass()) : Get.to(SubscriptionPage());
                                              },
                                              child: Container(
                                                width: 140,
                                                margin: EdgeInsets.only(left: 10),
                                                height: 100,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(width: 1, color: Colors.black12)),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                        flex: 3,
                                                        child: listCourse[index].file == null || listCourse[index].file == ''
                                                            ? Image.asset(
                                                                'assets/images/teachers.jpg',
                                                                //height: 90,
                                                                fit: BoxFit.contain,
                                                                width: 120,
                                                              )
                                                            : Image.network(
                                                                listCourse[index].file,
                                                                fit: BoxFit.cover,
                                                                width: 130,
                                                              )),
                                                    Container(
                                                      height: 1,
                                                      color: Colors.black12,
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Expanded(flex: 1, child: Text(listCourse[index].courseName, style: TextStyle(fontSize: 16, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w600)))
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container();
                                    })
                                : Center(
                                    child: Text('No data'),
                                  ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Utils.noData,
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  getUpcomingCourses() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(left: 15, top: 20), child: Text('- Upcoming courses', style: TextStyle(fontSize: 16, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w800))),
          SizedBox(
            height: 10,
          ),
          Expanded(
              flex: 2,
              child: StreamBuilder(
                stream: courseBloc.courseFetcher,
                builder: (context, AsyncSnapshot<List<CourseList>> snapshot) {
                  if (snapshot.hasData == false) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    print("RESSSS ${snapshot.data}");
                    listCourse = snapshot.data;
                    if (listCourse != null) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: listCourse.length > 0
                                  ? ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: (listCourse.length),
                                      itemBuilder: (context, index) {
                                        //int durationDiff = DateTime.now().difference(DateTime.now().add(Duration(days: 5)) /*DateTime.parse(listCourse[index].startDate)*/).inDays;
                                        int durationDiff = DateTime.now().add(Duration(days: 5)).difference(DateTime.parse(listCourse[index].startDate)).inDays;
                                        print("UP DIFF ${durationDiff}");
                                        DateTime now = DateTime.now();
                                        bool dateStatus = now.isAfter(DateTime.parse(listCourse[index].startDate));
                                        return dateStatus == false
                                            ? GestureDetector(
                                                onTap: () {
                                                  listCourse[index].planName != "" ? Get.to(FreeLiveClass()) : Get.to(SubscriptionPage());
                                                },
                                                child: Container(
                                                  width: 140,
                                                  margin: EdgeInsets.only(left: 10),
                                                  height: 100,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(width: 1, color: Colors.black12)),
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                          flex: 3,
                                                          child: listCourse[index].file == null || listCourse[index].file == ''
                                                              ? Image.asset(
                                                                  'assets/images/teachers.jpg',
                                                                  //height: 90,
                                                                  fit: BoxFit.contain,
                                                                  width: 120,
                                                                )
                                                              : Image.network(
                                                                  listCourse[index].file,
                                                                  fit: BoxFit.cover,
                                                                  width: 130,
                                                                )),
                                                      Container(
                                                        height: 1,
                                                        color: Colors.black12,
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Expanded(flex: 1, child: Text(listCourse[index].courseName, style: TextStyle(fontSize: 16, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w600)))
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container();
                                      })
                                  : Center(
                                      child: Text('No data'),
                                    ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Utils.noData,
                      );
                    }
                  }
                },
              )),
        ],
      ),
    );
  }

  getCompletedCourses() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(left: 15, top: 20), child: Text('- Courses completed', style: TextStyle(fontSize: 16, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w800))),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder(
              stream: courseBloc.courseFetcher,
              builder: (context, AsyncSnapshot<List<CourseList>> snapshot) {
                if (snapshot.hasData == false) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  print("RESSSS ${snapshot.data}");
                  listCourse = snapshot.data;
                  if (listCourse != null) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: listCourse.length > 0
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: (listCourse.length),
                                    itemBuilder: (context, index) {
                                      Duration durationDiff = DateTime.parse(listCourse[index].startDate).difference(DateTime.parse(listCourse[0].endDate));
                                      int days = DateTime.now().difference(DateTime.parse(listCourse[index].endDate)).inDays;
                                      print("DIFFRENCE LLL ${listCourse[index].file}");
                                      return days.isNegative == false
                                          ? GestureDetector(
                                              onTap: () {
                                                listCourse[index].planName != "" ? Get.to(ClassesOrCoursesScreen) : Get.to(SubscriptionPage());
                                              },
                                              child: Container(
                                                width: 140,
                                                margin: EdgeInsets.only(left: 10),
                                                height: 100,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(width: 1, color: Colors.black12)),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                        flex: 3,
                                                        child: listCourse[index].file == null || listCourse[index].file == ''
                                                            ? Image.asset(
                                                                'assets/images/teachers.jpg',
                                                                //height: 90,
                                                                fit: BoxFit.contain,
                                                                width: 120,
                                                              )
                                                            : Image.network(listCourse[index].file)),
                                                    Container(
                                                      height: 1,
                                                      color: Colors.black12,
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Expanded(flex: 1, child: Text(listCourse[index].courseName, style: TextStyle(fontSize: 16, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w600)))
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container();
                                    })
                                : Center(
                                    child: Text('No data'),
                                  ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Utils.noData,
                    );
                  }
                }
              },
            )
            /*FutureBuilder(
                future: futureCourse,
                builder: (context, snapshot) {
                  if (snapshot.hasData == false) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    print("RESSSS ${snapshot.data}");
                    listCourse = CourseListModel.fromJson(snapshot.data).courseList;
                    if (listCourse != null) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: listCourse.length > 0
                                  ? ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: (listCourse.length),
                                      itemBuilder: (context, index) {
                                        Duration durationDiff = DateTime.parse(listCourse[index].startDate).difference(DateTime.parse(listCourse[0].endDate));
                                        int days = DateTime.now().difference(DateTime.parse(listCourse[index].endDate)).inDays;
                                        return durationDiff < Duration(hours: 24)
                                            ? GestureDetector(
                                                onTap: () {
                                                  listCourse[index].planName != "" ? Get.to(ClassesOrCoursesScreen) : Get.to(SubscriptionPage());
                                                },
                                                child: Container(
                                                  width: 140,
                                                  margin: EdgeInsets.only(left: 10),
                                                  height: 100,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), border: Border.all(width: 1, color: Colors.black12)),
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                          flex: 3,
                                                          child: Image.asset(
                                                            'assets/images/teachers.jpg',
                                                            //height: 90,
                                                            fit: BoxFit.contain,
                                                            width: 120,
                                                          )),
                                                      Container(
                                                        height: 1,
                                                        color: Colors.black12,
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Expanded(flex: 1, child: Text(listCourse[index].courseName, style: TextStyle(fontSize: 16, color: theme == Constants.lightTheme ? Colors.black : Colors.white, fontWeight: FontWeight.w600)))
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container();
                                      })
                                  : Center(
                                      child: Text('No data'),
                                    ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Utils.noData,
                      );
                    }
                  }
                })*/
            ,
          ),
        ],
      ),
    );
  }
}
