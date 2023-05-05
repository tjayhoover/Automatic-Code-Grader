import 'dart:io';

abstract class SubmissionRepository {
  // Submit an assignment and get a grade back
  // Returns a list containing two integers. The first one is the number
  // of cases passed, the second is the total number of cases
  Future<List<int>> submitAssignment(
      int assignmentID, int studentID, File code);
}
