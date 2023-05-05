import 'package:universal_io/io.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/assignments/assignments_cubit.dart';

import '../../../cubits/states/assignment_state.dart';

class UploadAssignment extends StatefulWidget {
  const UploadAssignment({super.key});

  @override
  UploadAssignmentState createState() {
    return UploadAssignmentState();
  }
}

class UploadAssignmentState extends State<UploadAssignment> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController inputController = TextEditingController();
  TextEditingController outputController = TextEditingController();

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  late List<File> inputs;
  late List<File> outputs;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void chooseInputs() async {
    inputs = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowMultiple: true, allowedExtensions: ['txt']);
    for (var f in result!.files) {
      var curFile = f.bytes;
      inputs.add(File.fromRawPath(curFile!));
    }
  }

  void chooseOutputs() async {
    outputs = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowMultiple: true, allowedExtensions: ['txt']);
    for (var f in result!.files) {
      var curFile = f.bytes;
      outputs.add(File.fromRawPath(curFile!));
    }
  }

  Widget buildTextFields(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Assignment name"),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
          ),
          buildDueDatePicker(context),
          TextField(
            controller: descController,
            decoration:
                const InputDecoration(hintText: "Assignment description"),
            maxLines: 6,
          ),
          const Padding(
            padding: EdgeInsets.all(10),
          ),
          Row(
            children: [
              ElevatedButton(
                child: Text("Upload input file"),
                onPressed: () {
                  chooseInputs();
                },
              ),
              Spacer(),
              ElevatedButton(
                child: Text("Upload output file"),
                onPressed: () {
                  chooseOutputs();
                },
              ),
            ],
          ),
          ElevatedButton(
            child: const Text("Upload Assignment"),
            onPressed: () {
              DateTime dueDate = DateTime(
                  date.year, date.month, date.day, time.hour, time.minute);
              BlocProvider.of<UploadAssignmentCubit>(context).uploadAssignment(
                  nameController.text,
                  dueDate,
                  descController.text,
                  inputs,
                  outputs);
            },
          )
        ],
      ),
    );
  }

  Widget buildDueDatePicker(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text("Due date"),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 5));
                    setState(() {
                      date = DateTime(selectedDate!.year, selectedDate.month,
                          selectedDate.day);
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.date_range),
                      Text('Date: ${date.month}/${date.day}/${date.year}')
                    ],
                  )),
              ElevatedButton(
                  onPressed: () async {
                    TimeOfDay? selectedTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    setState(() {
                      time = TimeOfDay(
                          hour: selectedTime!.hour,
                          minute: selectedTime.minute);
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.timer),
                      Text('Time: ${time.hour}:${time.minute}')
                    ],
                  ))
            ])
          ],
        ));
  }

  Widget buildBlocBuilder(BuildContext context) {
    return BlocConsumer<UploadAssignmentCubit, AssignmentState>(
        listener: (context, state) {
      if (state is AssignmentLoadedState) {
        SnackBar snackBar = const SnackBar(
          content: Text("Assignment was uploaded!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      if (state is AssignmentInitialState) {
        return buildTextFields(context);
      } else if (state is AssignmentFailureState) {
        return buildTextFields(context);
      } else if (state is AssignmentLoadingState) {
        return Dialog(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Upload Assignment")),
        body: Center(
            child: Column(
          children: [buildBlocBuilder(context)],
        )));
  }
}
