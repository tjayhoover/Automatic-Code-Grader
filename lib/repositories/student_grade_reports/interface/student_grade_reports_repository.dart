import 'package:project3_ui/entities/grade_report.dart';

abstract class StudentGradeReportRepository {
  Future<List<GradeReport>> getGradeReports(int studentID);
}
