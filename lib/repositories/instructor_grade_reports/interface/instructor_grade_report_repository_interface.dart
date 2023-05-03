import 'dart:async';
import 'package:project3_ui/entities/assignment_grade_report.dart';

abstract class InstructorGradeReportRepository {
  Future<List<AssignmentGradeReport>> getAllReports();
  Future<List<String>> getAllAssignmentNames();
}
