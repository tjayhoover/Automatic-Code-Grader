import 'dart:convert';

import 'package:project3_ui/entities/assignment.dart';
import 'package:project3_ui/entities/grade_report.dart';
import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class OnlineAssignmentRepository implements AssignmentRepository {
  @override
  Future<List<Assignment>> getPendingAssignments(int studentID) async {
    // Create the request
    // var response = await http.get((Uri.parse('../assignments/pending')),
    //     headers: {'Authorization': studentID.toString()});

    // Test string
    String jsonString =
        '[{"id": 5,"name": "Test x1","dueDate": "2020-07-10 15:00:00.000","description": "hehe"},{"id": 6,"name": "Test x2","dueDate": "2020-07-10 15:00:00.000","description": "hehe"}]';
    // Decode the response, return the list of pending assignments

    // Decode the json, turn it into a list of assignments, and return it
    return (json.decode(jsonString) as List)
        .map((i) => Assignment.fromJson(i))
        .toList();
  }

  @override
  Future<Assignment> postAssignment(String name, String desc, DateTime dueDate,
      List<String> inputs, List<String> outputs) async {
    await Future.delayed(const Duration(seconds: 1));
    return Assignment(1, name, dueDate, desc, inputs: inputs, outputs: outputs);
  }

  @override
  Future<List<int>> submitAssignment(
      int assignmentID, int studentID, File code) async {
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
