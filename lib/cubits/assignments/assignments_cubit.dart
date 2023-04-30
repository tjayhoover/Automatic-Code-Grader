import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project3_ui/entities/assignment.dart';
import 'package:project3_ui/cubits/states/assignment_state.dart';
import 'package:project3_ui/repositories/assignments/implementation/mock_assignment_repository.dart';

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

  void resetState() async {
    emit(AssignmentInitialState());
  }
}

class AssignmentListCubit extends Cubit<AssignmentState> {
  AssignmentListCubit() : super(AssignmentInitialState());

  void loadAssignments() async {
    try {
      final assignments = await _fetchAssignments();
      emit(AssignmentsLoadedState(assignments));
    } catch (e) {
      emit(AssignmentsFailureState());
    }
  }

  // This is bad and just for testing.
  // Need to depend on an abstraction, not this concrete implementation.
  final assignmentRepo = MockAssignmentRepository();

  // Query the assignment repo for the pending assignments
  Future<List<Assignment>> _fetchAssignments() async {
    // TODO: Implement fetching of assignments from API or database

    print("getting assignments");
    var assignments = assignmentRepo.getPendingAssignments(1);

    print(assignments.length);
    return assignments;
  }
}
