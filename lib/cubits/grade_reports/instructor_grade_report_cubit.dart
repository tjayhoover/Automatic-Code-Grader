import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project3_ui/cubits/states/instructor_grade_report_states.dart';
import 'package:project3_ui/entities/assignment_grade_report.dart';
import 'package:project3_ui/repositories/instructor_grade_reports/interface/instructor_grade_report_repository_interface.dart';
import 'package:project3_ui/repositories/login/interface/login_repository.dart';

class InstructorGradeReport extends Cubit<InstructorGradeReportState> {
  late InstructorGradeReportRepository repo;

  InstructorGradeReport() : super(InstructorGradeReportLoadingState()) {
    repo = GetIt.I<InstructorGradeReportRepository>();
  }

  void loadReport() async {
    try {
      emit(InstructorGradeReportLoadingState());

      var user = GetIt.I<LoginRepository>().getCurrentUser();

      if (user != null) {
        Map<String, List<AssignmentGradeReport>> gradeReport = {};
        final List<String> assignmentNames =
            await repo.getAllAssignmentNames(user.id);

        for (int i = 0; i < assignmentNames.length; ++i) {
          gradeReport[assignmentNames[i]] =
              await repo.getAllReports(assignmentNames[i], user.id);
        }
        emit(InstructorGradeReportLoadedState(gradeReport));
      } else {
        emit(InstructorGradeReportFailureState());
      }
    } catch (e) {
      emit(InstructorGradeReportFailureState());
    }
  }
}
