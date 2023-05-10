import 'package:project3_ui/entities/assignment_grade_report.dart';
import 'package:project3_ui/entities/assignment.dart';
import 'package:project3_ui/repositories/instructor_grade_reports/interface/instructor_grade_report_repository_interface.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project3_ui/url.dart';

class HTTPInstructorGradeReportRepository
    implements InstructorGradeReportRepository {
  @override
  Future<List<AssignmentGradeReport>> getAllReports(
      String assignment, int curId) async {
    // Two requests are required to complete this. Firstly, we must request
    // a list of all assignments. Then we must find the correct one that matches
    // with our assignment name, and make a second request for its grade report.
    var assignmentResponse = await http.get(Uri.parse('$serverURL/assignments'),
        // TODO: Does the server require authorization to GET the assignment list?
        headers: {
          "Authorization": '${curId.toString()},',
          "Content-type": "application/json,"
        });

    if (assignmentResponse.statusCode == 200) {
      List<Assignment> assignmentList =
          (json.decode(assignmentResponse.body) as List)
              .map((e) => Assignment.fromJson(e))
              .toList();

      Assignment target =
          assignmentList.firstWhere((e) => e.name == assignment, orElse: () {
        throw Exception('getAllReports: no assignment with this name found.');
      });

      int targetID = target.id;

      var gradeResponse = await http.get(
          Uri.parse('$serverURL/assignment/$targetID/report'),
          // TODO: We almost definitely need authorization for this endpoint,
          // right? So, how do we gain access to the current user from here?
          headers: {
            "Authorization": '${curId.toString()},',
            "Content-type": "application/json,"
          });

      if (gradeResponse.statusCode == 200) {
        return (json.decode(gradeResponse.body) as List)
            .map((e) => AssignmentGradeReport.fromJson(e))
            .toList();
      } else {
        throw Exception(
            'getAllReports: Failed to retrieve a list of grade reports for this assignemnt.');
      }
    } else {
      throw Exception(
          'getAllReports: Failed to retrieve a list of assignments.');
    }
  }

  @override
  Future<List<String>> getAllAssignmentNames(int curId) async {
    var assignmentResponse = await http.get(Uri.parse('$serverURL/assignments'),
        headers: {
          "Authorization": '${curId.toString()},',
          "Content-type": "application/json"
        });

    if (assignmentResponse.statusCode == 200) {
      return (json.decode(assignmentResponse.body) as List)
          .map((e) => Assignment.fromJson(e).name)
          .toList();
    } else {
      throw Exception(
          "getAllAssignmentNames: Failed to retrieve a list of assignments.");
    }
  }
}