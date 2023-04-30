import 'package:project3_ui/entities/assignment.dart';

import '../interface/intructor_repository.dart';

class MockInstructorRepo implements InstructorRepository {
  Future<Assignment> postAssignment(String name, String desc, DateTime dueDate,
      List<String> inputs, List<String> outputs) async {
    await Future.delayed(Duration(seconds: 1));
    return Assignment(1, name, dueDate, desc, inputs, outputs: outputs);
  }
}
