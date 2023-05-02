import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _assignment.name,
                style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w900,
                    fontSize: 40),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Due: ${DateFormat.yMMMd().format(_assignment.dueDate)}",
              style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _assignment.desc,
              style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Text('Choose File'),
              onPressed: () async {
                var subCubit = BlocProvider.of<SubmissionCubit>(context);
                var path = await chooseCodeFile();
                if (path != null) {
                  subCubit.submitAssignment(_assignment.id, 69, File(path));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<SubmissionCubit, SubmissionState>(
                builder: (context, state) {
              if (state is SubmissionInitialState) {
                return Text(
                  "Submit your assignment!",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                );
              } else if (state is SubmissionLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is SubmissionLoadedState) {
                return Text(
                  "You passed ${state.casesPassed} out of ${state.totalCases} test cases.",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                );
              } else if (state is SubmissionFailureState) {
                return Text(
                  "Submission Failed. Try again.",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                );
              } else {
                return Text(
                  "Unknown State.",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                );
              }
            }),
          ),
        ]),
      ),
    );
  }
}
