import 'dart:convert';
import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:project3_ui/entities/assignment.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:project3_ui/entities/grade_report.dart';

import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';
import 'package:project3_ui/repositories/login/implementation/http_login_repo.dart';

class HttpAssignmentRepo implements AssignmentRepository {
  final String uri = "127.0.0.1:5455";
  @override
  Future<List<Assignment>> getPendingAssignments(int studentID) async {
    //Create the request
    var response = await http.get((Uri.parse('$uri/assignments/pending')),
        headers: {'Authorization': studentID.toString()});

    // Decode the json, turn it into a list of assignments, and return it
    return (json.decode(response.body) as List)
        .map((i) => Assignment.fromJson(i))
        .toList();
  }

  //Could not get the ability to read multiple files. Only reads the first file.
  Future<Uint8List> readThroughFiles(File f) async {
    return await f.readAsBytes();
  }

  @override
  Future<Assignment> postAssignment(String name, String desc, DateTime dueDate,
      List<File> inputs, List<File> outputs) async {
    int id = GetIt.I<LiveLoginRepository>().getCurrentUser()!.id;
    Assignment a = Assignment(name, dueDate, desc);
    var client = http.Client();
    try {
      var request =
          new http.MultipartRequest("POST", Uri.parse('${uri} + /assignments'));
      request.fields['name'] = name;
      request.fields['dueDate'] = dueDate.toString();
      request.fields['desc'] = desc;
      request.files.add(http.MultipartFile.fromBytes(
          'inputFiles', await inputs[0].readAsBytes()));
      request.files.add(http.MultipartFile.fromBytes(
          'outputFiles', await outputs[0].readAsBytes()));
      request.headers['Authorization'] = 'id: $id,';
      request.headers['Content-Type'] = 'application/json';
      request.send().then((response) {
        if (response.statusCode == 201) {
          return a;
        } else {
          throw Exception("Could not post assignment");
        }
      });
      return a;
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
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
