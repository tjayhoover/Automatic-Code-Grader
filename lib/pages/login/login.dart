import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/assignments/assignments_cubit.dart';
import 'package:project3_ui/cubits/login/login_cubit.dart';
import 'package:project3_ui/cubits/states/user_state.dart';

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
                  onPressed: () async {
                    var loginCubit = BlocProvider.of<LoginCubit>(context);
                    loginCubit.logIn(usrnmCtrl.text, pwCtrl.text);
                  },
                ),
              ),
            ),
            BlocConsumer<LoginCubit, UserState>(listener: (context, state) {
              if (state is UserLoadedState) {
                if (state.user.role == "student") {
                  var bloc = BlocProvider.of<AssignmentListCubit>(context);
                  bloc.loadPendingAssignments(5);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StudentHome()),
                  );
                } else if (state.user.role == "instructor") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InstructorHome()),
                  );
                } else if (state.user.role == "admin") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminHome()),
                  );
                }
              } else if (state is UserFailureState) {
                showDialog<void>(
                    context: context,
                    builder: (BuildContext context) => const AlertDialog(
                          title: Text('Error'),
                          content: Text('Login failed. Try again.'),
                        ));
              }
            }, builder: (context, state) {
              if (state is UserInitialState) {
                return const Text('');
              } else if (state is UserLoadingState) {
                return const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserLoadedState) {
                // What should we do here?
                return const Text("");
              } else {
                return Text(state.toString());
              }
            }),
          ],
        ),
      ),
    );
  }
}
