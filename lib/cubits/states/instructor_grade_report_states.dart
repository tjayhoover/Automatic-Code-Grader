import 'package:equatable/equatable.dart';
import 'package:project3_ui/entities/grade_report.dart';

abstract class InstructorGradeReportState extends Equatable {}

class InstructorGradeReportLoadingState extends InstructorGradeReportState {
  @override
  List<Object?> get props => [];
}

class InstructorGradeReportLoadedState extends InstructorGradeReportState {
  final List<GradeReport> gradeReportList;
  InstructorGradeReportLoadedState(this.gradeReportList);

  @override
  List<Object?> get props => [];
}

class InstructorGradeReportFailureState extends InstructorGradeReportState {
  @override
  List<Object?> get props => [];
}
