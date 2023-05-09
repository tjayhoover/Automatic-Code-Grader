import 'dart:io';

import 'package:project3_ui/entities/assignment.dart';
import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';

class MockAssignmentRepository implements AssignmentRepository {
  @override
  Future<List<Assignment>> getPendingAssignments(int studentID) async {
    List<Assignment> assignmentList = [
      Assignment(
          id: 1,
          "Test Assignment One ",
          DateTime.now(),
          "This is test #1sdfgdssssssfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggfffffffffffffffffffffffffffffffffffeeeeerrerrrrrrrrrrrrrrrrrrrrrrr."),
      Assignment(
          id: 2, "Test Assignment Two", DateTime.now(), "This is amazing"),
      Assignment(
          id: 3, "Test Assignment Three", DateTime.now(), "This is amazing"),
      Assignment(
          id: 4, "Test Assignment Four", DateTime.now(), "This is amazing"),
      Assignment(
          id: 5, "Test Assignment Five", DateTime.now(), "This is amazing"),
      Assignment(
          id: 6, "Test Assignment Six", DateTime.now(), "This is amazing"),
      Assignment(
          id: 7, "Test Assignment Seven", DateTime.now(), "This is amazing"),
      Assignment(
          id: 8, "Test Assignment Eight", DateTime.now(), "This is amazing"),
      Assignment(
          id: 9, "Test Assignment Nine", DateTime.now(), "This is amazing"),
    ];
    await Future.delayed(const Duration(seconds: 1));
    return assignmentList;
  }

  @override
  Future<Assignment> postAssignment(String name, String desc, DateTime dueDate,
      List<File> inputs, List<File> outputs) async {
    await Future.delayed(const Duration(seconds: 1));
    return Assignment(
        id: 1, name, dueDate, desc, inputs: inputs, outputs: outputs);
  }
}
