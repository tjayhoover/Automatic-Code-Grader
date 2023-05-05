import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/states/submission_state.dart';
import 'package:get_it/get_it.dart';
import 'package:project3_ui/repositories/login/interface/login_repository.dart';

class SubmissionCubit extends Cubit<SubmissionState> {
  late AssignmentRepository assignmentRepo;
  SubmissionCubit() : super(SubmissionInitialState()) {
    assignmentRepo = GetIt.I<AssignmentRepository>();
  }
  void submitAssignment(int assignmentID, File code) async {
    try {
      emit(SubmissionLoadingState());
      var user = GetIt.I<LoginRepository>().getCurrentUser();
      if (user != null) {
        List<int> scores = await _submitAssignment(assignmentID, user.id, code);
        emit(SubmissionLoadedState(scores[0], scores[1]));
      } else {
        emit(SubmissionFailureState());
      }
    } catch (e) {
      emit(SubmissionFailureState());
    }
  }

  void emitInit() {
    emit(SubmissionInitialState());
  }

  Future<List<int>> _submitAssignment(
      int assignmentID, int studentID, File code) async {
    return assignmentRepo.submitAssignment(assignmentID, studentID, code);
  }
}
