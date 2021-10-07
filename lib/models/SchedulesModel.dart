class ScheduleList {
  String statusCode;
  String message;
  List<ScheduleList> scheduleList;

  ScheduleList({this.statusCode, this.message, this.scheduleList});

  ScheduleList.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['schedule_list'] != null) {
      scheduleList = new List<ScheduleList>();
      json['schedule_list'].forEach((v) {
        scheduleList.add(new ScheduleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.scheduleList != null) {
      data['schedule_list'] = this.scheduleList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScheduleList {
  String id;
  String startTime;
  String endTime;
  String courseName;
  String categoryId;
  String subcategoryId;

  ScheduleList({this.id, this.startTime, this.endTime, this.courseName, this.categoryId, this.subcategoryId});

  ScheduleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    courseName = json['course_name'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['course_name'] = this.courseName;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    return data;
  }
}
