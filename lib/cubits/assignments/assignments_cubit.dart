import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/entities/assignment.dart';

// This may actually be evil
import 'package:project3_ui/main.dart';


import 'package:project3_ui/cubits/states/assignment_state.dart';
import 'package:project3_ui/repositories/assignments/implementation/mock_assignment_repository.dart';
import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';

class UploadAssignmentCubit extends Cubit<AssignmentState> {
  late AssignmentRepository repo;

  UploadAssignmentCubit() : super(AssignmentInitialState()) {
    repo = getIt<AssignmentRepository>();
  }

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
  late AssignmentRepository assignmentRepo;
  AssignmentListCubit() : super(AssignmentInitialState()) {
    assignmentRepo = getIt<AssignmentRepository>();
  }

  void loadPendingAssignments(int studentID) async {
    try {
      final assignments = await _fetchPendingAssignments(studentID);
      emit(AssignmentsLoadedState(assignments));
    } catch (e) {
      emit(AssignmentsFailureState());
    }
  }

  // For testing only
  AssignmentRepository mockRepo = MockAssignmentRepository();

  // Query the assignment repo for the pending assignments
  Future<List<Assignment>> _fetchPendingAssignments(int studentID) async {
    // TODO: Implement fetching of assignments from API or database
    var assignments = mockRepo.getPendingAssignments(studentID);
    return assignments;
  }
}
