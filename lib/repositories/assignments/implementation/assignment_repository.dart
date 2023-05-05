import 'dart:convert';

import 'package:project3_ui/entities/assignment.dart';
import 'package:project3_ui/entities/grade_report.dart';
import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class MockAssignmentRepository implements AssignmentRepository {
  @override
  Future<List<Assignment>> getPendingAssignments(int studentID) async {
    List<Assignment> assignmentList = [
      Assignment(1, "Test One", DateTime.now(), "This is test #1."),
      Assignment(2, "Test2", DateTime.now(), "This is amazing"),
    ];
    return assignmentList;
  }

  @override
  Future<Assignment> postAssignment(String name, String desc, DateTime dueDate,
      List<String> inputs, List<String> outputs) async {
    await Future.delayed(const Duration(seconds: 1));
    return Assignment(1, name, dueDate, desc, inputs: inputs, outputs: outputs);
  }

  @override
  Future<List<int>> submitAssignment(int assignmentID, int studentID, File code) async {
    var uri = Uri.https('example.com', 'create');
    var request = http.MultipartRequest('POST', uri);
    // Add the user id to the header
    request.headers["Authorization"] = studentID.toString();
    // Add the mutlipart file
    request.files.add(await http.MultipartFile.fromPath('package', code.path));
    // Send the request
    var response = await request.send();
    // Get the response stream and convert it to a response object
    final respStr = await response.stream.bytesToString();
    // Decode it to a Grade Report object
    final Map<String, dynamic> parsed = json.decode(respStr);
    final GradeReport gr = GradeReport.fromJson(parsed);

    // Print debug info
    if (response.statusCode == 200) {
      print(
          'Uploaded! Name:${gr.name} Cases Passed: ${gr.casesPassed} Total Cases: ${gr.totalCases}');
    }

    // Return the cases passed and total cases
    return [gr.casesPassed, gr.totalCases];
  }
}
