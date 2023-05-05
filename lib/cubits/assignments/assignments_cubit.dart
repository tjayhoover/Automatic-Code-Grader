import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/entities/assignment.dart';
import 'package:project3_ui/cubits/states/assignment_state.dart';
import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';

import 'package:project3_ui/injection.dart';

class UploadAssignmentCubit extends Cubit<AssignmentState> {
  late AssignmentRepository repo;

  UploadAssignmentCubit() : super(AssignmentInitialState()) {
    repo = getIt<AssignmentRepository>();
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
    assignmentRepo = getIt<AssignmentRepository>();
  }

  void loadPendingAssignments(int studentID) async {
    try {
      emit(AssignmentLoadingState());
      final assignments = await _fetchPendingAssignments(studentID);
      emit(AssignmentsLoadedState(assignments));
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
