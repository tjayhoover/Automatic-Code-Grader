import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/entities/grade_report.dart';

import 'student_grade_report_state.dart';

class StudentGradeReport extends Cubit<StudentGradeReportState> {
  StudentGradeReport() : super(StudentGradeReportInitialState());

  void reportRequested() {
    emit(StudentGradeReportLoadingState());
    //load reports from server
    bool success = true;
    List<GradeReport> reports = [];
    if (success)
      emit(StudentGradeReportLoadedState(reports));
    else
      emit(StudentGradeReportFailureState());
  }
}
