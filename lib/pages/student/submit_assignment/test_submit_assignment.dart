import 'package:flutter/material.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/assignment_list/assignment_list_bloc.dart';
import '../../../states/assignment_state.dart';

class AssignmentsView extends StatelessWidget {
  const AssignmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assignment List View')),
      body: BlocBuilder<AssignmentListBloc, AssignmentState>(
        builder: (context, state) {
          if (state is AssignmentsLoadedState) {
            return ListView.builder(
              itemCount: state.assignments.length,
              itemBuilder: (context, index) {
                final assignment = state.assignments[index];
                return ListTile(
                  title: Text(assignment.name),
                  subtitle: Text(assignment.desc),
                );
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}