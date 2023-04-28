import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/assignment.dart';
import '../../states/assignment_state.dart';
import '../../repositories/student/implementation/mock_student_repository.dart';
part 'assignment_list_events.dart';

class AssignmentListBloc extends Bloc<AssignmentEvent, AssignmentState> {
  AssignmentListBloc() : super(AssignmentInitialState()) {
    on<LoadAssignments>((event, emit) async {
      try {
        final assignments = await _fetchAssignments();
        emit(AssignmentsLoadedState(assignments));
      } catch (e) {
        emit(AssignmentsFailureState());
      }
    });
  }

  final assignment_repo = MockStudentRepo();

  // Query the assignment repo for the pending assignments
  Future<List<Assignment>> _fetchAssignments() async {
    // TODO: Implement fetching of assignments from API or database

    print("getting assignments");
    var assignments = assignment_repo.getPendingAssignments(1);

    print(assignments.length);
    return assignments;
  }
}
