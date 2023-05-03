import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project3_ui/pages/student/student_grade_report/student_grade_report.dart';
import 'package:project3_ui/cubits/assignments/assignments_cubit.dart';
import 'submit_assignment/submit_assignment.dart';
import 'package:project3_ui/cubits/grade_reports/student_grade_report_cubit.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Submit Assignment'),
              onPressed: () {
                var assignmentCubit =
                    BlocProvider.of<AssignmentListCubit>(context);
                assignmentCubit.loadAssignments();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AssignmentsView()),
                );
              },
            ),
            ElevatedButton(
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
          ],
        ),
      ),
    );
  }
}
