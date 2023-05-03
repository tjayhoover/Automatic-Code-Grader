import 'package:project3_ui/entities/grade_report.dart';
import 'package:project3_ui/repositories/instructor_grade_reports/interface/instructor_grade_report_repository_interface.dart';

class InstructorGradeReportRepositoryMock
    implements InstructorGradeReportRepository {
  @override
  Future<List<GradeReport>> getAllReports() async {
    List<GradeReport> gradeReport = [
      GradeReport(1, "Add Two Numbers", DateTime.now(), DateTime.now(),
          "Add two numbers together.", 5, 10),
      GradeReport(2, "Beekeeper", DateTime.now(), DateTime.now(),
          "Something about counting letters.", 9, 10),
      GradeReport(3, "Slay the Wumpus", DateTime.now(), DateTime.now(),
          "Hunt, kill, field-dress, cook, and serve a Wumpus filet.", 45, 50)
    ];
    return gradeReport;
  }
}
