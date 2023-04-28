import '../interface/student_repository.dart';
import '../../../entities/assignment.dart';

class MockStudentRepo implements StudentRepository {
  List<Assignment> getPendingAssignments(int studentID) {
    List<Assignment> assignment_list = [
      Assignment(1, "Test One", DateTime.now(), "This is test #1."),
      Assignment(2, "Test2", DateTime.now(), "This is amazing"),
    ];
    return assignment_list;
  }
}
