class LiveSessionListModel {
  String statusCode;
  String message;
  List<LiveList> liveList;

  LiveSessionListModel({this.statusCode, this.message, this.liveList});

  LiveSessionListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['live_list'] != null) {
      liveList = new List<LiveList>();
      json['live_list'].forEach((v) {
        liveList.add(new LiveList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.liveList != null) {
      data['live_list'] = this.liveList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LiveList {
  String id;
  String zoomId;
  String session;
  String courseId;
  String batchId;
  String startTime;
  String endTime;
  String title;
  String date;

  LiveList({this.id, this.zoomId, this.session, this.courseId, this.batchId, this.startTime, this.endTime, this.title, this.date});

  LiveList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zoomId = json['zoom_id'];
    session = json['session'];
    courseId = json['course_id'];
    batchId = json['batch_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    title = json['title'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['zoom_id'] = this.zoomId;
    data['session'] = this.session;
    data['course_id'] = this.courseId;
    data['batch_id'] = this.batchId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['title'] = this.title;
    data['date'] = this.date;
    return data;
  }
}
