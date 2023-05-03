import 'package:project3_ui/entities/assignment.dart';

abstract class AssignmentRepository {
  // Returns a list of all pending assignments
  List<Assignment> getPendingAssignments(int sutdentID);

  Future<Assignment> postAssignment(String name, String desc, DateTime dueDate,
      List<String> inputs, List<String> outputs);

  // TODO: add the other required methods to this interface
}
