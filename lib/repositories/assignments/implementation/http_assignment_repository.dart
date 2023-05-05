import 'dart:convert';

import 'package:project3_ui/entities/assignment.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:project3_ui/entities/grade_report.dart';

import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';

class HttpAssignmentRepo implements AssignmentRepository {
  final String uri = "127.0.0.1:5455";
  @override
  Future<List<Assignment>> getPendingAssignments(int sutdentID) async {
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
      List<File> inputs, List<File> outputs) async {
    Assignment a =
        Assignment(name, dueDate, desc, inputs: inputs, outputs: outputs);
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse('${uri} + /assignments'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'id 1,'
          },
          body: jsonEncode(a.toJson()));
      if (response.statusCode == 201) {
        return Assignment.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Posting assignment failed");
      }
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
    throw UnimplementedError();
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
