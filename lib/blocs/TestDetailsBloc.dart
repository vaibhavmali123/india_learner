import 'package:india_learner/models/SubtestModel.dart';
import 'package:india_learner/models/TestDetailsModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:rxdart/rxdart.dart';

class TestDetailsBloc {
  final testDetailsBlocFetcher = PublishSubject<List<TestDetailsList>>();

  Stream<List<TestDetailsList>> get testDetailsStream => testDetailsBlocFetcher.stream;

  getTestDetails(SubtestDetailsList subtestDetailsList) async {
    List<TestDetailsList> listTestDetails = await Repository.geTestDetails(subtestDetailsList: subtestDetailsList);

    testDetailsBlocFetcher.sink.add(listTestDetails);
  }
}

final testDetailsBloc = TestDetailsBloc();
