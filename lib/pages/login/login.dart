import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/assignments/assignments_cubit.dart';

import '../student/student_home.dart';
import '../instructor/instructor_home.dart';
import '../admin/admin_home.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  final usrnmCtrl = TextEditingController();
  final pwCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Log in as student'),
              onPressed: () {
                var bloc = BlocProvider.of<AssignmentListCubit>(context);
                bloc.loadPendingAssignments(5);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StudentHome()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Log in as an instructor'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InstructorHome()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Log in as an admin'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminHome()),
                );
              },
            ),
            SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                    decoration: const InputDecoration(hintText: 'Username'),
                    controller: usrnmCtrl),
              ),
            ),
            SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    controller: pwCtrl),
              ),
            ),
            SizedBox(
              width: 250,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: ElevatedButton(
                  child: const Text('Log In'),
                  onPressed: () {
                    // userCubit.login(usrCtrl.text, pwctrl.txt);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
