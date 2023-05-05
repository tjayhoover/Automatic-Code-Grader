import 'dart:convert';

import 'package:project3_ui/entities/assignment.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';

class HttpAssignmentRepo implements AssignmentRepository {
  final String uri = "127.0.0.1:5455";
  @override
  List<Assignment> getPendingAssignments(int sutdentID) {
    throw UnimplementedError();
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
}
