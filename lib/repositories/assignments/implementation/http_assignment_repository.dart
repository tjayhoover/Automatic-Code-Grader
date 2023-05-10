import 'dart:convert';
import 'dart:typed_data';
import 'package:project3_ui/url.dart';
import 'package:project3_ui/entities/assignment.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';

class HttpAssignmentRepo implements AssignmentRepository {
  @override
  Future<List<Assignment>> getPendingAssignments(int studentID) async {
    try {
      //Create the request
      var response = await http
          .get((Uri.parse('$serverURL/assignments/pending')), headers: {
        'Authorization': '${studentID.toString()},',
        'Accept': 'application/json'
      });

      // Decode the json, turn it into a list of assignments, and return it
      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((i) => Assignment.fromJson(i))
            .toList();
      } else {
        return List.empty();
      }
    } catch (e) {
      // debug output
      print(e);
      return List.empty();
    }
  }

  //Could not get the ability to read multiple files. Only reads the first file.
  Future<Uint8List> readThroughFiles(File f) async {
    return await f.readAsBytes();
  }

  @override
  Future<Assignment> postAssignment(String name, String desc, DateTime dueDate,
      List<String> inputs, List<String> outputs, int id) async {
    Assignment a = Assignment(name, dueDate, desc);

    print("posting assignments");
    try {
      var response = await http.post((Uri.parse('$serverURL/assignments')),
          body: jsonEncode(a.toJson()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': '$id,'
          });
      print("Cooper response");
      print(response.statusCode.toString());
      if (response.statusCode == 201) {
        final Assignment body = Assignment.fromJson(json.decode(response.body));
        return body;
      } else {
        throw Exception("Could not post assignment");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
