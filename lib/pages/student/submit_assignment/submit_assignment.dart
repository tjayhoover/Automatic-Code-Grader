import 'package:flutter/material.dart';

class SubmissionPage extends StatelessWidget {
  const SubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submission Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Submit Assignment'),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const SecondRoute()),
            // );
          },
        ),
      ),
    );
  }
}
