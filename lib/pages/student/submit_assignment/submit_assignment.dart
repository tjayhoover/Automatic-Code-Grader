import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/pages/student/submit_assignment/assignment_view.dart';
import 'package:project3_ui/cubits/assignments/assignments_cubit.dart';
import 'package:project3_ui/cubits/states/assignment_state.dart';
import 'package:intl/intl.dart';

class AssignmentsView extends StatelessWidget {
  const AssignmentsView({super.key});

  void selectAssignment() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pending Assignments')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(14.0),
            child: Text(
              'Pending Assignments',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: BlocBuilder<AssignmentListCubit, AssignmentState>(
              builder: (context, state) {
                if (state is AssignmentsLoadedState) {
                  return ListView.builder(
                    itemCount: state.assignments.length,
                    itemBuilder: (context, index) {
                      final assignment = state.assignments[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AssignmentView(assignment: assignment)),
                          );
                        },
                        title: Center(child: Text(assignment.name)),
                        subtitle: Center(
                          child: Text(
                              "Due: ${DateFormat.yMMMd().format(assignment.dueDate)}"),
                        ),
                      );
                    },
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
