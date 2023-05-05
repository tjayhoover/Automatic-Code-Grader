import 'package:project3_ui/entities/assignment.dart';
import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';
import 'dart:io';

class MockAssignmentRepository implements AssignmentRepository {
  @override
  Future<List<Assignment>> getPendingAssignments(int studentID) async {
    List<Assignment> assignmentList = [
      Assignment(1, "Test Assignment One ", DateTime.now(),
          "This is test #1sdfgdssssssfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggfffffffffffffffffffffffffffffffffffeeeeerrerrrrrrrrrrrrrrrrrrrrrrr."),
      Assignment(2, "Test Assignment Two", DateTime.now(), "This is amazing"),
      Assignment(3, "Test Assignment Three", DateTime.now(), "This is amazing"),
      Assignment(4, "Test Assignment Four", DateTime.now(), "This is amazing"),
      Assignment(5, "Test Assignment Five", DateTime.now(), "This is amazing"),
      Assignment(6, "Test Assignment Six", DateTime.now(), "This is amazing"),
      Assignment(7, "Test Assignment Seven", DateTime.now(), "This is amazing"),
      Assignment(8, "Test Assignment Eight", DateTime.now(), "This is amazing"),
      Assignment(9, "Test Assignment Nine", DateTime.now(), "This is amazing"),
    ];
    await Future.delayed(const Duration(seconds: 1));
    return assignmentList;
  }

  @override
  Future<Assignment> postAssignment(String name, String desc, DateTime dueDate,
      List<String> inputs, List<String> outputs) async {
    await Future.delayed(const Duration(seconds: 1));
    return Assignment(1, name, dueDate, desc, inputs: inputs, outputs: outputs);
  }

  @override
  Future<List<int>> submitAssignment(
      int assignmentID, int studentID, File code) async {
    await Future.delayed(const Duration(seconds: 1));
    print("delayed call");
    return [5, 10];
  }
}
