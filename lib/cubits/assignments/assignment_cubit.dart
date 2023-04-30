import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/repositories/assignments/implementation/mock_assignment_repository.dart';

import '../../entities/assignment.dart';
import '../states/assignment_state.dart';

class UploadAssignmentCubit extends Cubit<AssignmentState> {
  MockAssignmentRepository repo = MockAssignmentRepository();

  UploadAssignmentCubit() : super(AssignmentInitialState());

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
