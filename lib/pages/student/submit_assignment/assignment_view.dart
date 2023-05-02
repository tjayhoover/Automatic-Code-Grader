import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'package:project3_ui/cubits/assignments/assignments_cubit.dart';
import 'package:project3_ui/cubits/states/submission_state.dart';
import 'package:project3_ui/entities/assignment.dart';

class AssignmentView extends StatelessWidget {
  AssignmentView({super.key, required Assignment assignment}) {
    _assignment = assignment;
  }

  Future<String?> chooseCodeFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    return result?.paths.first;
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
            onPressed: () async {
              var subCubit = BlocProvider.of<SubmissionCubit>(context);
              var path = await chooseCodeFile();
              if (path != null) {
                subCubit.submitAssignment(_assignment.id, 69, File(path));
              }
            },
          ),
          BlocBuilder<SubmissionCubit, SubmissionState>(
              builder: (context, state) {
            if (state is SubmissionInitialState) {
              return const Text("Submit your assignment!");
            } else if (state is SubmissionLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is SubmissionLoadedState) {
              return Text(
                  "You passed ${state.casesPassed} out of ${state.totalCases} test cases.");
            } else if (state is SubmissionFailureState) {
              return const Text("Submission Failed. Try again.");
            } else {
              return const Text("Unknown State.");
            }
          }),
        ]),
      ),
    );
  }
}
