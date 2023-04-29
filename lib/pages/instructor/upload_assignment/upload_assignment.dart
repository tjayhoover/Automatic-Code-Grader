import 'package:flutter/material.dart';

class InstructorUploadAssignment extends StatelessWidget {
  const InstructorUploadAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instructor Dashboard'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('yeah this doesn\'t do anything yet'),
          onPressed: () {
            //Navigator.push(
            //  context,
            //  MaterialPageRoute(
            //      builder: (context) => const InstructorUploadAssignment()),
            //);
          },
        ),
      ),
    );
  }
}
