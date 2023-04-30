import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:project3_ui/entities/assignment.dart';

class SubmissionPage extends StatelessWidget {
  SubmissionPage({super.key});

  void chooseCodeFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    String ret = "";
    //print(result?.names.first);
  }

  final assignments = [
    Assignment(22, "Test 1", DateTime.now(), "This is a test"),
    Assignment(23, "Test 2", DateTime.now(), "This is the second test"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submission Page'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ListView.builder(
            itemCount: assignments.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(assignments[index].name),
                subtitle: Text(assignments[index].dueDate.toString()),
                trailing: Text(assignments[index].desc),
              );
            },
          ),
          ElevatedButton(
            child: const Text('Choose File'),
            onPressed: () {
              chooseCodeFile();
            },
          ),
        ]),
      ),
    );
  }
}
