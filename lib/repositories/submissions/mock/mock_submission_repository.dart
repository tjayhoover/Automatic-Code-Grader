import 'package:project3_ui/repositories/submissions/interface/submission_repository.dart';
import 'dart:io';

class MockSubmissionRepo implements SubmissionRepository {
  @override
  Future<List<int>> submitAssignment(
      int assignmentID, int studentID, File code) async {
    await Future.delayed(const Duration(seconds: 1));
    print("delayed call");
    return [5, 10];
  }
}
