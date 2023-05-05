import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/entities/assignment.dart';
import 'package:project3_ui/cubits/states/assignment_state.dart';
import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';

import 'package:get_it/get_it.dart';
import 'package:project3_ui/repositories/login/interface/login_repository.dart';

class UploadAssignmentCubit extends Cubit<AssignmentState> {
  late AssignmentRepository repo;

  UploadAssignmentCubit() : super(AssignmentInitialState()) {
    repo = GetIt.I<AssignmentRepository>();
  }

  Future<void> uploadAssignment(String name, DateTime dueDate, String desc,
      List<File> inputs, List<File> outputs) async {
    try {
      if (name != "" && desc != "" && inputs.isNotEmpty && outputs.isNotEmpty) {
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
    assignmentRepo = GetIt.I<AssignmentRepository>();
  }

  void loadPendingAssignments() async {
    try {
      emit(AssignmentLoadingState());
      var user = GetIt.I<LoginRepository>().getCurrentUser();
      if (user != null) {
        final assignments = await _fetchPendingAssignments(user.id);
        emit(AssignmentsLoadedState(assignments));
      } else {
        emit(AssignmentFailureState());
      }
    } catch (e) {
      emit(AssignmentsFailureState());
    }
  }

  // Query the assignment repo for the pending assignments
  Future<List<Assignment>> _fetchPendingAssignments(int studentID) async {
    var assignments = assignmentRepo.getPendingAssignments(studentID);
    return assignments;
  }
}
