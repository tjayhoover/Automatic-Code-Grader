// Adam Rilatt
// 24 April 2023
// Software Architecture -- Project 3 InstructorGradeReport

import 'package:flutter/material.dart';

class InstructorGradeReport extends StatelessWidget {
  const InstructorGradeReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instructor Grade Report'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Goober button activate'),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const SubmissionPage()),
            // );
          },
        ),
      ),
    );
  }
}
