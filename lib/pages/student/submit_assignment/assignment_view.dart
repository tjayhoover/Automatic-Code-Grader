import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:project3_ui/cubits/submissions/submissions_cubit.dart';
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
  String? path;
  var txt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assignment View')),
      body: Center(
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _assignment.name,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 40),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Due: ${DateFormat.yMMMd().format(_assignment.dueDate)}",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Your Code:",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          SizedBox(
            width: 500,
            height: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: txt,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Or",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      child: const Text('Choose File'),
                      onPressed: () async {
                        path = await chooseCodeFile();
                        File(path!).readAsString().then((String contents) {
                          txt.text = contents;
                        });
                      }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 8),
            child: BlocConsumer<SubmissionCubit, SubmissionState>(
                listener: (context, state) {
              if (state is SubmissionLoadedState) {
                showDialog<void>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Grade'),
                          content: Text(
                              'You passed ${state.casesPassed} out of ${state.totalCases} test cases.'),
                        ));
              }
            }, builder: (context, state) {
              if (state is SubmissionInitialState) {
                return ElevatedButton(
                  child: const Text('Submit Assignment'),
                  onPressed: () async {
                    var subCubit = BlocProvider.of<SubmissionCubit>(context);
                    final File file = File('../temp.py');
                    await file.writeAsString(txt.text);
                    subCubit.submitAssignment(_assignment.id, 68, file);
                  },
                );
              } else if (state is SubmissionLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is SubmissionLoadedState) {
                return ElevatedButton(
                  child: const Text('Resubmit Assignment'),
                  onPressed: () async {
                    print("submitting");
                    var subCubit = BlocProvider.of<SubmissionCubit>(context);
                    final File file = File('../temp.py');
                    await file.writeAsString(txt.text);
                    subCubit.submitAssignment(_assignment.id, 68, file);
                  },
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
