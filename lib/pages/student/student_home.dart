import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/blocs/assignment_list/assignment_list_bloc.dart';
import 'package:project3_ui/cubits/assignment_list/assignment_list_cubit.dart';
import 'submit_assignment/test_submit_assignment.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Submit Assignment'),
          onPressed: () {
            //var assignmentBloc = BlocProvider.of<AssignmentListBloc>(context);
            //assignmentBloc.add(LoadAssignments());
            var assignmentCubit = BlocProvider.of<AssignmentListCubit>(context);
            assignmentCubit.loadAssignments();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AssignmentsView()),
            );
          },
        ),
      ),
    );
  }
}
