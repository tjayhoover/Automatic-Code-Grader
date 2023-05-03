import 'dart:async';
import 'package:project3_ui/entities/grade_report.dart';

abstract class InstructorGradeReportRepository {
  Future<List<GradeReport>> getAllReports();
}
