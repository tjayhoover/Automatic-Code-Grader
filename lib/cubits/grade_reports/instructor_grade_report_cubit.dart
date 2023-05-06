import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project3_ui/cubits/states/instructor_grade_report_states.dart';
import 'package:project3_ui/entities/assignment_grade_report.dart';
import 'package:project3_ui/repositories/instructor_grade_reports/interface/instructor_grade_report_repository_interface.dart';

// TODO: Currently a mock; replace with networked solution.
import 'package:project3_ui/repositories/instructor_grade_reports/implementation/instructor_grade_report_repository_mock.dart';

class InstructorGradeReport extends Cubit<InstructorGradeReportState> {
  late InstructorGradeReportRepository repo;

  InstructorGradeReport() : super(InstructorGradeReportLoadingState()) {
    repo = GetIt.I<InstructorGradeReportRepository>();
  }

  void loadReport() async {
    emit(InstructorGradeReportLoadingState());

    Map<String, List<AssignmentGradeReport>> gradeReport = {};
    final List<String> assignmentNames = await repo.getAllAssignmentNames();

    for (int i = 0; i < assignmentNames.length; ++i) {
      gradeReport[assignmentNames[i]] =
          await repo.getAllReports(assignmentNames[i]);
    }

    // TODO: Check for success in the networked solution; for now we assume
    // the request always succeeds.

    if (true) {
      emit(InstructorGradeReportLoadedState(gradeReport));
    } else {
      emit(InstructorGradeReportFailureState());
    }
  }
}
