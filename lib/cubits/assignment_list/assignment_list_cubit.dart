import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/assignment.dart';
import '../../states/assignment_state.dart';
import '../../repositories/student/implementation/mock_student_repository.dart';

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

  final assignmentRepo = MockStudentRepo();

  // Query the assignment repo for the pending assignments
  Future<List<Assignment>> _fetchAssignments() async {
    // TODO: Implement fetching of assignments from API or database

    print("getting assignments");
    var assignments = assignmentRepo.getPendingAssignments(1);

    print(assignments.length);
    return assignments;
  }
}
