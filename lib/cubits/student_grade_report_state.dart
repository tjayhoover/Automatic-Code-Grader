import 'package:equatable/equatable.dart';

import '../entities/grade_report.dart';

abstract class StudentGradeReportState extends Equatable {}

class StudentGradeReportInitialState extends StudentGradeReportState {
  @override
  List<Object?> get props => [];
}

class StudentGradeReportLoadingState extends StudentGradeReportState {
  @override
  List<Object?> get props => [];
}

class StudentGradeReportLoadedState extends StudentGradeReportState {
  final List<GradeReport> reports;
  StudentGradeReportLoadedState(this.reports);
  @override
  List<Object?> get props => [];
}

class StudentGradeReportFailureState extends StudentGradeReportState {
  @override
  List<Object?> get props => [];
}
