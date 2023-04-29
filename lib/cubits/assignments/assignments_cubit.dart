import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project3_ui/entities/assignment.dart';
import 'package:project3_ui/cubits/states/assignment_state.dart';
import 'package:project3_ui/repositories/assignments/implementation/mock_assignment_repository.dart';

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
