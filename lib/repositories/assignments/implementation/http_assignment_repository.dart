import 'dart:convert';
import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:project3_ui/url.dart';
import 'package:project3_ui/entities/assignment.dart';
import 'dart:io';
import 'package:http/http.dart' as http;


import 'package:project3_ui/repositories/assignments/interface/assignment_repository.dart';
import 'package:project3_ui/repositories/login/implementation/http_login_repo.dart';

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
      List<File> inputs, List<File> outputs) async {
    int id = GetIt.I<LiveLoginRepository>().getCurrentUser()!.id;
    Assignment a = Assignment(name, dueDate, desc);
    var client = http.Client();
    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse('$serverURL/assignments'));
      request.fields['name'] = name;
      request.fields['dueDate'] = dueDate.toString();
      request.fields['desc'] = desc;
      request.files.add(http.MultipartFile.fromBytes(
          'inputFiles', await inputs[0].readAsBytes()));
      request.files.add(http.MultipartFile.fromBytes(
          'outputFiles', await outputs[0].readAsBytes()));
      request.headers['Authorization'] = '$id,';
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.send().then((response) async {
        if (response.statusCode == 201) {
          var responseStream = await http.Response.fromStream(response);
          final Assignment body =
              Assignment.fromJson(json.decode(responseStream.body));
          return body;
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

  
}
