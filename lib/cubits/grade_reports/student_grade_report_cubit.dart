import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/entities/grade_report.dart';
import 'package:project3_ui/main.dart';
import 'package:project3_ui/repositories/student_grade_reports/interface/student_grade_reports_repository.dart';

import '../../repositories/student_grade_reports/implementation/mock_sgr_repository.dart';
import '../states/student_grade_report_state.dart';

class StudentGradeReport extends Cubit<StudentGradeReportState> {

  late StudentGradeReportRepository repo;

  StudentGradeReport() : super(StudentGradeReportInitialState()) {
    repo = getIt<MockSgrRepository>();
  }

  void reportRequested() async {
    emit(StudentGradeReportLoadingState());
    //load reports from server
    bool success = true;
    List<GradeReport> reports = await repo.getGradeReports(1);
    //TODO figure out id numbers
    if (success)
      emit(StudentGradeReportLoadedState(reports));
    else
      emit(StudentGradeReportFailureState());
  }
}
