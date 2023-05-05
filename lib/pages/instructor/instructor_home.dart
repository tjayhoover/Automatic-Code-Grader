import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/assignments/assignments_cubit.dart';
import 'package:project3_ui/cubits/grade_reports/instructor_grade_report_cubit.dart';

import '../instructor/upload_assignment/upload_assignment.dart';
import '../instructor/grade_report/grade_report.dart';

class InstructorHome extends StatelessWidget {
  const InstructorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instructor Dashboard'),
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            child: const Text('Upload Assignment'),
            onPressed: () {
              BlocProvider.of<UploadAssignmentCubit>(context).resetState();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UploadAssignment()),
              );
            },
          ),
          ElevatedButton(
            child: const Text('View Assignment Grades'),
            onPressed: () {
              BlocProvider.of<InstructorGradeReport>(context).loadReport();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const InstructorGradeReportWidget()),
              );
            },
          ),
        ],
      )),
    );
  }
}
