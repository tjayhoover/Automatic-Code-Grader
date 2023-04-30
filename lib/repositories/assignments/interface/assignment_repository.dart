import 'package:project3_ui/entities/assignment.dart';

abstract class AssignmentRepository {
  // Returns a list of all pending assignments
  List<Assignment> getPendingAssignments(int sutdentID);

  // TODO: add the other required methods to this interface
}
