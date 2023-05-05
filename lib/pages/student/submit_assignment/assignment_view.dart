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

  late final Assignment _assignment;
  final txt = TextEditingController();

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
            child: SizedBox(
              width: 500,
              child: Center(
                child: Text(
                  _assignment.desc,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Paste Your Code",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.tealAccent)),
            child: SizedBox(
              width: 500,
              height: 150,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: txt,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "OR",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // background
                  foregroundColor: Colors.black, // foreground
                ),
                child: const Text('Upload File'),
                onPressed: () async {
                  String? path = await chooseCodeFile();
                  File(path!).readAsString().then((String contents) {
                    txt.text = contents;
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 8),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // background
                    foregroundColor: Colors.white, // foreground
                  ),
                  child: const Text('Submit Assignment'),
                  onPressed: () async {
                    var subCubit = BlocProvider.of<SubmissionCubit>(context);
                    final File file = File('../temp.py');
                    await file.writeAsString(txt.text);
                    subCubit.submitAssignment(_assignment.id, file);
                  },
                );
              } else if (state is SubmissionLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is SubmissionLoadedState) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // background
                    foregroundColor: Colors.white, // foreground
                  ),
                  child: const Text('Resubmit Assignment'),
                  onPressed: () async {
                    var subCubit = BlocProvider.of<SubmissionCubit>(context);
                    final File file = File('../temp.py');
                    await file.writeAsString(txt.text);
                    subCubit.submitAssignment(_assignment.id, file);
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
