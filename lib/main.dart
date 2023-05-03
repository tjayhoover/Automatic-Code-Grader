import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project3_ui/cubits/assignments/assignments_cubit.dart';
import 'package:project3_ui/cubits/grade_reports/student_grade_report_cubit.dart';
import 'package:project3_ui/cubits/users/users_cubit.dart';
import 'package:project3_ui/cubits/grade_reports/instructor_grade_report_cubit.dart';
import 'pages/login/login.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (BuildContext context) => AssignmentListCubit()),
      BlocProvider(create: (BuildContext context) => UserListCubit()),
      BlocProvider(create: (BuildContext context) => UploadAssignmentCubit()),
      BlocProvider(create: (BuildContext context) => UserDeleteCubit()),
      BlocProvider(create: (BuildContext context) => UserCreateCubit()),
      BlocProvider(create: (BuildContext context) => StudentGradeReport()),
      BlocProvider(create: (BuildContext context) => InstructorGradeReport()),
    ],
    child: MaterialApp(
      title: 'Code Grading Tool',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LogInPage(),
    ),
  ));
}
