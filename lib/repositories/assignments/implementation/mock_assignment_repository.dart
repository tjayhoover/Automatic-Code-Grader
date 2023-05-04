import 'package:project3_ui/entities/assignment.dart';
import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';
import 'dart:io';

class MockAssignmentRepository implements AssignmentRepository {
  @override
  List<Assignment> getPendingAssignments(int studentID) {
    List<Assignment> assignmentList = [
      Assignment(1, "Test One", DateTime.now(), "This is test #1."),
      Assignment(2, "Test2", DateTime.now(), "This is amazing"),
    ];
    return assignmentList;
  }

  Future<Assignment> postAssignment(String name, String desc, DateTime dueDate,
      List<String> inputs, List<String> outputs) async {
    await Future.delayed(Duration(seconds: 1));
    return Assignment(1, name, dueDate, desc, inputs: inputs, outputs: outputs);
  }

  @override
  Future<List<int>> submitAssignment(
      int assignmentID, int studentID, File code) async {
    await Future.delayed(const Duration(seconds: 5));
    print("delayed call");
    return [5, 10];
  }
}
