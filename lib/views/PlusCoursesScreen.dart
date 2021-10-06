import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/CourseBloc.dart';
import 'package:india_learner/models/CourseListModel.dart';
import 'package:india_learner/views/ClassesOrCoursesScreen.dart';
import 'package:india_learner/views/PlusCourseListLive.dart';

class PlusCoursesScreen extends StatefulWidget {
  PlusCoursesScreenState createState() => PlusCoursesScreenState();
}

class PlusCoursesScreenState extends State<PlusCoursesScreen> {
  Future<List<CourseList>> futureCourse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    courseBloc.featchAllCourses();

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
        title: Text('plus courses', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(ClassesOrCoursesScreen());
                /*Get.to(CourseListWidget(
                  courseId: '1',
                  type: Constants.paid,
                ));*/
              },
              child: Container(
                height: 120,
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                    boxShadow: [
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
                child: Column(
                  children: [
                    Image.asset('assets/images/download.jpg'),
                    SizedBox(
                      height: 2,
                    ),
                    Text('Video courses')
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                height: 120,
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                    boxShadow: [
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
                child: Column(
                  children: [
                    Image.asset('assets/images/elearning.png'),
                    SizedBox(
                      height: 2,
                    ),
                    Text('Live courses')
                  ],
                ),
              ),
              onTap: () {
                Get.to(PlusCourseListLive());
              },
            )
          ],
        ),
      )
          /*StreamBuilder(
        stream: courseBloc.courseFetcher,
        builder: (context, AsyncSnapshot<List<CourseList>> snapshot) {
          bool isAvailable;
          if (snapshot.hasData) {
            print("SSSSSSS hasdata ${snapshot}");
            List<CourseList> listCourse = snapshot.data;
            return isAvailable != false
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: listCourse != null
                        ? ListView.builder(
                            itemCount: listCourse.length,
                            itemBuilder: (context, index) {
                              if (listCourse[index].isFree == '2') {
                                isAvailable = true;
                              }
                              return GestureDetector(
                                onTap: () async {
                                  Get.to(FreeLiveClassListScreen());
                                  // Get.to(CourseListWidget());
                                },
                                child: listCourse[index].isFree == '2'
                                    ? Container(
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              child: Container(
                                                height: 80,
                                                //
                                                //color: Colors.white,
                                                child: Row(children: [
                                                  Expanded(
                                                      flex: 3,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                        child: listCourse[index].file == null || listCourse[index].file == ''
                                                            ? Image.asset(
                                                                'assets/images/teachers.jpg',
                                                                height: 70,
                                                                scale: 1.0,
                                                                width: 70,
                                                              )
                                                            : Image.network(listCourse[index].file),
                                                      )),
                                                  Expanded(
                                                      flex: 5,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            listCourse[index].courseName,
                                                            style: TextStyle(fontSize: 14, height: 1.3, color: Colors.black, fontWeight: FontWeight.w600),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            'Duration ' + listCourse[index].startDate + ' To ' + listCourse[index].endDate,
                                                            style: TextStyle(fontSize: 14, height: 1.3, color: Colors.black, fontWeight: FontWeight.w600),
                                                          )
                                                        ],
                                                      )),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(),
                                                  )
                                                ]),
                                              ),
                                            ),
                                            Container(
                                              height: 1,
                                              width: Get.size.width / 1.1,
                                              color: Colors.black12,
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(),
                              );
                            })
                        : Utils.noData,
                  )
                : Utils.noData;
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            print("SSSSSSS waiting ${snapshot}");

            return Utils.loader;
          } else {
            print("SSSSSSS  ${snapshot}");

            return Utils.noData;
          }
        },
      )*/
          ),
    );
  }
}
