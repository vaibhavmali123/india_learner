import 'dart:convert';

import 'package:get/route_manager.dart';
import 'package:india_learner/models/BatchModel.dart';
import 'package:india_learner/models/ClassesSessionListModel.dart';
import 'package:india_learner/models/CourseListModel.dart';
import 'package:india_learner/models/EnrollmentsModel.dart';
import 'package:india_learner/models/LiveSessionListModel.dart';
import 'package:india_learner/models/LoginModel.dart';
import 'package:india_learner/models/PlusCourseModel.dart';
import 'package:india_learner/models/PlusSessionModel.dart';
import 'package:india_learner/models/SchedulesModel.dart';
import 'package:india_learner/models/SignupModel.dart';
import 'package:india_learner/models/SubtestModel.dart';
import 'package:india_learner/models/TeacherListModel.dart';
import 'package:india_learner/models/TestDetailsModel.dart';
import 'package:india_learner/models/TestTypeModel.dart';
import 'package:india_learner/models/TopVideosModel.dart';
import 'package:india_learner/utils/ToastMessage.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/CategoriesPage.dart';
import 'package:india_learner/views/ClassSelectionPage.dart';
import 'package:india_learner/views/DashBoard.dart';

import 'ApiHandler.dart';
import 'ApiProvider.dart';
import 'EndApi.dart';

class Repository {
  // COURSES FETCH API by catId,subCatIS

  static Future<List<CourseList>> getCourses() async {
    Database.initDatabase();
    print("REQUEST COURSE ${Database.getUserID()}");
    var obj = {'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId(), 'user_id': Database.getUserID()};
    print("REQUEST COURSE ${obj}");
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.courseList, map: obj).then((value) {
      List<CourseList> courseList = CourseListModel.fromJson(value).courseList;
      return courseList;
    });
  }

  static Future<List<TeacherList>> getTeachers() async {
    Database.initDatabase();

    var obj = {'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId()};
    print("REQUEST ${obj}");
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.teachersList, map: obj).then((value) {
      List<TeacherList> teachersList = TeacherListModel.fromJson(value).teacherList;
      return teachersList;
    });
  }

