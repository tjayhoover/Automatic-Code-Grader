import 'dart:io';

import 'package:project3_ui/entities/assignment.dart';
import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';

class MockAssignmentRepository implements AssignmentRepository {
  @override
  List<Assignment> getPendingAssignments(int studentID) {
    List<Assignment> assignmentList = [
      Assignment(id: 1, "Test One", DateTime.now(), "This is test #1."),
      Assignment(id: 2, "Test2", DateTime.now(), "This is amazing"),
    ];
    return assignmentList;
  }

  @override
  Future<Assignment> postAssignment(String name, String desc, DateTime dueDate,
      List<File> inputs, List<File> outputs) async {
    await Future.delayed(Duration(seconds: 1));
    return Assignment(
        id: 1, name, dueDate, desc, inputs: inputs, outputs: outputs);
  }
}
