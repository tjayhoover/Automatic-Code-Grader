import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/repositories/instructor/implementation/mock_instructor_repository.dart';
import 'package:project3_ui/repositories/instructor/interface/intructor_repository.dart';

import '../entities/assignment.dart';
import 'assignment_state.dart';

class AssignmentCubit extends Cubit<AssignmentState> {
  AssignmentCubit() : super(AssignmentInitialState());

  MockInstructorRepo repo = MockInstructorRepo();

  Future<void> uploadAssignment(String name, DateTime dueDate, String desc,
      List<String> inputs, List<String> outputs) async {
    try {
      if (name != "" &&
          desc != "" &&
          inputs.isNotEmpty &&
          outputs.isNotEmpty &&
          inputs.length == outputs.length) {
        emit(AssignmentLoadingState());
        Assignment a =
            await repo.postAssignment(name, desc, dueDate, inputs, outputs);
        emit(AssignmentLoadedState(a));
      } else {
        emit(AssignmentFailureState());
      }
    } catch (e) {
      emit(AssignmentFailureState());
    }
  }
}
