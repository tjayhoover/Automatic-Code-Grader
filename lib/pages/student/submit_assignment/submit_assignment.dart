import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class SubmissionPage extends StatelessWidget {
  const SubmissionPage({super.key});

  void chooseCodeFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    String ret = "";
    print(result?.names.first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submission Page'),
      ),
      body: Column(children: [
        ListView(
          children: const [
            Text('Pending Assignments'),
            Text('Hello World'),
          ],
        ),
        ElevatedButton(
          child: const Text('Choose File'),
          onPressed: () {
            chooseCodeFile();
          },
        ),
      ]),
    );
  }
}
