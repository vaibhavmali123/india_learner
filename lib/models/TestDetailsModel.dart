class TestDetailsModel {
  String statusCode;
  String message;
  List<TestDetailsList> testDetailsList;

  TestDetailsModel({this.statusCode, this.message, this.testDetailsList});

  TestDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['test_details_list'] != null) {
      testDetailsList = new List<TestDetailsList>();
      json['test_details_list'].forEach((v) {
        testDetailsList.add(new TestDetailsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.testDetailsList != null) {
      data['test_details_list'] = this.testDetailsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestDetailsList {
  String id;
  String testId;
  String testType;
  String testDate;
  String categoryId;
  String subcategoryId;
  String className;
  String courseName;
  String mark;
  List<TestItemDetails> testItemDetails;

  TestDetailsList({this.id, this.testId, this.testType, this.testDate, this.categoryId, this.subcategoryId, this.className, this.courseName, this.mark, this.testItemDetails});

  TestDetailsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testId = json['test_id'];
    testType = json['test_type'];
    testDate = json['test_date'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    className = json['class_name'];
    courseName = json['course_name'];
    mark = json['mark'];
    if (json['test_item_details'] != null) {
      testItemDetails = new List<TestItemDetails>();
      json['test_item_details'].forEach((v) {
        testItemDetails.add(new TestItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['test_id'] = this.testId;
    data['test_type'] = this.testType;
    data['test_date'] = this.testDate;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['class_name'] = this.className;
    data['course_name'] = this.courseName;
    data['mark'] = this.mark;
    if (this.testItemDetails != null) {
      data['test_item_details'] = this.testItemDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestItemDetails {
  String id;
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String answer;

  TestItemDetails({this.id, this.question, this.option1, this.option2, this.option3, this.option4, this.answer});

  TestItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    option1 = json['option1'];
    option2 = json['option2'];
    option3 = json['option3'];
    option4 = json['option4'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['option1'] = this.option1;
    data['option2'] = this.option2;
    data['option3'] = this.option3;
    data['option4'] = this.option4;
    data['answer'] = this.answer;
    return data;
  }
}