  static Future<Map<String, dynamic>> updateCategory({String categoryName, String categoryId, String subCategoryId, String classId}) {
    var obj = {'id': Database.getUserID(), 'category_name': categoryName, 'category_id': categoryId, 'subcategory_id': subCategoryId, 'class_id': classId};
    print("REQUEST  ${obj.toString()}");

    ApiHandler.putApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.updateCaegory, map: json.encode(obj)).then((value) {
      print("RES ${value.toString()}");
      if (value['Status_code'] == '200') {
        ToastMessage.showToast(message: 'Category updated successfuly', type: true);
        print("RES ${subCategoryId}");
        Database.initDatabase();
        Database.saveSelectedCategory(category: categoryName, categoryId: categoryId);
        print("RES ${Database.getSelectedCategoryId()}");
        Get.to(ClassSelectionPage());
        Get.to(DashBoard());
      }
    });
  }

  static Future<Map<String, dynamic>> login({String email, String password}) {
    Database.initDatabase();
    var obj = {'email': email, 'password': password};
    ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.login, map: obj).then((value) {
      if (value['Status_code'] == '200') {
        LoginModel loginModel = LoginModel.fromJson(value);
        Database.initDatabase();
        Database.saveUserId(loginModel.result.userId);

        if (loginModel.result.categoryName != null) {
          Database.saveSelectedCategory(
            category: loginModel.result.categoryName,
            categoryId: loginModel.result.categoryId,
          );
          Database.saveSubCategory(subcatId: loginModel.result.subcategoryId, subcategory: "");
          Get.off(DashBoard());
        } else {
          Get.to(CategoriesPage());
        }
      } else {
        ToastMessage.showToast(message: 'Invalid email or password', type: false);
      }
    });
  }

  static Future<Map<String, dynamic>> signup({String fName, String lName, String mno, String email, String bio, String password}) {
    var obj = {"first_name": fName, "last_name": lName, "mobile_number": mno, "email": email, "password": password, "bio": bio};
    ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.createAccount, map: obj).then((value) {
      print("RESPONSE ${value.toString()}");
      if (value['Status_code'] == '200') {
        SignupModel signupModel = SignupModel.fromJson(value);
        Database.initDatabase();
        Database.saveUserId(signupModel.result.userId);
        Get.to(CategoriesPage());
        print("RESPONSE ID ${Database.getUserID()}");
      } else {
        ToastMessage.showToast(message: value['Message'], type: false);
      }
    });
  }

  static Future<Map<String, dynamic>> subscribe({String planName}) {
    Database.initDatabase();

    var obj = {'user_id': Database.getUserID(), 'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId(), 'plan_name': '1Month'};

    print("REQ ${obj.toString()}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.subscription, map: obj).then((value) {
      print("RES ${value.toString()}");

      if (value['Status_code'] == '200') {
        ToastMessage.showToast(message: 'Subscription  successfuly', type: true);
      }
    });
  }

  static Future<Map<String, dynamic>> getVideos() {
    return ApiHandler.getApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.courseVideos);
  }

  static Future<Map<String, dynamic>> getClasses() async {
    var obj = {'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId()};
    print("REQUEST ${obj.toString()}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.classes, map: obj);
  }

  static Future<Map<String, dynamic>> advertisement() {
    Database.initDatabase();

    var obj = {
      'category_id': Database.getSelectedCategoryId(),
    };

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.advertisement, map: obj);
  }

  static Future<List<LiveList>> getLiveSessionList({String courseId}) async {
    var obj = {'course_id': courseId};
    print("REQ ${obj.toString()}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.live_session_list, map: obj).then((value) {
      List<LiveList> listSessions = LiveSessionListModel.fromJson(value).liveList;
      return listSessions;
    });
  }

  static Future<List<VideoList>> getClassesSessionList({String courseId}) async {
    var obj = {'course_id': courseId};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.freeClassesSessions, map: obj).then((value) {
      List<VideoList> listSessions = ClassesSessionListModel.fromJson(value).videoList;
      return listSessions;
    });
  }

  static Future<List<EnrollmentsList>> getEnrollments() async {
    Database.initDatabase();
    String userId = Database.getUserID();
    var obj = {'user_id': userId};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.enrollments, map: obj).then((value) {
      List<EnrollmentsList> listSessions = EnrollmentsModel.fromJson(value).enrollmentsList;
      return listSessions;
    });
  }

  static Future<List<ScheduleList>> getSchedules() async {
    Database.initDatabase();
    String userId = Database.getUserID();
    var obj = {'user_id': userId};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.schedule, map: obj).then((value) {
      List<ScheduleList> listSchedules = SchedulesModel.fromJson(value).scheduleList;
      return listSchedules;
    });
  }

  static Future<List<TopVideosList>> getTopVideos() async {
    Database.initDatabase();
    var obj = {'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId()};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.topVideos, map: obj).then((value) {
      List<TopVideosList> listTopVideos = TopVideosModel.fromJson(value).topVideosList;

      return listTopVideos;
    });
  }

  static Future<List<TestTypeList>> getTestTypes() async {
    Database.initDatabase();
    var obj = {'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId()};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.testType, map: obj).then((value) {
      List<TestTypeList> listTestType = TestTypeModel.fromJson(value).testTypeList;

      return listTestType;
    });
  }

  static Future<List<SubtestDetailsList>> getSubTest({String testTypeId}) async {
    Database.initDatabase();
    var obj = {'test_type_id': testTypeId};

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.subtest, map: obj).then((value) {
      List<SubtestDetailsList> listSubTest = SubtestModel.fromJson(value).subtestDetailsList;

      return listSubTest;
    });
  }

  static Future<List<TestDetailsList>> geTestDetails({SubtestDetailsList subtestDetailsList}) async {
    Database.initDatabase();
    var obj = {'subtest': subtestDetailsList.id, 'category_id': Database.getSelectedCategoryId(), 'subcategory_id': Database.getSubcategoryId(), 'test_type': subtestDetailsList.testTypeId};
    print("REQUEST ${obj}");
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.testDetails, map: obj).then((value) {
      List<TestDetailsList> listSubTest = TestDetailsModel.fromJson(value).testDetailsList;

      return listSubTest;
    });
  }

  static Future<List<PlusCourseList>> getPlusCourses() async {
    Database.initDatabase();
    var obj = {
      'category_id': Database.getSelectedCategoryId(),
      'subcategory_id': Database.getSubcategoryId(),
    };

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.plusCourses, map: obj).then((value) {
      List<PlusCourseList> plusCourseList = PlusCourseModel.fromJson(value).plusCourseList;

      return plusCourseList;
    });
  }

  static Future<List<BatchList>> fetchBatches() {
    var obj = {
      'category_id': '1' /*Database.getSelectedCategoryId()*/,
      'subcategory_id': /* Database.getSubcategoryId()*/ '18',
    };

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.batch, map: obj).then((value) {
      List<BatchList> batchList = BatchModel.fromJson(value).batchList;
      return batchList;
    });
  }

  static Future<List<LiveList>> getLiveSessionListHome({String ctegoryId, String subCategoryId}) async {
    var obj = {'category_id': ctegoryId, 'subcategory_id': subCategoryId};
    print("REQ ${obj.toString()}");

    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.sessionListHome, map: obj).then((value) {
      List<LiveList> listSessions = LiveSessionListModel.fromJson(value).liveList;
      return listSessions;
    });
  }

  static Future<PlusSessionModel> getPlusSessions() {
    var request = {"course_id": "3"};
    return ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.plusSession,map:request).then((value) {
      PlusSessionModel plusSessionModel = PlusSessionModel.fromJson(value);

      return plusSessionModel;
    });
  }
}
