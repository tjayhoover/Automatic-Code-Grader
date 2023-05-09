import 'dart:async';
import 'package:project3_ui/entities/assignment_grade_report.dart';

abstract class InstructorGradeReportRepository {
  Future<List<AssignmentGradeReport>> getAllReports(String assignment, int curId);
  Future<List<String>> getAllAssignmentNames(int curId);
}
