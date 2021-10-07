class SchedulesModel {
  String statusCode;
  String message;
  List<ScheduleList> scheduleList;

  SchedulesModel({this.statusCode, this.message, this.scheduleList});

  SchedulesModel.fromJson(Map<String, dynamic> json) {
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
  String categoryId;
  String subcategoryId;
  String userId;
  String planName;
  List<Category> category;
  List<Subcategory> subcategory;
  List<ClassName> className;
  List<Course> course;
  List<Time> time;

  ScheduleList({this.id, this.categoryId, this.subcategoryId, this.userId, this.planName, this.category, this.subcategory, this.className, this.course, this.time});

  ScheduleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    userId = json['user_id'];
    planName = json['plan_name'];
    if (json['category'] != null) {
      category = new List<Category>();
      json['category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
    if (json['subcategory'] != null) {
      subcategory = new List<Subcategory>();
      json['subcategory'].forEach((v) {
        subcategory.add(new Subcategory.fromJson(v));
      });
    }
    if (json['class_name'] != null) {
      className = new List<ClassName>();
      json['class_name'].forEach((v) {
        className.add(new ClassName.fromJson(v));
      });
    }
    if (json['course'] != null) {
      course = new List<Course>();
      json['course'].forEach((v) {
        course.add(new Course.fromJson(v));
      });
    }
    if (json['time'] != null) {
      time = new List<Time>();
      json['time'].forEach((v) {
        time.add(new Time.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['user_id'] = this.userId;
    data['plan_name'] = this.planName;
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory.map((v) => v.toJson()).toList();
    }
    if (this.className != null) {
      data['class_name'] = this.className.map((v) => v.toJson()).toList();
    }
    if (this.course != null) {
      data['course'] = this.course.map((v) => v.toJson()).toList();
    }
    if (this.time != null) {
      data['time'] = this.time.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String id;
  String categoryName;

  Category({this.id, this.categoryName});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    return data;
  }
}

class Subcategory {
  String id;
  String subcategoryName;

  Subcategory({this.id, this.subcategoryName});

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subcategoryName = json['subcategory_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subcategory_name'] = this.subcategoryName;
    return data;
  }
}

class ClassName {
  String id;
  String className;

  ClassName({this.id, this.className});

  ClassName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['class_name'] = this.className;
    return data;
  }
}

class Course {
  String id;
  String courseName;
  String startDate;
  String endDate;

  Course({this.id, this.courseName, this.startDate, this.endDate});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['course_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_name'] = this.courseName;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}

class Time {
  String id;
  String startTime;
  String endTime;

  Time({this.id, this.startTime, this.endTime});

  Time.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}
