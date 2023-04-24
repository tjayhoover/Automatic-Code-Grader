import '../../../entities/assignment.dart';

abstract class StudentRepository {
  // Returns a list of all pending assignments
  List<Assignment> getPendingAssignments(int sutdentID);
}
