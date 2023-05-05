import 'package:project3_ui/entities/assignment_grade_report.dart';
import 'package:project3_ui/repositories/instructor_grade_reports/interface/instructor_grade_report_repository_interface.dart';

class InstructorGradeReportRepositoryMock
    implements InstructorGradeReportRepository {
  @override
  Future<List<AssignmentGradeReport>> getAllReports(String assignment) async {
    List<AssignmentGradeReport> gradeReport = [
      AssignmentGradeReport(
          1,
          "Brandon BAU3R (testing: assignment $assignment)",
          DateTime.now(),
          5,
          10),
      AssignmentGradeReport(2, "Hob Goblin", DateTime.now(), 9, 10),
      AssignmentGradeReport(3, "Kenneth Yarnall", DateTime.now(), 2, 10),
    ];
    return gradeReport;
  }

  @override
  Future<List<String>> getAllAssignmentNames() async {
    List<String> assignmentList = [
      "Hello, World!",
      "Volim",
      "Beekeeper",
      "Prepare a Wumpus Roast",
    ];
    return assignmentList;
  }
}
