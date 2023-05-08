import 'package:project3_ui/repositories/submissions/interface/submission_repository.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/states/submission_state.dart';
import 'package:get_it/get_it.dart';
import 'package:project3_ui/repositories/login/interface/login_repository.dart';

class SubmissionCubit extends Cubit<SubmissionState> {
  late SubmissionRepository submissionRepo;
  SubmissionCubit() : super(SubmissionInitialState()) {
    submissionRepo = GetIt.I<SubmissionRepository>();
  }
  void submitAssignment(int assignmentID, String code) async {
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
      int assignmentID, int studentID, String code) async {
    return submissionRepo.submitAssignment(assignmentID, studentID, code);
  }
}
