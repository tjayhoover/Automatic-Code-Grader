import 'package:equatable/equatable.dart';
import 'package:project3_ui/entities/assignment_grade_report.dart';

abstract class InstructorGradeReportState extends Equatable {}

class InstructorGradeReportLoadingState extends InstructorGradeReportState {
  @override
  List<Object?> get props => [];
}

class InstructorGradeReportLoadedState extends InstructorGradeReportState {
  final List<String> assignmentNames;
  final List<AssignmentGradeReport> gradeReportList;
  InstructorGradeReportLoadedState(this.assignmentNames, this.gradeReportList);

  @override
  List<Object?> get props => [assignmentNames, gradeReportList];
}

class InstructorGradeReportFailureState extends InstructorGradeReportState {
  @override
  // TODO: Is this a decent way of checking whether the state exists?
  List<Object?> get props => [false];
}
