import 'package:flutter/material.dart';
import 'submit_assignment/submit_assignment.dart';

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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SubmissionPage()),
            );
          },
        ),
      ),
    );
  }
}