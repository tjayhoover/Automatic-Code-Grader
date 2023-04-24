import 'package:flutter/material.dart';


class InstructorHome extends StatelessWidget {
  const InstructorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instructor Dashboard'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Upload Assignment'),
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