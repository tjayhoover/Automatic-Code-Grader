import '../interface/student_repository.dart';
import '../../../entities/assignment.dart';

class MockStudentRepo implements StudentRepository {
  List<Assignment> getPendingAssignments(int studentID) {
    List<Assignment> assignment_list = List.empty();
    Assignment a1 =
        Assignment(1, "Test Assignment One", DateTime.now(), "This is a test.");
    assignment_list.add(a1);
    return assignment_list;
  }
}
