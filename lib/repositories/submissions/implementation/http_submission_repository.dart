import 'package:project3_ui/repositories/submissions/interface/submission_repository.dart';
import 'package:project3_ui/url.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:project3_ui/entities/grade_report.dart';
import 'dart:convert';

class HTTPSubmissionRepo implements SubmissionRepository {
  @override
  Future<List<int>> submitAssignment(
      int assignmentID, int studentID, String code) async {
    try {
      // Write the string to a temporary file
      final File file = File('../temp.py');
      await file.writeAsString(code);

      print(file.path);

      // Create the request
      var uri =
          Uri.parse('$serverURL/assignments/${assignmentID.toString()}/submit');

      var request = http.MultipartRequest('POST', uri);

      // Fill out the headers with the right info
      request.headers['Authorization'] = '${studentID.toString()},';
      request.headers['Accept'] = 'application/json';
      request.headers['Content-type'] = 'application/json';
      

      // Add the code file

      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      // Send the request
      var response = await request.send();

      print("Submission response code: ${response.statusCode}");

      // Success
      if (response.statusCode == 201) {
        // Get the response stream and convert it to a response object
        final respStr = await response.stream.bytesToString();

        // Decode it to a Grade Report object
        final Map<String, dynamic> parsed = json.decode(respStr);
        print("cases passed:");
        print(parsed["casesPassed"]);

        print("total Cases");
        print(parsed["totalCases"]);

        final GradeReport gr = GradeReport.fromJson(parsed);
        return [gr.casesPassed, gr.totalCases];
      }

      // Failure
      else {
        return [];
      }
    } catch (e) {
      // Debug output
      print(e);
      return [];
    }
  }
}
