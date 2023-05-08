import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/entities/grade_report.dart';
import 'package:project3_ui/repositories/student_grade_reports/interface/student_grade_reports_repository.dart';
import '../../repositories/login/interface/login_repository.dart';
import '../states/student_grade_report_state.dart';
import 'package:get_it/get_it.dart';

class StudentGradeReport extends Cubit<StudentGradeReportState> {
  late StudentGradeReportRepository repo;

  StudentGradeReport() : super(StudentGradeReportInitialState()) {
    repo = GetIt.I<StudentGradeReportRepository>();
  }

  void reportRequested() async {
    emit(StudentGradeReportLoadingState());
    //load reports from server
    var user = GetIt.I<LoginRepository>().getCurrentUser();
    if (user != null) {
      List<GradeReport> reports = await repo.getGradeReports(user.id);
      if (reports.isNotEmpty) {
        emit(StudentGradeReportLoadedState(reports));
      } else {
        emit(StudentGradeReportFailureState());
      }
    } else {
      emit(StudentGradeReportFailureState());
    }
  }
}
