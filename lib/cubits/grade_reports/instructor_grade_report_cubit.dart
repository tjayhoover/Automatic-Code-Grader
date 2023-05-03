import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/states/instructor_grade_report_states.dart';
import 'package:project3_ui/entities/grade_report.dart';
import 'package:project3_ui/repositories/instructor_grade_reports/implementation/instructor_grade_report_repository_mock.dart';

// TODO: Currently a mock; replace with networked solution.
import 'package:project3_ui/repositories/instructor_grade_reports/interface/instructor_grade_report_repository_interface.dart';

class InstructorGradeReport extends Cubit<InstructorGradeReportState> {
  InstructorGradeReportRepository repo = InstructorGradeReportRepositoryMock();

  InstructorGradeReport() : super(InstructorGradeReportLoadingState());

  void loadReport() async {
    emit(InstructorGradeReportLoadingState());

    List<GradeReport> reportList = await repo.getAllReports();

    // TODO: Check for success in the networked solution; for now we assume
    // the request always succeeds.

    if (true) {
      emit(InstructorGradeReportLoadedState(reportList));
    } else {
      emit(InstructorGradeReportFailureState());
    }
  }
}
