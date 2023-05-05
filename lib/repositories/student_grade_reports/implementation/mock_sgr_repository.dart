import 'package:project3_ui/entities/grade_report.dart';
import 'package:project3_ui/repositories/student_grade_reports/interface/student_grade_reports_repository.dart';

class MockSgrRepository implements StudentGradeReportRepository {
  @override
  Future<List<GradeReport>> getGradeReports(int studentID) async {
    List<GradeReport> reports = [
      GradeReport(
          5, "Test my Grade Report1", DateTime.now(), DateTime.now(), "hehe", 5, 15),
          GradeReport(
          5, "Test my Grade Report2", DateTime.now(), DateTime.now(), "hehe", 8, 15),
          GradeReport(
          5, "Test my Grade Report3", DateTime.now(), DateTime.now(), "hehe", 12, 15),
          GradeReport(
          5, "Test my Grade Report4", DateTime.now(), DateTime.now(), "hehe", 0, 15),
    ];
    return reports;
  }
}
