import 'package:flutter_bloc/flutter_bloc.dart';

import 'student_grade_report_state.dart';

class StudentGradeReport extends Cubit<StudentGradeReportState> {
  StudentGradeReport() : super(StudentGradeReportInitialState());

  void ReportRequested(){
    
  }

}
