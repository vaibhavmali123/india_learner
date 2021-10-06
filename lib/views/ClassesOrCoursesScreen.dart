import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/CourseBloc.dart';
import 'package:india_learner/models/CourseListModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/views/CourseVideos.dart';

class ClassesOrCoursesScreen extends StatefulWidget {
  ClassesOrCoursesScreenState createState() => ClassesOrCoursesScreenState();
}

class ClassesOrCoursesScreenState extends State<ClassesOrCoursesScreen> {
  Future<List<CourseList>> futureCourse;
  List<CourseList> listCourse = [];
  String theme;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      futureCourse = Repository.getCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = MediaQuery.of(context).platformBrightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme;
    courseBloc.featchAllCourses();
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
        title: Text('Free classes & courses', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: Container(
//        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: courseBloc.courseFetcher,
              builder: (context, AsyncSnapshot<List<CourseList>> snapshot) {
                if (snapshot.hasData) {
                  listCourse = snapshot.data;

                  return listCourse.length > 0
                      ? ListView.builder(
                          itemCount: listCourse.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                Get.to(CourseListWidget(
                                  courseId: listCourse[index].courseId,
                                ));
                              },
                              child: listCourse[index].isFree == '0'
                                  ? Container(
                                      color: theme == Constants.lightTheme ? Colors.white : color.darkCard,
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            child: Container(
                                              height: 80,
                                              //                                                color: Colors.white,
                                              child: Row(children: [
                                                Expanded(
                                                    flex: 3,
                                                    child: Image.asset(
                                                      'assets/images/teachers.jpg',
                                                      height: 70,
                                                      scale: 1.0,
                                                      width: 70,
                                                    )),
                                                Expanded(
                                                    flex: 5,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          listCourse[index].courseName,
                                                          style: TextStyle(fontSize: 14, height: 1.3, color: Colors.black, fontWeight: FontWeight.w600),
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          'Duration: ' + listCourse[index].duration,
                                                          style: TextStyle(fontSize: 14, height: 1.3, color: Colors.black, fontWeight: FontWeight.w600),
                                                        ),
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
                      : Utils.noData;
                } else {
                  return Utils.loader;
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
