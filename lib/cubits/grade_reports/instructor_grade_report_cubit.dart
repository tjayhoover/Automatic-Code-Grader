import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/states/instructor_grade_report_states.dart';
import 'package:project3_ui/entities/assignment_grade_report.dart';
import 'package:project3_ui/repositories/instructor_grade_reports/interface/instructor_grade_report_repository_interface.dart';

// TODO: Currently a mock; replace with networked solution.
import 'package:project3_ui/repositories/instructor_grade_reports/implementation/instructor_grade_report_repository_mock.dart';

import 'package:project3_ui/injection.dart';

class InstructorGradeReport extends Cubit<InstructorGradeReportState> {
  InstructorGradeReportRepository repo = InstructorGradeReportRepositoryMock();

  InstructorGradeReport() : super(InstructorGradeReportLoadingState());

  void loadReport() async {
    emit(InstructorGradeReportLoadingState());

    List<AssignmentGradeReport> reportList = await repo.getAllReports();
    List<String> assignmentNames = await repo.getAllAssignmentNames();

    // TODO: Check for success in the networked solution; for now we assume
    // the request always succeeds.

    if (true) {
      emit(InstructorGradeReportLoadedState(assignmentNames, reportList));
    } else {
      emit(InstructorGradeReportFailureState());
    }
  }
}
