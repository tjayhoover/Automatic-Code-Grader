import 'package:flutter/material.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const InstructorUploadAssignment()),
              );
            },
          ),
          ElevatedButton(
            child: const Text('View Assignment Grades'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const InstructorGradeReport()),
              );
            },
          ),
        ],
      )),
    );
  }
}
