import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project3_ui/cubits/assignments/assignments_cubit.dart';
import 'package:project3_ui/cubits/states/assignment_state.dart';
import 'package:project3_ui/entities/assignment.dart';

class AssignmentView extends StatelessWidget {
  AssignmentView({super.key, required Assignment assignment}) {
    _assignment = assignment;
  }

   void chooseCodeFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    String ret = "";
    //print(result?.names.first);
  }

  late Assignment _assignment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assignment View')),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(_assignment.name),
          Text(_assignment.desc),
          Text(_assignment.dueDate.toString()),
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
