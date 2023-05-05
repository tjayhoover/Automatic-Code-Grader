import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/assignments/assignments_cubit.dart';
import 'package:project3_ui/pages/student/submit_assignment/assignment_view.dart';
import 'package:project3_ui/cubits/submissions/submissions_cubit.dart';
import 'package:project3_ui/cubits/states/assignment_state.dart';
import 'package:intl/intl.dart';

import 'package:project3_ui/pages/student/student_grade_report/student_grade_report.dart';
import 'package:project3_ui/cubits/grade_reports/student_grade_report_cubit.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  void selectAssignment() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Dashboard')),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(
                'Pending Assignments',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              width: 500,
              height: 300,
              child: BlocBuilder<AssignmentListCubit, AssignmentState>(
                builder: (context, state) {
                  if (state is AssignmentsLoadedState) {
                    return ListView.builder(
                      itemCount: state.assignments.length,
                      itemBuilder: (context, index) {
                        final assignment = state.assignments[index];
                        return ListTile(
                          onTap: () {
                            var subCubit =
                                BlocProvider.of<SubmissionCubit>(context);
                            subCubit.emitInit(); // Emit the initial state
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
                  } else if (state is AssignmentLoadingState) {
                    return const SizedBox(
                        width: 20,
                        height: 20,
                        child: Center(child: CircularProgressIndicator()));
                  } else {
                    return const Text('Unknown State');
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ElevatedButton(
                child: const Text('Grade Report'),
                onPressed: () {
                  var grCubit = BlocProvider.of<StudentGradeReport>(context);
                  grCubit.reportRequested();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StudentGradeReportPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
