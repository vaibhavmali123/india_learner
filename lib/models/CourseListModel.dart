class CourseListModel {
  String statusCode;
  String message;
  List<CourseList> courseList;

  CourseListModel({this.statusCode, this.message, this.courseList});

  CourseListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['course_list'] != null) {
      courseList = new List<CourseList>();
      json['course_list'].forEach((v) {
        courseList.add(new CourseList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.courseList != null) {
      data['course_list'] = this.courseList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseList {
  String courseId;
  String categoryId;
  String subcategoryId;
  String courseName;
  String file;
  String duration;
  String courseFee;
  String freeLiveClasses;
  String startDate;
  String endDate;
  String isFree;
  String planName;

  CourseList({this.courseId, this.categoryId, this.subcategoryId, this.courseName, this.file, this.duration, this.courseFee, this.freeLiveClasses, this.startDate, this.endDate, this.isFree, this.planName});

  CourseList.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    courseName = json['course_name'];
    file = json['file'];
    duration = json['duration'];
    courseFee = json['course_fee'];
    freeLiveClasses = json['free_live_classes'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    isFree = json['is_free'];
    planName = json['plan_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['course_name'] = this.courseName;
    data['file'] = this.file;
    data['duration'] = this.duration;
    data['course_fee'] = this.courseFee;
    data['free_live_classes'] = this.freeLiveClasses;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['is_free'] = this.isFree;
    data['plan_name'] = this.planName;
    return data;
  }
}
