class SubtestModel {
  String statusCode;
  String message;
  List<SubtestDetailsList> subtestDetailsList;

  SubtestModel({this.statusCode, this.message, this.subtestDetailsList});

  SubtestModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['subtest_details_list'] != null) {
      subtestDetailsList = new List<SubtestDetailsList>();
      json['subtest_details_list'].forEach((v) {
        subtestDetailsList.add(new SubtestDetailsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.subtestDetailsList != null) {
      data['subtest_details_list'] = this.subtestDetailsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubtestDetailsList {
  String id;
  String testTypeId;
  String subtest;

  SubtestDetailsList({this.id, this.testTypeId, this.subtest});

  SubtestDetailsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testTypeId = json['test_type_id'];
    subtest = json['subtest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['test_type_id'] = this.testTypeId;
    data['subtest'] = this.subtest;
    return data;
  }
}
