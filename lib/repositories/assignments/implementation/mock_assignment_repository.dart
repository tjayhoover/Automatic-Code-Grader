import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';
import 'package:project3_ui/entities/assignment.dart';

class MockAssignmentRepository implements AssignmentRepository {

  @override
  List<Assignment> getPendingAssignments(int studentID) {
    List<Assignment> assignmentList = [
      Assignment(1, "Test One", DateTime.now(), "This is test #1."),
      Assignment(2, "Test2", DateTime.now(), "This is amazing"),
    ];
    return assignmentList;
  }
}
